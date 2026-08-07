import '../../xcore.dart';

class SavingsLocalDatasourceImpl extends BaseHiveService<MonthlySavingDto>
    implements SavingsLocalDatasource {
  SavingsLocalDatasourceImpl()
    : super(Hive.box<MonthlySavingDto>(HiveBoxes.monthlySavings));

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
  Future<MonthlySavingDto?> getSnapshot(
    String accountId,
    int year,
    int month,
  ) async {
    final matches = box.values
        .where(
          (s) => s.accountId == accountId && s.year == year && s.month == month,
        )
        .toList();
    if (matches.isEmpty) return null;
    matches.sort(_compareNewestFirst);
    return matches.first;
  }

  int _compareNewestFirst(MonthlySavingDto a, MonthlySavingDto b) {
    final aUpdated = a.updatedAt ?? DateTime.utc(a.year, a.month);
    final bUpdated = b.updatedAt ?? DateTime.utc(b.year, b.month);
    final byUpdatedAt = bUpdated.compareTo(aUpdated);
    if (byUpdatedAt != 0) return byUpdatedAt;
    if (a.isCompleted != b.isCompleted) return a.isCompleted ? -1 : 1;
    return a.id.compareTo(b.id);
  }
}
