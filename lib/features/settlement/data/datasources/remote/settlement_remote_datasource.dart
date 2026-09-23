import '../../../xcore.dart';

abstract interface class SettlementRemoteDatasource {
  Future<void> createSettlement(SettlementEntity settlement);
  Future<List<SettlementEntity>> fetchSettlements({required String userId});
  Future<SettlementEntity?> fetchSettlementById(String settlementId);
  Future<void> updateSettlementStatus(
    String settlementId,
    SettlementStatus status,
  );
  Future<SettlementEntity> resolveSettlement({
    required String settlementId,
    required SettlementStatus status,
    required DateTime resolvedAt,
    required String resolutionType,
    required String? fromAccountId,
    required String? toAccountId,
  });
  Future<void> deleteSettlement(String settlementId);
}
