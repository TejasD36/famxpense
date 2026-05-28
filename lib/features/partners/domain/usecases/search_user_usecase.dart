import '../../../../shared/domain/repositories/user_repository.dart';
import '../../xcore.dart';

class SearchUserUsecase {
  final UserRepository _repository;

  SearchUserUsecase(this._repository);

  Future<UserEntity?> call({required String query, required String currentUserId}) async {
    return _repository.searchUser(query: query, currentUserId: currentUserId);
  }
}
