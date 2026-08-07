import '../../../../core.dart';

abstract interface class UserRemoteDatasource {
  Future<UserRemoteDto?> searchUser({
    required String query,
    required String currentUserId,
  });
  Future<UserRemoteDto?> getUser(String id);
}
