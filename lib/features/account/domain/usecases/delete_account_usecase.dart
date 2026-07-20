import '../../xcore.dart';

class DeleteAccountUsecase {
  final AccountRepository _repository;

  DeleteAccountUsecase({required AccountRepository repository}) : _repository = repository;

  Future<void> call(String accountId) => _repository.deleteAccount(accountId);
}
