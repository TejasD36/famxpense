import '../../../xcore.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  Box? _box;

  Box get _authBox => _box ??= Hive.box(HiveBoxes.auth);

  static const _userIdKey = 'userId';

  @override
  Future<void> saveUserId(String userId) async {
    await _authBox.put(_userIdKey, userId);
  }

  @override
  String? getUserId() {
    return _authBox.get(_userIdKey);
  }

  @override
  Future<void> clearSession() async {
    await _authBox.delete(_userIdKey);
  }

  @override
  Future<void> clearAllLocalData() async {
    final userBoxes = [
      HiveBoxes.users,
      HiveBoxes.expenses,
      HiveBoxes.accounts,
      HiveBoxes.settlements,
      HiveBoxes.partnerships,
      HiveBoxes.debtLedger,
      HiveBoxes.notifications,
      HiveBoxes.manualDeposits,
      HiveBoxes.incomes,
      HiveBoxes.monthlySavings,
      HiveBoxes.transfers,
    ];

    for (final boxName in userBoxes) {
      try {
        final box = Hive.box(boxName);
        await box.clear();
      } catch (_) {
        /// box might not be open
      }
    }
  }
}
