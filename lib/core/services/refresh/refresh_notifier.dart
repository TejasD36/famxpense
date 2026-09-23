import 'package:flutter/foundation.dart';

class RefreshNotifier extends ChangeNotifier {
  bool _hasData = false;
  String? _lastSyncError;

  bool get hasData => _hasData;
  String? get lastSyncError => _lastSyncError;

  void notifyDataChanged() {
    _hasData = true;
    _lastSyncError = null;
    notifyListeners();
  }

  void notifySyncError(String message) {
    _lastSyncError = message;
    notifyListeners();
  }

  void clearSyncError() {
    _lastSyncError = null;
  }

  void reset() {
    _hasData = false;
  }
}
