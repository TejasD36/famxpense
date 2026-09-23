import '../../xcore.dart';

class GetAccountsUsecase {
  final AccountRepository _repository;

  GetAccountsUsecase({required AccountRepository repository})
    : _repository = repository;

  Future<List<AccountEntity>> call({required String userId}) =>
      _repository.getAccounts(userId: userId);
}
