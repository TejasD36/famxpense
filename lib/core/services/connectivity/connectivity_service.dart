import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final InternetConnectionChecker _checker;
  StreamSubscription<InternetConnectionStatus>? _subscription;
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  final _statusController = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChanged => _statusController.stream;

  ConnectivityService() : _checker = InternetConnectionChecker.instance;

  Future<void> startMonitoring() async {
    _subscription?.cancel();
    _isOnline = await _checker.hasConnection;
    _statusController.add(_isOnline);
    _subscription = _checker.onStatusChange.listen((status) {
      _isOnline = status == InternetConnectionStatus.connected;
      _statusController.add(_isOnline);
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() {
    stopMonitoring();
    _statusController.close();
  }
}
