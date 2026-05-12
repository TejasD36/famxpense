import '../../xcore.dart';

class AccountLocalDatasourceImpl extends BaseHiveService<AccountDto> implements AccountLocalDatasource {
  AccountLocalDatasourceImpl() : super(Hive.box<AccountDto>(HiveBoxes.accounts));

  @override
  Future<void> saveAccount(AccountDto account) async {
    await put(key: account.id, value: account);
  }

  @override
  Future<List<AccountDto>> getAccounts() async {
    return getAll();
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await delete(accountId);
  }
}
