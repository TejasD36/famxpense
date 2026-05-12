import '../../xcore.dart';

abstract interface class DebtLedgerLocalDatasource {
  Future<void> saveLedger(DebtLedgerDto ledger);

  Future<List<DebtLedgerDto>> getLedgers();

  Future<void> deleteLedger(String ledgerId);
}
