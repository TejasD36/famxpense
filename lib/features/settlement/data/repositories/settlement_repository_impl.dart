import '../../xcore.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  final SettlementLocalDatasource _localDatasource;

  SettlementRepositoryImpl({required SettlementLocalDatasource localDatasource}) : _localDatasource = localDatasource;

  @override
  Future<List<SettlementEntity>> getSettlements({required String userId}) async {
    final dtos = await _localDatasource.getSettlements();
    return dtos.where((s) => s.fromUserId == userId || s.toUserId == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> createSettlement(SettlementEntity settlement) async {
    await _localDatasource.saveSettlement(settlement.toDto());
  }
}
