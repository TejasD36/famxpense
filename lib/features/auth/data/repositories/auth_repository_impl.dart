import '../../domain/repositories/auth_repository.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();
  // AuthRepositoryImpl(this._localDataSource);

  // final AuthLocalDataSource _localDataSource;

  @override
  Future<AuthUserModel?> getSavedUser() async {
    return null;
    // return _localDataSource.getSavedUser();
  }

  @override
  Future<AuthUserModel?> login({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    late final AuthUserModel user;

    if (email == 'admin@notes.com' && password == 'admin123') {
      user = const AuthUserModel(userId: 'admin_1', email: 'admin@notes.com', role: 'admin');
    } else if (email == 'user@notes.com' && password == 'user123') {
      user = const AuthUserModel(userId: 'user_1', email: 'user@notes.com', role: 'user');
    } else {
      return null;
    }

    // await _localDataSource.saveUser(user);

    return user;
  }

  @override
  Future<void> logout() async {
    return;
    // return _localDataSource.clear();
  }
}
