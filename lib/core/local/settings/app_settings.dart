import '../../../core.dart';

class AppSettings {
  static const _boxName = HiveBoxes.settings;
  static String _key(String userId) => 'default_account_id_$userId';
  static String _syncKey(String userId, String field) =>
      'sync_${field}_$userId';

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

  static Future<DateTime?> getSyncTime({
    required String userId,
    required String field,
  }) async {
    final value = (await _box).get(_syncKey(userId, field));
    return value is DateTime ? value : null;
  }

  static Future<bool?> getSyncResult({required String userId}) async {
    final value = (await _box).get(_syncKey(userId, 'result'));
    return value is bool ? value : null;
  }

  static Future<void> recordSyncAttempt({required String userId}) async {
    await (await _box).put(_syncKey(userId, 'attempt'), DateTime.now());
  }

  static Future<void> recordSyncResult({
    required String userId,
    required bool success,
  }) async {
    final box = await _box;
    final now = DateTime.now();
    await box.put(_syncKey(userId, 'result'), success);
    await box.put(_syncKey(userId, 'finished'), now);
    if (success) await box.put(_syncKey(userId, 'success'), now);
  }
}
