import '../../../account/data/datasources/account_local_datasource.dart';
import '../../xcore.dart';

class SavingsRepositoryImpl implements SavingsRepository {
  final SavingsLocalDatasource _local;
  final AccountLocalDatasource _accountLocal;
  final MonthlySavingRemoteDatasource _remote;
  final RefreshNotifier _refreshNotifier;

  SavingsRepositoryImpl({
    required SavingsLocalDatasource local,
    required AccountLocalDatasource accountLocal,
    required MonthlySavingRemoteDatasource remote,
    required RefreshNotifier refreshNotifier,
  }) : _local = local,
       _accountLocal = accountLocal,
       _remote = remote,
       _refreshNotifier = refreshNotifier;

  @override
  Future<MonthlySavingEntity> computeCurrentMonth(String accountId, double currentBalance, double goalAmount) async {
    final now = DateTime.now().toUtc();
    final existing = await _local.getSnapshot(accountId, now.year, now.month);

    final openingBalance = existing?.openingBalance ?? await _computeOpeningBalance(accountId, now.year, now.month);
    final savedAmount = currentBalance - openingBalance;
    final percent = goalAmount > 0 ? (savedAmount / goalAmount * 100).clamp(-999.0, 999.0) : 0.0;

    String userId = existing?.userId ?? '';
    if (userId.isEmpty) {
      final accounts = await _accountLocal.getAccounts();
      final acct = accounts.where((a) => a.id == accountId).firstOrNull;
      userId = acct?.userId ?? '';
    }

    final base = MonthlySavingEntity(
      id: existing?.id ?? const Uuid().v4(),
      accountId: accountId,
      year: now.year,
      month: now.month,
      goalAmount: goalAmount,
      savedAmount: savedAmount,
      openingBalance: openingBalance,
      closingBalance: currentBalance,
      achievementPercent: percent,
      isCompleted: false,
      userId: userId,
      syncStatus: SyncStatus.synced,
    );

    MonthlySavingEntity entity;
    try {
      await _remote.saveSnapshot(base.toDto());
      entity = base;
    } catch (e) {
      AppLogger.warning('Firebase sync failed — saved locally');
      entity = base.copyWith(syncStatus: SyncStatus.pending);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }

    await _local.saveSnapshot(entity.toDto());
    return entity;
  }

  @override
  Future<void> finalizeMonth(String accountId, int year, int month) async {
    final existing = await _local.getSnapshot(accountId, year, month);
    if (existing == null || existing.isCompleted) return;
    final updated = existing.copyWith(isCompleted: true);
    try {
      await _remote.saveSnapshot(updated);
      await _local.saveSnapshot(updated);
    } catch (e) {
      AppLogger.warning('Firebase sync failed — saved locally');
      final pending = updated.copyWith(syncStatus: SyncStatus.pending);
      await _local.saveSnapshot(pending);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }
  }

  @override
  Future<List<MonthlySavingEntity>> getAccountHistory(String accountId) async {
    final dtos = await _local.getSnapshotsByAccount(accountId);
    return dtos.map((d) => d.toEntity()).toList()..sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
  }

  @override
  Future<MonthlySavingEntity?> getSnapshot(String accountId, int year, int month) async {
    final dto = await _local.getSnapshot(accountId, year, month);
    return dto?.toEntity();
  }

  @override
  Future<double> getTotalSavedYearToDate(String userId) async {
    final accounts = await _accountLocal.getAccounts();
    final savingsAccounts = accounts.where((a) => a.userId == userId && a.isSavings).toList();
    if (savingsAccounts.isEmpty) return 0;

    final now = DateTime.now().toUtc();
    double total = 0;
    for (final acct in savingsAccounts) {
      final snapshots = await _local.getSnapshotsByAccount(acct.id);
      for (final s in snapshots) {
        if (s.year == now.year) {
          total += s.savedAmount;
        }
      }
    }
    return total;
  }

  Future<double> _computeOpeningBalance(String accountId, int year, int month) async {
    final snapshots = await _local.getSnapshotsByAccount(accountId);
    final completed = snapshots.where((s) => s.isCompleted).toList()..sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
    if (completed.isNotEmpty) return completed.first.closingBalance;
    final allSorted = snapshots.toList()..sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
    if (allSorted.isNotEmpty) return allSorted.first.closingBalance;
    return 0;
  }
}
