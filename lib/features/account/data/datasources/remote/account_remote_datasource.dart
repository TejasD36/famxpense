import '../../../xcore.dart';

abstract interface class AccountRemoteDatasource {
  Future<void> createAccount(AccountEntity account);
  Future<void> updateAccount(AccountEntity account);
  Future<void> adjustBalance({
    required String accountId,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
    ManualDepositDto? accountEntry,
  });
  Future<void> transferBalance({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String fromMutationId,
    required String toMutationId,
    required DateTime updatedAt,
  });
  Future<void> deleteAccount(String accountId);
  Future<List<AccountEntity>> fetchAccounts({required String userId});
  Future<List<ManualDepositDto>> fetchAccountEntries({required String userId});
}
