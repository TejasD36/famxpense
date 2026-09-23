import '../../xcore.dart';

class SettlementLocalDatasourceImpl extends BaseHiveService<SettlementDto>
    implements SettlementLocalDatasource {
  SettlementLocalDatasourceImpl()
    : super(Hive.box<SettlementDto>(HiveBoxes.settlements));

  @override
  Future<void> saveSettlement(SettlementDto settlement) async {
    await put(key: settlement.id, value: settlement);
  }

  @override
  Future<List<SettlementDto>> getSettlements() async {
    return getAll();
  }

  @override
  Future<SettlementDto?> getSettlementById(String settlementId) async {
    return get(settlementId);
  }

  @override
  Future<List<SettlementDto>> getPendingSettlements() async {
    return box.values
        .where((settlement) => settlement.status == SettlementStatus.pending)
        .toList();
  }

  @override
  Future<void> deleteSettlement(String settlementId) async {
    await delete(settlementId);
  }

  @override
  Future<void> updateSettlementStatus(
    String settlementId,
    SettlementStatus status,
  ) async {
    final s = get(settlementId);
    if (s != null) {
      await put(
        key: settlementId,
        value: s.copyWith(status: status),
      );
    }
  }

  @override
  Future<void> saveResolvedSettlement(SettlementEntity settlement) async {
    await saveSettlement(settlement.toDto());
  }
}
