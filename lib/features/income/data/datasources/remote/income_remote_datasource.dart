import '../../../xcore.dart';

abstract interface class IncomeRemoteDatasource {
  Future<void> createIncome(IncomeDto income);
  Future<List<IncomeDto>> fetchIncomes({required String userId});
  Future<void> deleteIncome(String incomeId);
}
