import '../../../../core.dart';

abstract class BaseHiveService<T> {
  final Box<T> box;

  BaseHiveService(this.box);

  Future<void> put({required String key, required T value}) async {
    await box.put(key, value);

    AppLogger.hive('[${box.name}] PUT → $key');
  }

  T? get(String key) {
    AppLogger.hive('[${box.name}] GET → $key');

    return box.get(key);
  }

  List<T> getAll() {
    AppLogger.hive('[${box.name}] GET ALL');

    return box.values.toList();
  }

  Future<void> delete(String key) async {
    await box.delete(key);

    AppLogger.hive('[${box.name}] DELETE → $key');
  }

  Future<void> clear() async {
    await box.clear();

    AppLogger.hive('[${box.name}] CLEAR');
  }

  bool containsKey(String key) {
    final contains = box.containsKey(key);

    AppLogger.hive(
      '[${box.name}] '
      'CONTAINS → $key = $contains',
    );

    return contains;
  }
}
