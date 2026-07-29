import '../../xcore.dart';

class DebtLedgerRepositoryImpl implements DebtLedgerRepository {
  final DebtLedgerLocalDatasource _localDatasource;
  final DebtLedgerRemoteDatasource _remoteDatasource;

  DebtLedgerRepositoryImpl({
    required DebtLedgerLocalDatasource localDatasource,
    required DebtLedgerRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<List<DebtLedgerEntity>> getLedgers({required String userId}) async {
    final dtos = await _localDatasource.getLedgers();
    return dtos.where((l) => l.userA == userId || l.userB == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> saveLedger(DebtLedgerEntity ledger) async {
    await _localDatasource.saveLedger(ledger.toDto());
    try {
      await _remoteDatasource.saveLedger(ledger);
    } catch (e, stackTrace) {
      AppLogger.warning('Debt ledger remote sync failed');
      AppLogger.error('Debt ledger remote sync error', e, stackTrace);
    }
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

    DebtLedgerDto dto;
    if (existing.isEmpty) {
      dto = DebtLedgerDto(
        id: id,
        userA: canonicalA,
        userB: canonicalB,
        netBalance: delta,
        updatedAt: DateTime.now().toUtc(),
      );
    } else {
      final current = existing.first;
      dto = current.copyWith(
        id: id,
        userA: canonicalA,
        userB: canonicalB,
        netBalance: current.netBalance + delta,
        updatedAt: DateTime.now().toUtc(),
      );
    }
    await _localDatasource.saveLedger(dto);
    try {
      await _remoteDatasource.saveLedger(dto.toEntity());
    } catch (e, stackTrace) {
      AppLogger.warning('Debt ledger remote update failed');
      AppLogger.error('Debt ledger remote update error', e, stackTrace);
    }
  }
}
