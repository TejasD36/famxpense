import '../../../xcore.dart';

abstract interface class DebtLedgerRemoteDatasource {
  Future<void> saveLedger(DebtLedgerEntity ledger);
  Future<void> adjustDebt({
    required String userA,
    required String userB,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
  });
  Future<List<DebtLedgerEntity>> fetchLedgers({required String userId});
}
