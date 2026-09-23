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
  Future<MonthlySavingEntity> computeCurrentMonth(
    String accountId,
    double currentBalance,
    double goalAmount,
  ) async {
    final calendarNow = DateTime.now();
    final updatedAt = calendarNow.toUtc();
    _validateWholeRupees(currentBalance, field: 'currentBalance');
    _validateWholeRupees(goalAmount, field: 'goalAmount');
    final existing = await _local.getSnapshot(
      accountId,
      calendarNow.year,
      calendarNow.month,
    );

    final accounts = await _accountLocal.getAccounts();
    final account = accounts.where((item) => item.id == accountId).firstOrNull;
    if (account == null) {
      throw StateError('Savings account was not found');
    }
    final userId = existing?.userId.isNotEmpty == true
        ? existing!.userId
        : account.userId;
    if (userId.isEmpty) throw StateError('Savings snapshot requires an owner');

    final openingBalance =
        existing?.openingBalance ??
        await _computeOpeningBalance(
          accountId,
          calendarNow.year,
          calendarNow.month,
        );
    final savedAmount = currentBalance - openingBalance;
    final percent = goalAmount > 0
        ? (savedAmount / goalAmount * 100).clamp(-999.0, 999.0)
        : 0.0;

    final pending = MonthlySavingEntity(
      id:
          existing?.id ??
          _snapshotId(userId, accountId, calendarNow.year, calendarNow.month),
      accountId: accountId,
      year: calendarNow.year,
      month: calendarNow.month,
      goalAmount: goalAmount,
      savedAmount: savedAmount,
      openingBalance: openingBalance,
      closingBalance: currentBalance,
      achievementPercent: percent,
      isCompleted: existing?.isCompleted ?? false,
      userId: userId,
      syncStatus: SyncStatus.pending,
      updatedAt: updatedAt,
    );
    await _local.saveSnapshot(pending.toDto());

    try {
      final synced = pending.copyWith(syncStatus: SyncStatus.synced);
      await _remote.saveSnapshot(synced.toDto());
      await _local.saveSnapshot(synced.toDto());
      return synced;
    } catch (e, stackTrace) {
      AppLogger.warning('Firebase sync failed — saved locally');
      AppLogger.error('Monthly savings remote save failed', e, stackTrace);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
      return pending;
    }
  }

  @override
  Future<void> finalizeMonth(String accountId, int year, int month) async {
    final existing = await _local.getSnapshot(accountId, year, month);
    if (existing == null || existing.isCompleted) return;
    final pending = existing.copyWith(
      isCompleted: true,
      syncStatus: SyncStatus.pending,
      updatedAt: DateTime.now().toUtc(),
    );
    await _local.saveSnapshot(pending);
    try {
      final synced = pending.copyWith(syncStatus: SyncStatus.synced);
      await _remote.saveSnapshot(synced);
      await _local.saveSnapshot(synced);
    } catch (e, stackTrace) {
      AppLogger.warning('Firebase sync failed — saved locally');
      AppLogger.error(
        'Monthly savings finalize remote save failed',
        e,
        stackTrace,
      );
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }
  }

  @override
  Future<List<MonthlySavingEntity>> getAccountHistory(String accountId) async {
    final dtos = await _local.getSnapshotsByAccount(accountId);
    final deduplicated = <String, MonthlySavingDto>{};
    for (final dto in dtos) {
      final key = '${dto.year}-${dto.month}';
      final current = deduplicated[key];
      if (current == null || _isNewer(dto, current)) {
        deduplicated[key] = dto;
      }
    }
    return deduplicated.values.map((d) => d.toEntity()).toList()..sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
  }

  @override
  Future<MonthlySavingEntity?> getSnapshot(
    String accountId,
    int year,
    int month,
  ) async {
    final dto = await _local.getSnapshot(accountId, year, month);
    return dto?.toEntity();
  }

  @override
  Future<double> getTotalSavedYearToDate(String userId) async {
    final accounts = await _accountLocal.getAccounts();
    final savingsAccounts = accounts
        .where((a) => a.userId == userId && a.isSavings)
        .toList();
    if (savingsAccounts.isEmpty) return 0;

    final now = DateTime.now();
    double total = 0;
    for (final acct in savingsAccounts) {
      final snapshots = await getAccountHistory(acct.id);
      for (final s in snapshots) {
        if (s.year == now.year) {
          total += s.savedAmount;
        }
      }
    }
    return total;
  }

  @override
  Future<double> getTotalSavedForMonth(
    String userId,
    int year,
    int month,
  ) async {
    final accounts = await _accountLocal.getAccounts();
    final savingsAccounts = accounts.where(
      (account) => account.userId == userId && account.isSavings,
    );

    double total = 0;
    for (final account in savingsAccounts) {
      final snapshot = await getSnapshot(account.id, year, month);
      total += snapshot?.savedAmount ?? 0;
    }
    return total;
  }

  Future<double> _computeOpeningBalance(
    String accountId,
    int year,
    int month,
  ) async {
    final local = _priorClosingBalance(
      await _local.getSnapshotsByAccount(accountId),
      year,
      month,
    );
    if (local != 0) return local;

    /// Fresh-install fallback: read prior snapshots from Firestore so the
    /// current month's savings are not inflated by a zero opening balance.
    try {
      final account = (await _accountLocal.getAccounts())
          .where((item) => item.id == accountId)
          .firstOrNull;
      if (account == null) return 0;
      final remote = await _remote.fetchSnapshots(userId: account.userId);
      return _priorClosingBalance(remote, year, month);
    } catch (e, stackTrace) {
      AppLogger.warning('Opening balance remote fallback unavailable');
      AppLogger.error('Remote savings opening balance error', e, stackTrace);
      return 0;
    }
  }

  void _validateWholeRupees(double amount, {required String field}) {
    if ((amount - amount.round()).abs() > 0.000001) {
      throw ArgumentError.value(amount, field, 'Amount must be whole rupees');
    }
  }

  double _priorClosingBalance(
    List<MonthlySavingDto> snapshots,
    int year,
    int month,
  ) {
    final previous = snapshots
        .where((s) => s.year < year || (s.year == year && s.month < month))
        .toList();
    final completed = previous.where((s) => s.isCompleted).toList()
      ..sort((a, b) {
        if (a.year != b.year) return b.year.compareTo(a.year);
        return b.month.compareTo(a.month);
      });
    if (completed.isNotEmpty) return completed.first.closingBalance;
    final allSorted = previous
      ..sort((a, b) {
        if (a.year != b.year) return b.year.compareTo(a.year);
        return b.month.compareTo(a.month);
      });
    if (allSorted.isNotEmpty) return allSorted.first.closingBalance;
    return 0;
  }

  bool _isNewer(MonthlySavingDto candidate, MonthlySavingDto current) {
    final candidateUpdated =
        candidate.updatedAt ?? DateTime.utc(candidate.year, candidate.month);
    final currentUpdated =
        current.updatedAt ?? DateTime.utc(current.year, current.month);
    final comparison = candidateUpdated.compareTo(currentUpdated);
    if (comparison != 0) return comparison > 0;
    if (candidate.isCompleted != current.isCompleted) {
      return candidate.isCompleted;
    }
    return candidate.id.compareTo(current.id) < 0;
  }

  String _snapshotId(String userId, String accountId, int year, int month) {
    return '$userId-$accountId-$year-${month.toString().padLeft(2, '0')}';
  }
}
