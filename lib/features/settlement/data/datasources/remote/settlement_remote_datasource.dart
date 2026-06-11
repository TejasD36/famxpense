import '../../../xcore.dart';

abstract interface class SettlementRemoteDatasource {
  Future<void> createSettlement(SettlementEntity settlement);
  Future<List<SettlementEntity>> fetchSettlements({required String userId});
}
