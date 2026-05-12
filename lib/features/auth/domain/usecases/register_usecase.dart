import '../../xcore.dart';

class RegisterUsecase {
  final AuthRepository _repository;

  RegisterUsecase(this._repository);

  Future<UserEntity> call({required String name, String? nickname, required String email, required String password}) {
    return _repository.register(name: name, nickname: nickname, email: email, password: password);
  }
}
