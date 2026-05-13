import '../../xcore.dart';

abstract interface class ExpenseRepository {
  Future<void> addExpense(ExpenseEntity expense);

  Future<List<ExpenseEntity>> getExpenses();

  Future<List<ExpenseEntity>> getCurrentMonthExpenses();
}
