import '../../core.dart';

part 'partnership_status.g.dart';

@HiveType(typeId: HiveTypeIds.partnershipStatus)
enum PartnershipStatus {
  @HiveField(0)
  pending,

  @HiveField(1)
  accepted,

  @HiveField(2)
  rejected,
}
