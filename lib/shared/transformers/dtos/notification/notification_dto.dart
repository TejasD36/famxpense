import '../../../../core.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

@HiveType(typeId: HiveTypeIds.notification)
@freezed
sealed class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required NotificationType type,
    @HiveField(3) required String title,
    @HiveField(4) required String message,
    @HiveField(5) String? relatedId,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) @Default(false) bool isRead,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);
}
