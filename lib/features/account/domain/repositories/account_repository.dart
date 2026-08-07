import '../../xcore.dart';

abstract interface class AccountRepository {
  Future<List<AccountEntity>> getAccounts({required String userId});
  Future<void> saveAccount(AccountEntity account);
  Future<void> deleteAccount(String accountId);
  Future<void> updateBalance(String accountId, double newBalance);
  Future<AccountEntity> recordManualBalanceChange(ManualDepositDto entry);
  Future<AccountEntity> adjustBalance(
    String accountId,
    double delta, {
    String? mutationId,
  });
  Future<({AccountEntity fromAccount, AccountEntity toAccount})>
  transferBalance({
    required String userId,
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    String? mutationId,
  });
}
