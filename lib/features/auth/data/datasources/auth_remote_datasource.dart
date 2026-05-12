import '../../xcore.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserDto> register({required String name, String? nickname, required String email, required String password});

  Future<UserDto> login({required String email, required String password});

  Future<void> forgotPassword({required String email});

  Future<void> logout();

  Future<UserDto?> getCurrentUser();
}
