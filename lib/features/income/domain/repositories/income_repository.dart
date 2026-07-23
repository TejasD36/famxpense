import '../../xcore.dart';

abstract interface class IncomeRepository {
  Future<void> addIncome(IncomeEntity income);
  Future<List<IncomeEntity>> getAllIncomes();
  Future<List<IncomeEntity>> getIncomesByAccount(String accountId);
  Future<void> deleteIncome(String incomeId);
}
