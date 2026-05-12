import '../../../../core.dart';

extension NotificationDtoMapper on NotificationDto {
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      userId: userId,
      title: title,
      message: message,
      createdAt: createdAt,
      isRead: isRead,
      type: type,
      relatedId: relatedId,
    );
  }
}

extension NotificationEntityMapper on NotificationEntity {
  NotificationDto toDto() {
    return NotificationDto(
      id: id,
      userId: userId,
      title: title,
      message: message,
      createdAt: createdAt,
      isRead: isRead,
      type: type,
      relatedId: relatedId,
    );
  }
}
