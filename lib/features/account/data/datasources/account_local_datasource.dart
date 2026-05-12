import '../../xcore.dart';

abstract interface class AccountLocalDatasource {
  Future<void> saveAccount(AccountDto account);

  Future<List<AccountDto>> getAccounts();

  Future<void> deleteAccount(String accountId);
}
