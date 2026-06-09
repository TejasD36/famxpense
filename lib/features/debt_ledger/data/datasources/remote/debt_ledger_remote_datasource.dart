import '../../../xcore.dart';

abstract interface class DebtLedgerRemoteDatasource {
  Future<void> saveLedger(DebtLedgerEntity ledger);
  Future<List<DebtLedgerEntity>> fetchLedgers({required String userId});
}