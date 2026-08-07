import '../entities/user/user_entity.dart';

abstract interface class UserRepository {
  Future<UserEntity?> searchUser({
    required String query,
    required String currentUserId,
  });
}
