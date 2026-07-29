import '../../xcore.dart';

class SavingsLocalDatasourceImpl extends BaseHiveService<MonthlySavingDto> implements SavingsLocalDatasource {
  SavingsLocalDatasourceImpl() : super(Hive.box<MonthlySavingDto>(HiveBoxes.monthlySavings));

  @override
  Future<void> saveSnapshot(MonthlySavingDto snapshot) async {
    await put(key: snapshot.id, value: snapshot);
  }

  @override
  Future<List<MonthlySavingDto>> getAllSnapshots() async {
    return getAll();
  }

  @override
  Future<List<MonthlySavingDto>> getSnapshotsByAccount(String accountId) async {
    return box.values.where((s) => s.accountId == accountId).toList();
  }

  @override
  Future<MonthlySavingDto?> getSnapshot(String accountId, int year, int month) async {
    return box.values.where((s) => s.accountId == accountId && s.year == year && s.month == month).firstOrNull;
  }
}
