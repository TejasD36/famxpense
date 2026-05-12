import '../../xcore.dart';

class DebtLedgerLocalDatasourceImpl extends BaseHiveService<DebtLedgerDto> implements DebtLedgerLocalDatasource {
  DebtLedgerLocalDatasourceImpl() : super(Hive.box<DebtLedgerDto>(HiveBoxes.debtLedger));

  @override
  Future<void> saveLedger(DebtLedgerDto ledger) async {
    await put(key: ledger.id, value: ledger);
  }

  @override
  Future<List<DebtLedgerDto>> getLedgers() async {
    return getAll();
  }

  @override
  Future<void> deleteLedger(String ledgerId) async {
    await delete(ledgerId);
  }
}
