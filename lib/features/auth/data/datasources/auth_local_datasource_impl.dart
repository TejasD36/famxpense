import '../../xcore.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Box _box = Hive.box(HiveBoxes.auth);

  static const _userIdKey = 'user_id';

  @override
  Future<void> saveUserId(String userId) async {
    await _box.put(_userIdKey, userId);
  }

  @override
  String? getUserId() {
    return _box.get(_userIdKey);
  }

  @override
  Future<void> clearSession() async {
    await _box.clear();
  }
}
