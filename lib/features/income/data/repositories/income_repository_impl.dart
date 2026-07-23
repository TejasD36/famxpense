import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeLocalDatasource _localDatasource;
  final AccountRepository _accountRepository;
  final AuthLocalDatasource _authLocalDatasource;

  IncomeRepositoryImpl({
    required IncomeLocalDatasource localDatasource,
    required AccountRepository accountRepository,
    required AuthLocalDatasource authLocalDatasource,
  }) : _localDatasource = localDatasource,
       _accountRepository = accountRepository,
       _authLocalDatasource = authLocalDatasource;

  @override
  Future<void> addIncome(IncomeEntity income) async {
    await _localDatasource.save(income.toDto());

    try {
      final userId = _authLocalDatasource.getUserId() ?? income.userId;
      final accounts = await _accountRepository.getAccounts(userId: userId);
      final account = accounts.where((a) => a.id == income.accountId).firstOrNull;
      if (account != null) {
        await _accountRepository.updateBalance(income.accountId, account.currentBalance + income.amount);
      }
    } catch (e) {
      AppLogger.error('Income balance update failed', e);
    }
  }

  @override
  Future<List<IncomeEntity>> getAllIncomes() async {
    final dtos = await _localDatasource.fetchAll();
    return dtos.map((d) => d.toEntity()).toList();
  }

  @override
  Future<List<IncomeEntity>> getIncomesByAccount(String accountId) async {
    final dtos = await _localDatasource.getByAccount(accountId);
    return dtos.map((d) => d.toEntity()).toList();
  }

  @override
  Future<void> deleteIncome(String incomeId) async {
    await _localDatasource.deleteIncome(incomeId);
  }
}
