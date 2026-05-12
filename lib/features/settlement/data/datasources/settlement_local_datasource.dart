import '../../xcore.dart';

abstract interface class SettlementLocalDatasource {
  Future<void> saveSettlement(SettlementDto settlement);

  Future<List<SettlementDto>> getSettlements();

  Future<List<SettlementDto>> getPendingSettlements();

  Future<void> deleteSettlement(String settlementId);
}
