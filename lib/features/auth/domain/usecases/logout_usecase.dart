import '../../xcore.dart';

class LogoutUsecase {
  final AuthRepository _repository;

  LogoutUsecase(this._repository);

  Future<void> call() {
    return _repository.logout();
  }
}
