import '../../../xcore.dart';

abstract interface class SettlementRemoteDatasource {
  Future<void> createSettlement(SettlementEntity settlement);
  Future<List<SettlementEntity>> fetchSettlements({required String userId});
  Future<SettlementEntity?> fetchSettlementById(String settlementId);
  Future<void> updateSettlementStatus(String settlementId, SettlementStatus status);
  Stream<List<SettlementEntity>> streamPendingSettlements({required String userId});
}
