import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

part 'notification_bloc.freezed.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationLocalDatasource _datasource;

  NotificationBloc({required NotificationLocalDatasource datasource})
    : _datasource = datasource,
      super(const NotificationState.initial()) {
    on<LoadNotificationsEvent>(_onLoad);
    on<MarkNotificationReadEvent>(_onMarkRead);
    on<DeleteNotificationEvent>(_onDelete);
  }

  Future<void> _onLoad(LoadNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(const NotificationState.loading());
    try {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      if (userId.isEmpty) {
        emit(const NotificationState.loaded([]));
        return;
      }
      final all = await _datasource.getNotifications();
      final mine = all.where((n) => n.userId == userId).toList();
      mine.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(NotificationState.loaded(mine));
    } catch (e) {
      emit(NotificationState.error(e.toString()));
    }
  }

  Future<void> _onMarkRead(MarkNotificationReadEvent event, Emitter<NotificationState> emit) async {
    await _datasource.markAsRead(event.notificationId);
    add(const LoadNotificationsEvent());
  }

  Future<void> _onDelete(DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    await _datasource.deleteNotification(event.notificationId);
    add(const LoadNotificationsEvent());
  }
}
