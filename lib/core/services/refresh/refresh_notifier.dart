import 'package:flutter/foundation.dart';

class RefreshNotifier extends ChangeNotifier {
  void notifyDataChanged() => notifyListeners();
}
