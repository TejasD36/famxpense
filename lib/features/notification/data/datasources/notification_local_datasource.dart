import '../../xcore.dart';

abstract interface class NotificationLocalDatasource {
  Future<void> saveNotification(NotificationDto notification);

  Future<List<NotificationDto>> getNotifications();

  Future<void> markAsRead(String notificationId);

  Future<void> deleteNotification(String notificationId);
}
