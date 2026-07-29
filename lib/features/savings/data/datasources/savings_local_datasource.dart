import '../../xcore.dart';

abstract interface class SavingsLocalDatasource {
  Future<void> saveSnapshot(MonthlySavingDto snapshot);
  Future<List<MonthlySavingDto>> getAllSnapshots();
  Future<List<MonthlySavingDto>> getSnapshotsByAccount(String accountId);
  Future<MonthlySavingDto?> getSnapshot(String accountId, int year, int month);
}
