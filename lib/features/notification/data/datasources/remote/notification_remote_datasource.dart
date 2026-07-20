import '../../../xcore.dart';

abstract interface class NotificationRemoteDatasource {
  Future<void> uploadNotification(NotificationDto notification);
  Future<List<NotificationDto>> fetchNotifications({required String userId});
  Stream<List<NotificationDto>> streamNotifications({required String userId});
}
