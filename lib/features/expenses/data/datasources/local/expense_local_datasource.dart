import '../../../xcore.dart';

abstract interface class ExpenseLocalDatasource {
  Future<void> saveExpense(ExpenseDto expense);
  Future<void> saveExpenses(List<ExpenseDto> expenses);
  Future<List<ExpenseDto>> getExpenses({required String ownerUserId});
  Future<List<ExpenseDto>> getPendingExpenses({required String ownerUserId});
  Future<List<ExpenseDto>> getCurrentMonthExpenses({required String ownerUserId});
  Future<void> deleteExpense(String expenseId);
  Future<void> clearOldSyncedExpenses({required String ownerUserId});
  Future<void> clearAll();
}
