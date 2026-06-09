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
    final all = await _localDatasource.getLedgers();
    final existing = all.where((l) {
      return (l.userA == userA && l.userB == userB) || (l.userA == userB && l.userB == userA);
    }).toList();

    if (existing.isEmpty) {
      final ledger = DebtLedgerDto(
        id: const Uuid().v4(),
        userA: userA,
        userB: userB,
        netBalance: delta,
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDatasource.saveLedger(ledger);
    } else {
      final current = existing.first;
      final currentA = current.userA;
      final currentB = current.userB;

      double newBalance;
      if (currentA == userA && currentB == userB) {
        newBalance = current.netBalance + delta;
      } else {
        /// reversed — userA == current.userB, so delta applies in opposite direction
        newBalance = current.netBalance - delta;
      }

      final updated = current.copyWith(netBalance: newBalance, updatedAt: DateTime.now().toUtc());
      await _localDatasource.saveLedger(updated);
    }
  }
}
