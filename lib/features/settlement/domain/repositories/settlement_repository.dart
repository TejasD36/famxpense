import '../../xcore.dart';

abstract interface class SettlementRepository {
  Future<List<SettlementEntity>> getSettlements({required String userId});
  Future<void> createSettlement(SettlementEntity settlement);
}
