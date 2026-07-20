import '../../xcore.dart';

class DebtLedgerRepositoryImpl implements DebtLedgerRepository {
  final DebtLedgerLocalDatasource _localDatasource;

  DebtLedgerRepositoryImpl({required DebtLedgerLocalDatasource localDatasource}) : _localDatasource = localDatasource;

  @override
  Future<List<DebtLedgerEntity>> getLedgers({required String userId}) async {
    final dtos = await _localDatasource.getLedgers();
    return dtos.where((l) => l.userA == userId || l.userB == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> saveLedger(DebtLedgerEntity ledger) async {
    await _localDatasource.saveLedger(ledger.toDto());
  }

  @override
  Future<void> updateDebt(String userA, String userB, double delta) async {
    final sorted = [userA, userB]..sort();
    final canonicalA = sorted[0];
    final canonicalB = sorted[1];
    final id = '${canonicalA}_$canonicalB';

    if (canonicalA == userB && canonicalB == userA) {
      delta = -delta;
    }

    final all = await _localDatasource.getLedgers();
    final existing = all.where((l) => l.id == id || (l.userA == canonicalA && l.userB == canonicalB)).toList();

    if (existing.isEmpty) {
      await _localDatasource.saveLedger(DebtLedgerDto(
        id: id,
        userA: canonicalA,
        userB: canonicalB,
        netBalance: delta,
        updatedAt: DateTime.now().toUtc(),
      ));
    } else {
      final current = existing.first;
      await _localDatasource.saveLedger(current.copyWith(
        id: id,
        userA: canonicalA,
        userB: canonicalB,
        netBalance: current.netBalance + delta,
        updatedAt: DateTime.now().toUtc(),
      ));
    }
  }
}
