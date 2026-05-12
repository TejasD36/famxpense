import '../../xcore.dart';

abstract interface class AuthRepository {
  Future<UserEntity> register({required String name, String? nickname, required String email, required String password});

  Future<UserEntity> login({required String email, required String password});

  Future<void> forgotPassword({required String email});

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}
