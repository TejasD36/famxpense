import '../../domain/entities/user/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../transformers/mappers/user/user_remote_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource _remoteDatasource;

  UserRepositoryImpl({required UserRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override
  Future<UserEntity?> searchUser({required String query, required String currentUserId}) async {
    final result = await _remoteDatasource.searchUser(query: query, currentUserId: currentUserId);

    return result?.toEntity();
  }
}
