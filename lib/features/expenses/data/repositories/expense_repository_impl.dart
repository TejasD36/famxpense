import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/domain/usecases/compute_debt_usecase.dart';
import '../../xcore.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDatasource _localDatasource;
  final AuthLocalDatasource _authLocalDatasource;
  final ExpenseRemoteDatasource _remoteDatasource;
  final ComputeDebtUsecase _computeDebtUsecase;
  final AccountRepository _accountRepository;

  ExpenseRepositoryImpl({
    required ExpenseLocalDatasource localDatasource,
    required AuthLocalDatasource authLocalDatasource,
    required ExpenseRemoteDatasource remoteDatasource,
    required ComputeDebtUsecase computeDebtUsecase,
    required AccountRepository accountRepository,
  }) : _localDatasource = localDatasource,
       _authLocalDatasource = authLocalDatasource,
       _remoteDatasource = remoteDatasource,
       _computeDebtUsecase = computeDebtUsecase,
       _accountRepository = accountRepository;

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    AppLogger.info('Adding expense: ${expense.title}');

    final pendingExpense = expense.copyWith(syncStatus: SyncStatus.pending);

    await _localDatasource.saveExpense(pendingExpense.toDto());

    try {
      AppLogger.firebase(
        'Uploading expense: '
        '${expense.id}',
      );

      await _remoteDatasource.createExpense(pendingExpense.toRemoteDto());

      final syncedExpense = pendingExpense.copyWith(syncStatus: SyncStatus.synced);

      await _localDatasource.saveExpense(syncedExpense.toDto());

      AppLogger.success('Expense synced successfully');
    } catch (e, stackTrace) {
      AppLogger.warning(
        'Expense sync failed. '
        'Stored as pending.',
      );

      AppLogger.error('Expense upload error', e, stackTrace);
    }

    /// Deduct from account balance
    if (expense.accountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: expense.paidByUserId);
        final account = accounts.firstWhere((a) => a.id == expense.accountId);
        final newBalance = account.currentBalance - expense.amount;
        await _accountRepository.updateBalance(expense.accountId!, newBalance);
        AppLogger.success('Account balance deducted: ${account.accountName} → ₹$newBalance');
      } catch (e, stackTrace) {
        AppLogger.error('Account balance deduction failed', e, stackTrace);
      }
    }

    /// Compute debt for shared expenses
    if (expense.expenseType == ExpenseType.shared) {
      try {
        await _computeDebtUsecase(
          paidByUserId: expense.paidByUserId,
          participants: expense.participants,
          totalAmount: expense.amount,
        );
        AppLogger.success('Debt ledger updated');
      } catch (e, stackTrace) {
        AppLogger.error('Debt computation failed', e, stackTrace);
      }
    }
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    final userId = _authLocalDatasource.getUserId();

    if (userId == null) {
      return [];
    }

    final expenses = await _localDatasource.getExpenses(ownerUserId: userId);

    return expenses.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<ExpenseEntity>> getCurrentMonthExpenses() async {
    final userId = _authLocalDatasource.getUserId();

    if (userId == null) {
      return [];
    }

    final expenses = await _localDatasource.getCurrentMonthExpenses(ownerUserId: userId);

    return expenses.map((e) => e.toEntity()).toList();
  }
}
