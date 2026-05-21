import '../../xcore.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDatasource _localDatasource;

  final ExpenseRemoteDatasource _remoteDatasource;

  ExpenseRepositoryImpl({required ExpenseLocalDatasource localDatasource, required ExpenseRemoteDatasource remoteDatasource})
    : _localDatasource = localDatasource,
      _remoteDatasource = remoteDatasource;

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
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    final expenses = await _localDatasource.getExpenses();

    return expenses.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<ExpenseEntity>> getCurrentMonthExpenses() async {
    final expenses = await _localDatasource.getCurrentMonthExpenses();

    return expenses.map((e) => e.toEntity()).toList();
  }
}
