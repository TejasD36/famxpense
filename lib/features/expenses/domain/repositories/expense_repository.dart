import '../../xcore.dart';

abstract interface class ExpenseRepository {
  Future<void> addExpense(ExpenseEntity expense);

  Future<void> updateExpense({
    required ExpenseEntity original,
    required ExpenseEntity edited,
  });

  Future<void> deleteExpense(ExpenseEntity expense);

  ExpenseEditPolicyResult canEditExpense(ExpenseEntity expense);

  Future<List<ExpenseEntity>> getExpenses();

  Future<List<ExpenseEntity>> getCurrentMonthExpenses();
}
