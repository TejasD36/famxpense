import '../../xcore.dart';

class ManualDepositLocalDatasourceImpl extends BaseHiveService<ManualDepositDto> implements ManualDepositLocalDatasource {
  ManualDepositLocalDatasourceImpl() : super(Hive.box<ManualDepositDto>(HiveBoxes.manualDeposits));

  @override
  Future<void> save(ManualDepositDto deposit) async {
    await put(key: deposit.id, value: deposit);
  }

  @override
  Future<List<ManualDepositDto>> getByAccount(String accountId) async {
    return box.values.where((d) => d.accountId == accountId).toList();
  }

  @override
  Future<void> delete(String key) async {
    await super.delete(key);
  }
}
