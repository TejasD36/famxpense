import '../../xcore.dart';

abstract interface class SettlementRepository {
  Future<List<SettlementEntity>> getSettlements({required String userId});
  Future<SettlementEntity?> getSettlementById(String settlementId);
  Future<void> createSettlement(SettlementEntity settlement);
  Future<void> updateSettlementStatus(
    String settlementId,
    SettlementStatus status,
  );
  Future<SettlementEntity?> resolveSettlement({
    required String settlementId,
    required SettlementStatus status,
    required DateTime resolvedAt,
    required String resolutionType,
    required String? fromAccountId,
    required String? toAccountId,
  });
  Future<void> deleteSettlement(String settlementId);
  Future<bool> hasPendingSettlement(String fromUserId, String toUserId);
}
