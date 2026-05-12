import '../../data/models/auth_user_model.dart';
import '../repositories/auth_repository.dart';

class CheckAuthStatusUseCase {
  CheckAuthStatusUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUserModel?> call() {
    return _repository.getSavedUser();
  }
}
