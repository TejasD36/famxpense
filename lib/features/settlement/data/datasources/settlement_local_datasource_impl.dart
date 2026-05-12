import '../../xcore.dart';

class SettlementLocalDatasourceImpl extends BaseHiveService<SettlementDto> implements SettlementLocalDatasource {
  SettlementLocalDatasourceImpl() : super(Hive.box<SettlementDto>(HiveBoxes.settlements));

  @override
  Future<void> saveSettlement(SettlementDto settlement) async {
    await put(key: settlement.id, value: settlement);
  }

  @override
  Future<List<SettlementDto>> getSettlements() async {
    return getAll();
  }

  @override
  Future<List<SettlementDto>> getPendingSettlements() async {
    return box.values.where((settlement) => settlement.status == SettlementStatus.pending).toList();
  }

  @override
  Future<void> deleteSettlement(String settlementId) async {
    await delete(settlementId);
  }
}
