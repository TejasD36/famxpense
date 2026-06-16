import 'dart:async';

import '../../../core.dart';
import '../../../features/notification/data/datasources/notification_local_datasource.dart';
import '../../../features/notification/data/datasources/remote/notification_remote_datasource.dart';

class RealtimeNotificationService {
  final NotificationRemoteDatasource _remote;
  final NotificationLocalDatasource _local;
  StreamSubscription? _subscription;

  RealtimeNotificationService(this._remote, this._local);

  void startListening(String userId) {
    _subscription?.cancel();
    _subscription = _remote.streamNotifications(userId: userId).listen((notifications) async {
      final localIds = (await _local.getNotifications()).map((n) => n.id).toSet();
      var hasNew = false;
      for (final n in notifications) {
        if (!localIds.contains(n.id)) {
          await _local.saveNotification(n);
          hasNew = true;
        }
      }
      if (hasNew) {
        sl<RefreshNotifier>().notifyDataChanged();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
