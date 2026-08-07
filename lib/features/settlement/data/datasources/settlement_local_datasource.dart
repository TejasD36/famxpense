import '../../xcore.dart';

abstract interface class SettlementLocalDatasource {
  Future<void> saveSettlement(SettlementDto settlement);

  Future<List<SettlementDto>> getSettlements();

  Future<SettlementDto?> getSettlementById(String settlementId);

  Future<List<SettlementDto>> getPendingSettlements();

  Future<void> deleteSettlement(String settlementId);

  Future<void> updateSettlementStatus(
    String settlementId,
    SettlementStatus status,
  );
}
