import '../../xcore.dart';

class ExpenseLocalDatasourceImpl extends BaseHiveService<ExpenseDto> implements ExpenseLocalDatasource {
  ExpenseLocalDatasourceImpl() : super(Hive.box<ExpenseDto>(HiveBoxes.expenses));

  @override
  Future<void> saveExpense(ExpenseDto expense) async {
    await put(key: expense.id, value: expense);
  }

  @override
  Future<void> saveExpenses(List<ExpenseDto> expenses) async {
    for (final expense in expenses) {
      await saveExpense(expense);
    }
  }

  @override
  Future<List<ExpenseDto>> getExpenses() async {
    return getAll();
  }

  @override
  Future<List<ExpenseDto>> getPendingExpenses() async {
    return box.values.where((expense) => expense.syncStatus != SyncStatus.synced).toList();
  }

  @override
  Future<List<ExpenseDto>> getCurrentMonthExpenses() async {
    final now = DateTime.now();

    return box.values.where((expense) {
      return expense.expenseDate.month == now.month && expense.expenseDate.year == now.year;
    }).toList();
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    await delete(expenseId);
  }

  @override
  Future<void> clearOldSyncedExpenses() async {
    final now = DateTime.now();

    final itemsToDelete = box.values.where((expense) {
      final isCurrentMonth = expense.expenseDate.month == now.month && expense.expenseDate.year == now.year;

      return !isCurrentMonth && expense.syncStatus == SyncStatus.synced;
    }).toList();

    for (final item in itemsToDelete) {
      await delete(item.id);
    }
  }

  @override
  Future<void> clearAll() async {
    await clear();
  }
}
