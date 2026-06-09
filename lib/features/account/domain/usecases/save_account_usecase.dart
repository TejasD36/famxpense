import '../../xcore.dart';

class SaveAccountUsecase {
  final AccountRepository _repository;

  SaveAccountUsecase({required AccountRepository repository}) : _repository = repository;

  Future<void> call(AccountEntity account) => _repository.saveAccount(account);
}
