import '../../xcore.dart';

abstract interface class AccountRepository {
  Future<List<AccountEntity>> getAccounts({required String userId});
  Future<void> saveAccount(AccountEntity account);
  Future<void> deleteAccount(String accountId);
  Future<void> updateBalance(String accountId, double newBalance);
}
