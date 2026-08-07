part of 'notification_bloc.dart';

@freezed
sealed class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;
  const factory NotificationState.loading() = NotificationLoading;
  const factory NotificationState.loaded(List<NotificationDto> notifications) =
      NotificationLoaded;
  const factory NotificationState.error(String message) = NotificationError;
}
