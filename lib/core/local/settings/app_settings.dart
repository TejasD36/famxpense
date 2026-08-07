import '../../../core.dart';

class AppSettings {
  static const _boxName = HiveBoxes.settings;
  static String _key(String userId) => 'default_account_id_$userId';

  static Future<Box> get _box async => await Hive.openBox(_boxName);

  static Future<String?> getDefaultAccountId({required String userId}) async {
    final box = await _box;
    return box.get(_key(userId)) as String?;
  }

  static Future<void> setDefaultAccountId({
    required String userId,
    String? accountId,
  }) async {
    final box = await _box;
    if (accountId == null) {
      await box.delete(_key(userId));
    } else {
      await box.put(_key(userId), accountId);
    }
  }
}
