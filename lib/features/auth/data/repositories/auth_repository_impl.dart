import '../../xcore.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  final AuthLocalDatasource _localDatasource;

  AuthRepositoryImpl({required AuthRemoteDatasource remoteDatasource, required AuthLocalDatasource localDatasource})
    : _remoteDatasource = remoteDatasource,
      _localDatasource = localDatasource;

  @override
  Future<UserEntity> register({required String name, String? nickname, required String email, required String password}) async {
    final userDto = await _remoteDatasource.register(name: name, nickname: nickname, email: email, password: password);

    await _localDatasource.saveUserId(userDto.id);

    return userDto.toEntity();
  }

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    final userDto = await _remoteDatasource.login(email: email, password: password);

    await _localDatasource.saveUserId(userDto.id);

    return userDto.toEntity();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _remoteDatasource.forgotPassword(email: email);
  }

  @override
  Future<void> logout() async {
    await _remoteDatasource.logout();

    await _localDatasource.clearSession();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userDto = await _remoteDatasource.getCurrentUser();

    if (userDto == null) return null;

    return userDto.toEntity();
  }
}
