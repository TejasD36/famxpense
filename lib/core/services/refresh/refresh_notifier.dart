import 'package:flutter/foundation.dart';

class RefreshNotifier extends ChangeNotifier {
  bool _hasData = false;

  bool get hasData => _hasData;

  void notifyDataChanged() {
    _hasData = true;
    notifyListeners();
  }

  void reset() {
    _hasData = false;
  }
}
