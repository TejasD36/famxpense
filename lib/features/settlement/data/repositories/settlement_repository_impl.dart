import '../../xcore.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  final SettlementLocalDatasource _localDatasource;
  final SettlementRemoteDatasource _remoteDatasource;

  SettlementRepositoryImpl({
    required SettlementLocalDatasource localDatasource,
    required SettlementRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<List<SettlementEntity>> getSettlements({required String userId}) async {
    final dtos = await _localDatasource.getSettlements();
    return dtos.where((s) => s.fromUserId == userId || s.toUserId == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<SettlementEntity?> getSettlementById(String settlementId) async {
    final local = await _localDatasource.getSettlementById(settlementId);
    if (local != null) return local.toEntity();
    try {
      return await _remoteDatasource.fetchSettlementById(settlementId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createSettlement(SettlementEntity settlement) async {
    await _localDatasource.saveSettlement(settlement.toDto());
  }

  @override
  Future<void> updateSettlementStatus(String settlementId, SettlementStatus status) async {
    await _localDatasource.updateSettlementStatus(settlementId, status);
  }
}
