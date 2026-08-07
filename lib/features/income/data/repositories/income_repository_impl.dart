import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
import '../../xcore.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeLocalDatasource _localDatasource;
  final IncomeRemoteDatasource _remoteDatasource;
  final AccountRepository _accountRepository;
  final AuthLocalDatasource _authLocalDatasource;
  final SavingsRepository _savingsRepository;
  final RefreshNotifier _refreshNotifier;

  IncomeRepositoryImpl({
    required IncomeLocalDatasource localDatasource,
    required IncomeRemoteDatasource remoteDatasource,
    required AccountRepository accountRepository,
    required AuthLocalDatasource authLocalDatasource,
    required SavingsRepository savingsRepository,
    required RefreshNotifier refreshNotifier,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource,
       _accountRepository = accountRepository,
       _authLocalDatasource = authLocalDatasource,
       _savingsRepository = savingsRepository,
       _refreshNotifier = refreshNotifier;

  @override
  Future<void> addIncome(IncomeEntity income) async {
    if (!income.amount.isFinite || income.amount <= 0) {
      throw ArgumentError.value(
        income.amount,
        'amount',
        'Income amount must be finite and greater than zero',
      );
    }

    final userId = _authLocalDatasource.getUserId();
    if (userId == null || userId != income.userId) {
      throw StateError('Income owner does not match the authenticated user');
    }

    final existing = (await _localDatasource.fetchAll())
        .where((item) => item.id == income.id)
        .firstOrNull;
    if (existing != null) {
      if (existing.isDeleted) {
        throw StateError(
          'A deleted income cannot be recreated with the same ID',
        );
      }
      if (existing.syncStatus != SyncStatus.synced) {
        await _accountRepository.adjustBalance(
          existing.accountId,
          existing.amount,
          mutationId: 'income-credit-${existing.id}',
        );
        try {
          final synced = existing.copyWith(syncStatus: SyncStatus.synced);
          await _remoteDatasource.createIncome(synced);
          await _localDatasource.save(synced);
        } catch (e, stackTrace) {
          AppLogger.error('Income retry failed', e, stackTrace);
        }
      }
      return;
    }

    final accounts = await _accountRepository.getAccounts(userId: userId);
    final account = accounts
        .where((item) => item.id == income.accountId && !item.isArchived)
        .firstOrNull;
    if (account == null) {
      throw StateError(
        'Income account was not found for the authenticated user',
      );
    }

    final pending = income
        .copyWith(
          updatedAt: DateTime.now().toUtc(),
          syncStatus: SyncStatus.pending,
          isDeleted: false,
        )
        .toDto();
    await _localDatasource.save(pending);

    AccountEntity updatedAccount;
    try {
      updatedAccount = await _accountRepository.adjustBalance(
        income.accountId,
        income.amount,
        mutationId: 'income-credit-${income.id}',
      );
    } catch (_) {
      await _localDatasource.deleteIncome(income.id);
      rethrow;
    }

    if (updatedAccount.isSavings) {
      try {
        await _savingsRepository.computeCurrentMonth(
          updatedAccount.id,
          updatedAccount.currentBalance,
          updatedAccount.monthlySavingsGoal,
        );
      } catch (e, stackTrace) {
        AppLogger.error(
          'Savings snapshot update failed after income',
          e,
          stackTrace,
        );
      }
    }

    try {
      final synced = pending.copyWith(syncStatus: SyncStatus.synced);
      await _remoteDatasource.createIncome(synced);
      await _localDatasource.save(synced);
    } catch (e, stackTrace) {
      AppLogger.warning('Firebase sync failed — saved locally');
      AppLogger.error('Income remote save failed', e, stackTrace);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }
  }

  @override
  Future<List<IncomeEntity>> getAllIncomes() async {
    try {
      final userId = _authLocalDatasource.getUserId();
      if (userId == null) return [];
      final dtos = await _localDatasource.fetchAll();
      return dtos
          .where((d) => d.userId == userId && !d.isDeleted)
          .map((d) => d.toEntity())
          .toList();
    } catch (e) {
      AppLogger.error('Failed to fetch incomes', e);
      return [];
    }
  }

  @override
  Future<List<IncomeEntity>> getIncomesByAccount(String accountId) async {
    try {
      final userId = _authLocalDatasource.getUserId();
      if (userId == null) return [];
      final dtos = await _localDatasource.getByAccount(accountId);
      return dtos
          .where((d) => d.userId == userId && !d.isDeleted)
          .map((d) => d.toEntity())
          .toList();
    } catch (e) {
      AppLogger.error('Failed to fetch incomes by account', e);
      return [];
    }
  }

  @override
  Future<void> deleteIncome(String incomeId) async {
    final dtos = await _localDatasource.fetchAll();
    final income = dtos.where((d) => d.id == incomeId).firstOrNull;
    if (income == null) return;

    final userId = _authLocalDatasource.getUserId();
    if (userId == null || income.userId != userId) {
      throw StateError('Income owner does not match the authenticated user');
    }

    if (!income.isDeleted) {
      final tombstone = income.copyWith(
        isDeleted: true,
        syncStatus: SyncStatus.pending,
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDatasource.save(tombstone);

      try {
        final accounts = await _accountRepository.getAccounts(userId: userId);
        final account = accounts
            .where((a) => a.id == income.accountId)
            .firstOrNull;
        if (account != null) {
          final updatedAccount = await _accountRepository.adjustBalance(
            income.accountId,
            -income.amount,
            mutationId: 'income-reversal-${income.id}',
          );
          if (updatedAccount.isSavings) {
            try {
              await _savingsRepository.computeCurrentMonth(
                updatedAccount.id,
                updatedAccount.currentBalance,
                updatedAccount.monthlySavingsGoal,
              );
            } catch (e, stackTrace) {
              AppLogger.error(
                'Savings snapshot update failed after income deletion',
                e,
                stackTrace,
              );
            }
          }
        }
      } catch (e, stackTrace) {
        await _localDatasource.save(income);
        AppLogger.error('Income balance reversal failed on delete', e);
        Error.throwWithStackTrace(e, stackTrace);
      }
    }

    try {
      await _remoteDatasource.deleteIncome(incomeId);
      await _localDatasource.deleteIncome(incomeId);
    } catch (e, stackTrace) {
      AppLogger.warning(
        'Income remote delete failed — tombstone retained for retry',
      );
      AppLogger.error('Income remote delete error', e, stackTrace);
      _refreshNotifier.notifySyncError(
        'Income deletion will retry when connected',
      );
    }
  }
}
