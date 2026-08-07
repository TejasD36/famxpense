part of 'notification_bloc.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.loadNotifications() = LoadNotificationsEvent;
  const factory NotificationEvent.markAsRead({required String notificationId}) =
      MarkNotificationReadEvent;
  const factory NotificationEvent.delete({required String notificationId}) =
      DeleteNotificationEvent;
}
