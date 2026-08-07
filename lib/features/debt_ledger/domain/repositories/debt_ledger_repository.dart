import '../../xcore.dart';

abstract interface class DebtLedgerRepository {
  Future<List<DebtLedgerEntity>> getLedgers({required String userId});
  Future<void> saveLedger(DebtLedgerEntity ledger);
  Future<void> updateDebt(
    String userA,
    String userB,
    double delta, {
    String? mutationId,
  });
}
