import '../../xcore.dart';

abstract interface class AccountLocalDatasource {
  Future<void> saveAccount(AccountDto account);

  Future<void> saveAccounts(List<AccountDto> accounts);

  Future<List<AccountDto>> getAccounts();

  /// Includes deletion tombstones and is reserved for repository/sync recovery.
  Future<List<AccountDto>> getAccountsIncludingDeleted();

  Future<void> deleteAccount(String accountId);
}
