import '../../../../core.dart';
import 'user_local_datasource.dart';

class UserLocalDatasourceImpl extends BaseHiveService<UserDto> implements UserLocalDatasource {
  UserLocalDatasourceImpl() : super(Hive.box<UserDto>(HiveBoxes.users));

  @override
  UserDto? getCurrentUser() {
    final userId = Hive.box(HiveBoxes.auth).get('userId');

    if (userId == null) {
      return null;
    }

    return get(userId);
  }
}
