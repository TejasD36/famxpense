import '../../xcore.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource _localDatasource;

  AccountRepositoryImpl({required AccountLocalDatasource localDatasource}) : _localDatasource = localDatasource;

  @override
  Future<List<AccountEntity>> getAccounts({required String userId}) async {
    final dtos = await _localDatasource.getAccounts();
    return dtos.where((a) => a.userId == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> saveAccount(AccountEntity account) async {
    await _localDatasource.saveAccount(account.toDto());
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await _localDatasource.deleteAccount(accountId);
  }

  @override
  Future<void> updateBalance(String accountId, double newBalance) async {
    final dtos = await _localDatasource.getAccounts();
    final account = dtos.firstWhere((a) => a.id == accountId);
    final updated = account.copyWith(currentBalance: newBalance, updatedAt: DateTime.now().toUtc());
    await _localDatasource.saveAccount(updated);
  }
}
