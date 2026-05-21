abstract interface class AuthLocalDatasource {
  Future<void> saveUserId(String userId);

  String? getUserId();

  Future<void> clearSession();
}
