import '../../xcore.dart';

class NotificationLocalDatasourceImpl extends BaseHiveService<NotificationDto> implements NotificationLocalDatasource {
  NotificationLocalDatasourceImpl() : super(Hive.box<NotificationDto>(HiveBoxes.notifications));

  @override
  Future<void> saveNotification(NotificationDto notification) async {
    await put(key: notification.id, value: notification);
  }

  @override
  Future<List<NotificationDto>> getNotifications() async {
    return getAll();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final notification = get(notificationId);

    if (notification == null) return;

    await put(key: notificationId, value: notification.copyWith(isRead: true));
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await delete(notificationId);
  }
}
