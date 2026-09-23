import '../../xcore.dart';

abstract interface class IncomeLocalDatasource {
  Future<void> save(IncomeDto income);
  Future<List<IncomeDto>> fetchAll();
  Future<List<IncomeDto>> getByAccount(String accountId);
  Future<void> deleteIncome(String incomeId);
}
