import '../../xcore.dart';

abstract interface class ExpenseLocalDatasource {
  Future<void> saveExpense(ExpenseDto expense);

  Future<void> saveExpenses(List<ExpenseDto> expenses);

  Future<List<ExpenseDto>> getExpenses();

  Future<List<ExpenseDto>> getPendingExpenses();

  Future<List<ExpenseDto>> getCurrentMonthExpenses();

  Future<void> deleteExpense(String expenseId);

  Future<void> clearOldSyncedExpenses();

  Future<void> clearAll();
}
