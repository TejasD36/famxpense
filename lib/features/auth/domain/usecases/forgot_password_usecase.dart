import '../../xcore.dart';

class ForgotPasswordUsecase {
  final AuthRepository _repository;

  ForgotPasswordUsecase(this._repository);

  Future<void> call({required String email}) {
    return _repository.forgotPassword(email: email);
  }
}
