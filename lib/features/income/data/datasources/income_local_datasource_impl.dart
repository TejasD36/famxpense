import '../../xcore.dart';

class IncomeLocalDatasourceImpl extends BaseHiveService<IncomeDto>
    implements IncomeLocalDatasource {
  IncomeLocalDatasourceImpl() : super(Hive.box<IncomeDto>(HiveBoxes.incomes));

  @override
  Future<void> save(IncomeDto income) async {
    await put(key: income.id, value: income);
  }

  @override
  Future<List<IncomeDto>> fetchAll() async {
    return getAll();
  }

  @override
  Future<List<IncomeDto>> getByAccount(String accountId) async {
    return box.values.where((i) => i.accountId == accountId).toList();
  }

  @override
  Future<void> deleteIncome(String incomeId) async {
    await delete(incomeId);
  }
}
