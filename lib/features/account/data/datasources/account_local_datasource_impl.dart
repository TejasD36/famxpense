import '../../xcore.dart';

class AccountLocalDatasourceImpl extends BaseHiveService<AccountDto>
    implements AccountLocalDatasource {
  AccountLocalDatasourceImpl()
    : super(Hive.box<AccountDto>(HiveBoxes.accounts));

  @override
  Future<void> saveAccount(AccountDto account) async {
    await put(key: account.id, value: account);
  }

  @override
  Future<void> saveAccounts(List<AccountDto> accounts) async {
    await box.putAll({for (final account in accounts) account.id: account});
  }

  @override
  Future<List<AccountDto>> getAccounts() async {
    return getAll().where((account) => !account.isDeleted).toList();
  }

  @override
  Future<List<AccountDto>> getAccountsIncludingDeleted() async {
    return getAll();
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await delete(accountId);
  }
}
