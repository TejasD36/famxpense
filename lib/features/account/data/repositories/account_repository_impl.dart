import '../../xcore.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource _localDatasource;
  final AccountRemoteDatasource _remoteDatasource;

  AccountRepositoryImpl({
    required AccountLocalDatasource localDatasource,
    required AccountRemoteDatasource remoteDatasource,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource;

  @override
  Future<List<AccountEntity>> getAccounts({required String userId}) async {
    final dtos = await _localDatasource.getAccounts();
    return dtos.where((a) => a.userId == userId).map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> saveAccount(AccountEntity account) async {
    await _localDatasource.saveAccount(account.toDto());
    try {
      await _remoteDatasource.updateAccount(account);
    } catch (e, stackTrace) {
      AppLogger.warning('Account remote save failed');
      AppLogger.error('Account remote save error', e, stackTrace);
    }
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await _localDatasource.deleteAccount(accountId);
    try {
      await _remoteDatasource.deleteAccount(accountId);
    } catch (e, stackTrace) {
      AppLogger.warning('Account remote delete failed');
      AppLogger.error('Account remote delete error', e, stackTrace);
    }
  }

  @override
  Future<void> updateBalance(String accountId, double newBalance) async {
    final dtos = await _localDatasource.getAccounts();
    final account = dtos.firstWhere((a) => a.id == accountId);
    final updated = account.copyWith(currentBalance: newBalance, updatedAt: DateTime.now().toUtc());
    await _localDatasource.saveAccount(updated);
    try {
      await _remoteDatasource.updateAccount(updated.toEntity());
    } catch (e, stackTrace) {
      AppLogger.warning('Account balance remote sync failed');
      AppLogger.error('Account balance remote sync error', e, stackTrace);
    }
  }
}
