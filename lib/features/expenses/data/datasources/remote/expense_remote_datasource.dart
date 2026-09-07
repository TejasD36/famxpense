import '../../../xcore.dart';

abstract interface class ExpenseRemoteDatasource {
  Future<void> createExpense(ExpenseRemoteDto expense);
  Future<void> updateExpense(ExpenseRemoteDto expense);
  Future<List<ExpenseRemoteDto>> fetchExpenses({required String userId});
}
