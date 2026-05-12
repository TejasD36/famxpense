import '../../../../core.dart';

abstract class BaseHiveService<T> {
  final Box<T> box;

  BaseHiveService(this.box);

  Future<void> put({required String key, required T value}) async {
    await box.put(key, value);
  }

  T? get(String key) {
    return box.get(key);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  Future<void> clear() async {
    await box.clear();
  }

  bool containsKey(String key) {
    return box.containsKey(key);
  }
}
