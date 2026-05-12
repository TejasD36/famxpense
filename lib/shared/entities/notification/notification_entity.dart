import '../../../core.dart';

part 'notification_entity.freezed.dart';
part 'notification_entity.g.dart';

@freezed
sealed class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String message,
    String? relatedId,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => _$NotificationEntityFromJson(json);
}
