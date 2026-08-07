import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import '../../../debt_ledger/domain/usecases/compute_debt_usecase.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
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
    _validateExpense(expense);
    AppLogger.info('Adding expense: ${expense.title}');

    final existingExpenses = await _localDatasource.getExpenses(
      ownerUserId: expense.paidByUserId,
    );
    final existing = existingExpenses
        .where((item) => item.id == expense.id)
        .firstOrNull;
    if (existing != null) {
      if (existing.syncStatus != SyncStatus.synced) {
        final existingEntity = existing.toEntity();
        await _applyAccountBalance(existingEntity);
        await _applyDebtEffect(existingEntity);
        try {
          await _remoteDatasource.createExpense(
            existing.toEntity().toRemoteDto(),
          );
          await _localDatasource.saveExpense(
            existing.copyWith(syncStatus: SyncStatus.synced),
          );
        } catch (e, stackTrace) {
          AppLogger.error('Duplicate expense retry failed', e, stackTrace);
        }
      }
      return;
    }

    final pendingExpense = expense.copyWith(syncStatus: SyncStatus.pending);

    /// Apply balance/debt effects BEFORE persisting: a failed balance apply
    /// must not leave a pending expense that later uploads and deducts.
    await _applyAccountBalance(pendingExpense);
    await _applyDebtEffect(pendingExpense);
    await _localDatasource.saveExpense(pendingExpense.toDto());

    try {
      AppLogger.firebase(
        'Uploading expense: '
        '${expense.id}',
      );

      await _remoteDatasource.createExpense(pendingExpense.toRemoteDto());

      final syncedExpense = pendingExpense.copyWith(
        syncStatus: SyncStatus.synced,
      );

      await _localDatasource.saveExpense(syncedExpense.toDto());

      AppLogger.success('Expense synced successfully');
    } catch (e, stackTrace) {
      AppLogger.warning(
        'Expense sync failed. '
        'Stored as pending.',
      );

      AppLogger.error('Expense upload error', e, stackTrace);
    }
  }

  void _validateExpense(ExpenseEntity expense) {
    final authenticatedUserId = _authLocalDatasource.getUserId();
    if (authenticatedUserId == null ||
        authenticatedUserId != expense.paidByUserId ||
        expense.ownerUserId != expense.paidByUserId) {
      throw StateError('Expense owner does not match the authenticated user');
    }
    if (expense.id.trim().isEmpty || expense.title.trim().isEmpty) {
      throw ArgumentError('Expense ID and title are required');
    }

    final totalPaise = _validatedPaise(expense.amount, field: 'amount');
    if (totalPaise <= 0) {
      throw ArgumentError.value(
        expense.amount,
        'amount',
        'Expense amount must be greater than zero',
      );
    }
    if (expense.participants.isEmpty) {
      throw ArgumentError('An expense must have at least one participant');
    }

    final participantIds = <String>{};
    var participantTotalPaise = 0;
    for (final participant in expense.participants) {
      if (participant.userId.trim().isEmpty ||
          !participantIds.add(participant.userId)) {
        throw ArgumentError(
          'Expense participant IDs must be non-empty and unique',
        );
      }
      final sharePaise = _validatedPaise(
        participant.amount,
        field: 'participant amount',
      );
      if (sharePaise < 0) {
        throw ArgumentError.value(
          participant.amount,
          'participant amount',
          'Participant shares cannot be negative',
        );
      }
      participantTotalPaise += sharePaise;
    }
    if (participantTotalPaise != totalPaise) {
      throw ArgumentError(
        'Participant shares must exactly equal the expense amount',
      );
    }

    if (expense.expenseType == ExpenseType.personal) {
      if (expense.participants.length != 1 ||
          expense.participants.single.userId != expense.paidByUserId) {
        throw ArgumentError(
          'A personal expense must be assigned entirely to its payer',
        );
      }
      return;
    }

    if (expense.participants.length < 2 ||
        !participantIds.contains(expense.paidByUserId)) {
      throw ArgumentError(
        'A shared expense must include its payer and another participant',
      );
    }
  }

  int _validatedPaise(double amount, {required String field}) {
    if (!amount.isFinite) {
      throw ArgumentError.value(amount, field, 'Amount must be finite');
    }
    final scaled = amount * 100;
    final paise = scaled.round();
    if ((scaled - paise).abs() > 0.000001) {
      throw ArgumentError.value(
        amount,
        field,
        'Amounts cannot have more than two decimal places',
      );
    }
    return paise;
  }

  Future<void> _applyAccountBalance(ExpenseEntity expense) async {
    if (expense.accountId == null) return;

    try {
      final accounts = await _accountRepository.getAccounts(
        userId: expense.paidByUserId,
      );
      final account = accounts.firstWhere((a) => a.id == expense.accountId);
      final updatedAccount = await _accountRepository.adjustBalance(
        expense.accountId!,
        -expense.amount,
        mutationId: 'expense-balance-${expense.id}',
      );
      AppLogger.success(
        'Account balance deducted: ${account.accountName} → ₹${updatedAccount.currentBalance}',
      );

      if (updatedAccount.isSavings) {
        final savingsRepo = sl<SavingsRepository>();
        await savingsRepo.computeCurrentMonth(
          updatedAccount.id,
          updatedAccount.currentBalance,
          updatedAccount.monthlySavingsGoal,
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Account balance deduction failed', e, stackTrace);
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  Future<void> _applyDebtEffect(ExpenseEntity expense) async {
    if (expense.expenseType != ExpenseType.shared) return;

    try {
      await _computeDebtUsecase(
        paidByUserId: expense.paidByUserId,
        participants: expense.participants,
        totalAmount: expense.amount,
        mutationIdPrefix: 'expense-debt-${expense.id}',
      );
      AppLogger.success('Debt ledger updated');

      try {
        final localDatasource = sl<DebtLedgerLocalDatasource>();
        final remoteLedgers = await sl<DebtLedgerRemoteDatasource>()
            .fetchLedgers(userId: expense.paidByUserId);
        final localById = {
          for (final ledger in await localDatasource.getLedgers())
            ledger.id: ledger,
        };
        for (final remote in remoteLedgers) {
          final local = localById[remote.id];
          final pendingDelta =
              local?.pendingMutations.values.fold<double>(
                0,
                (total, delta) => total + delta,
              ) ??
              0;
          await localDatasource.saveLedger(
            remote.toDto().copyWith(
              netBalance: remote.netBalance + pendingDelta,
              pendingMutations: local?.pendingMutations ?? const {},
              appliedMutationIds: local?.appliedMutationIds ?? const [],
            ),
          );
        }
      } catch (_) {
        // The local mutation remains durable and will merge on reconnect.
      }
    } catch (e, stackTrace) {
      AppLogger.error('Debt computation failed', e, stackTrace);
      Error.throwWithStackTrace(e, stackTrace);
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

    final expenses = await _localDatasource.getCurrentMonthExpenses(
      ownerUserId: userId,
    );

    return expenses.map((e) => e.toEntity()).toList();
  }
}
