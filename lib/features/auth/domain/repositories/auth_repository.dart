import '../../data/models/auth_user_model.dart';

abstract class AuthRepository {
  Future<AuthUserModel?> getSavedUser();

  Future<AuthUserModel?> login({required String email, required String password});

  Future<void> logout();
}
