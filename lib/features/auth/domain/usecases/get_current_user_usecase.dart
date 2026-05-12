import '../../xcore.dart';

class GetCurrentUserUsecase {
  final AuthRepository _repository;

  GetCurrentUserUsecase(this._repository);

  Future<UserEntity?> call() {
    return _repository.getCurrentUser();
  }
}
