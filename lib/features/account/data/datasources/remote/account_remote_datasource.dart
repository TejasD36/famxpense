import '../../../xcore.dart';

abstract interface class AccountRemoteDatasource {
  Future<void> createAccount(AccountEntity account);
  Future<void> updateAccount(AccountEntity account);
  Future<void> deleteAccount(String accountId);
  Future<List<AccountEntity>> fetchAccounts({required String userId});
}