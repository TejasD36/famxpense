import '../../../xcore.dart';

class ExpenseLocalDatasourceImpl extends BaseHiveService<ExpenseDto> implements ExpenseLocalDatasource {
  ExpenseLocalDatasourceImpl() : super(Hive.box<ExpenseDto>(HiveBoxes.expenses));

  @override
  Future<void> saveExpense(ExpenseDto expense) async {
    await put(key: expense.id, value: expense);
  }

  @override
  Future<void> saveExpenses(List<ExpenseDto> expenses) async {
    final map = {for (final expense in expenses) expense.id: expense};

    await box.putAll(map);
  }

  @override
  Future<List<ExpenseDto>> getExpenses({required String ownerUserId}) async {
    return box.values.where((expense) {
      return expense.participants.any((p) => p.userId == ownerUserId);
    }).toList();
  }

  @override
  Future<List<ExpenseDto>> getPendingExpenses({required String ownerUserId}) async {
    return box.values.where((expense) {
      return expense.ownerUserId == ownerUserId && expense.syncStatus != SyncStatus.synced;
    }).toList();
  }

  @override
  Future<List<ExpenseDto>> getCurrentMonthExpenses({required String ownerUserId}) async {
    final now = DateTime.now();

    return box.values.where((expense) {
      final isCurrentMonth = expense.expenseDate.month == now.month && expense.expenseDate.year == now.year;

      return expense.participants.any((p) => p.userId == ownerUserId) && isCurrentMonth;
    }).toList();
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    await delete(expenseId);
  }

  @override
  Future<void> clearOldSyncedExpenses({required String ownerUserId}) async {
    final now = DateTime.now();

    final itemsToDelete = box.values.where((expense) {
      final isCurrentMonth = expense.expenseDate.month == now.month && expense.expenseDate.year == now.year;

      return expense.ownerUserId == ownerUserId && !isCurrentMonth && expense.syncStatus == SyncStatus.synced;
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
