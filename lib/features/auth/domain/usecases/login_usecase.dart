import '../../xcore.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<UserEntity> call({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }
}
