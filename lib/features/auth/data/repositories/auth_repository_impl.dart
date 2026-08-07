import '../../xcore.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  final AuthLocalDatasource _localDatasource;

  final UserLocalDatasource _userLocalDatasource;
  final SyncService _syncService;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
    required UserLocalDatasource userLocalDatasource,
    required SyncService syncService,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource,
       _userLocalDatasource = userLocalDatasource,
       _syncService = syncService;

  @override
  Future<UserEntity> register({
    required String name,
    required String nickname,
    required String email,
    required String password,
  }) async {
    final userDto = await _remoteDatasource.register(
      name: name,
      nickname: nickname,
      email: email,
      password: password,
    );

    try {
      await _localDatasource.saveUserId(userDto.id);
      await _userLocalDatasource.saveUser(userDto);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to save user data locally after registration',
        e,
        stackTrace,
      );
    }

    return userDto.toEntity();
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userDto = await _remoteDatasource.login(
      email: email,
      password: password,
    );

    await _localDatasource.saveUserId(userDto.id);
    await _userLocalDatasource.saveUser(userDto);

    return userDto.toEntity();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _remoteDatasource.forgotPassword(email: email);
  }

  @override
  Future<void> logout() async {
    final userId = _localDatasource.getUserId();
    if (userId != null) {
      final synced = await _syncService.syncAll(userId: userId);
      if (!synced) {
        throw StateError(
          'Some local changes could not be backed up. Reconnect and try logging out again.',
        );
      }
    }

    await _remoteDatasource.logout();

    await _localDatasource.clearAllLocalData();

    await _localDatasource.clearSession();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userDto = await _remoteDatasource.getCurrentUser();

    if (userDto == null) return null;

    return userDto.toEntity();
  }
}
