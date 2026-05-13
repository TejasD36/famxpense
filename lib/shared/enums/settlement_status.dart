import '../../core.dart';

part 'settlement_status.g.dart';

@HiveType(typeId: HiveTypeIds.settlementStatus)
enum SettlementStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  confirmed,
  @HiveField(2)
  rejected,
}
