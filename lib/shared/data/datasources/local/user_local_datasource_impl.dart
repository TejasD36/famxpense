import '../../../../core.dart';

class UserLocalDatasourceImpl extends BaseHiveService<UserDto> implements UserLocalDatasource {
  final Box _authBox;

  UserLocalDatasourceImpl() : _authBox = Hive.box(HiveBoxes.auth), super(Hive.box<UserDto>(HiveBoxes.users));

  @override
  UserDto? getCurrentUser() {
    final userId = _authBox.get('user_id');

    if (userId == null) {
      return null;
    }

    return get(userId);
  }

  @override
  UserDto? getUser(String id) => get(id);

  @override
  Future<void> saveUser(UserDto user) async {
    await put(key: user.id, value: user);
  }
}
