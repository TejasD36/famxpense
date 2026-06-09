import '../../../../core.dart';

abstract interface class UserLocalDatasource {
  UserDto? getCurrentUser();
  UserDto? getUser(String id);
  Future<void> saveUser(UserDto user);
}
