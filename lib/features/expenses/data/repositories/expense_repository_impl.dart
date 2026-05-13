import '../../xcore.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDatasource _localDatasource;

  ExpenseRepositoryImpl({required ExpenseLocalDatasource localDatasource}) : _localDatasource = localDatasource;

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    await _localDatasource.saveExpense(expense.toDto());
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
