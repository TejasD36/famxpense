import '../../../features/account/data/datasources/account_local_datasource.dart';
import '../../../features/account/data/datasources/manual_deposit_local_datasource.dart';
import '../../../features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/income/data/datasources/income_local_datasource.dart';
import '../../../features/savings/data/datasources/savings_local_datasource.dart';
import '../../../features/savings/data/datasources/transfer_local_datasource.dart';
import '../../../features/settlement/data/datasources/settlement_local_datasource.dart';
import '../../../shared/enums/settlement_status.dart';
import '../../../shared/enums/sync_status.dart';
import '../../local/settings/app_settings.dart';

class ReconciliationCounts {
  final int expenses;
  final int income;
  final int transfers;
  final int settlements;
  final int savingsSnapshots;
  final int accountMutations;
  final int debtMutations;
  final int manualDeposits;

  const ReconciliationCounts({
    required this.expenses,
    required this.income,
    required this.transfers,
    required this.settlements,
    required this.savingsSnapshots,
    required this.accountMutations,
    required this.debtMutations,
    required this.manualDeposits,
  });

  int get total =>
      expenses +
      income +
      transfers +
      settlements +
      savingsSnapshots +
      accountMutations +
      debtMutations +
      manualDeposits;

  bool get isEmpty => total == 0;
}

class ReconciliationSnapshot {
  final ReconciliationCounts counts;
  final DateTime? lastAttempt;
  final DateTime? lastSuccess;
  final DateTime? lastFinished;
  final bool? lastResult;

  const ReconciliationSnapshot({
    required this.counts,
    this.lastAttempt,
    this.lastSuccess,
    this.lastFinished,
    this.lastResult,
  });
}

class ReconciliationService {
  final ExpenseLocalDatasource _expenses;
  final IncomeLocalDatasource _income;
  final TransferLocalDatasource _transfers;
  final SettlementLocalDatasource _settlements;
  final SavingsLocalDatasource _savings;
  final AccountLocalDatasource _accounts;
  final ManualDepositLocalDatasource _deposits;
  final DebtLedgerLocalDatasource _debts;

  ReconciliationService({
    required ExpenseLocalDatasource expenses,
    required IncomeLocalDatasource income,
    required TransferLocalDatasource transfers,
    required SettlementLocalDatasource settlements,
    required SavingsLocalDatasource savings,
    required AccountLocalDatasource accounts,
    required ManualDepositLocalDatasource deposits,
    required DebtLedgerLocalDatasource debts,
  }) : _expenses = expenses,
       _income = income,
       _transfers = transfers,
       _settlements = settlements,
       _savings = savings,
       _accounts = accounts,
       _deposits = deposits,
       _debts = debts;

  Future<ReconciliationSnapshot> load({required String userId}) async {
    final expenses = (await _expenses.getPendingExpenses(
      ownerUserId: userId,
    )).length;
    final income = (await _income.fetchAll())
        .where(
          (i) =>
              i.userId == userId &&
              !i.isDeleted &&
              i.syncStatus == SyncStatus.pending,
        )
        .length;
    final transfers = (await _transfers.fetchAll())
        .where(
          (t) =>
              (t.fromUserId == userId || t.toUserId == userId) &&
              t.syncStatus == SyncStatus.pending,
        )
        .length;
    final settlements = (await _settlements.getSettlements())
        .where(
          (s) =>
              (s.fromUserId == userId || s.toUserId == userId) &&
              s.status == SettlementStatus.pending,
        )
        .length;
    final savings = (await _savings.getAllSnapshots())
        .where((s) => s.userId == userId && s.syncStatus == SyncStatus.pending)
        .length;
    final accounts = (await _accounts.getAccountsIncludingDeleted())
        .where((a) => a.userId == userId)
        .fold<int>(
          0,
          (sum, a) =>
              sum +
              a.pendingBalanceMutations.length +
              (a.hasPendingMetadataChanges ? 1 : 0) +
              (a.isDeleted ? 1 : 0),
        );
    final deposits = (await _deposits.fetchAll())
        .where((d) => d.userId == userId && !d.synced)
        .length;
    final debts = (await _debts.getLedgers())
        .where((d) => d.userA == userId || d.userB == userId)
        .fold<int>(0, (sum, d) => sum + d.pendingMutations.length);

    return ReconciliationSnapshot(
      counts: ReconciliationCounts(
        expenses: expenses,
        income: income,
        transfers: transfers,
        settlements: settlements,
        savingsSnapshots: savings,
        accountMutations: accounts,
        debtMutations: debts,
        manualDeposits: deposits,
      ),
      lastAttempt: await _syncTime(userId, 'attempt'),
      lastSuccess: await _syncTime(userId, 'success'),
      lastFinished: await _syncTime(userId, 'finished'),
      lastResult: await _syncResult(userId),
    );
  }

  Future<DateTime?> _syncTime(String userId, String field) async {
    try {
      return await AppSettings.getSyncTime(userId: userId, field: field);
    } catch (_) {
      return null;
    }
  }

  Future<bool?> _syncResult(String userId) async {
    try {
      return await AppSettings.getSyncResult(userId: userId);
    } catch (_) {
      return null;
    }
  }
}
