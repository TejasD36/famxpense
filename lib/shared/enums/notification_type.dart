import '../../core.dart';

part 'notification_type.g.dart';

@HiveType(typeId: HiveTypeIds.notificationType)
enum NotificationType {
  @HiveField(0)
  partnerRequest,
  @HiveField(1)
  expenseAdded,
  @HiveField(2)
  settlementRequest,
  @HiveField(3)
  settlementConfirmed,
  @HiveField(4)
  settlementRejected,
}
