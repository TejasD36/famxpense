import '../../../../core.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../presentation/models/statistics_models.dart';

part 'statistics_event.dart';
part 'statistics_bloc.freezed.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(const StatisticsState.initial()) {
    on<LoadStatisticsEvent>(_onLoad);
  }

  Future<void> _onLoad(
    LoadStatisticsEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsState.loading());
    try {
      final userId = sl<AuthLocalDatasource>().getUserId();
      if (userId == null) {
        emit(const StatisticsState.error('User not found'));
        return;
      }

      final now = event.month ?? DateTime.now();
      final year = now.year;
      final month = now.month;
      final hasRange = event.rangeStart != null && event.rangeEnd != null;
      final period = hasRange
          ? ReportingPeriod.range(event.rangeStart!, event.rangeEnd!)
          : ReportingPeriod.month(now);

      final ledger = await sl<ReportingLedgerService>().load(
        userId: userId,
        period: period,
      );
      final categoryTotals = <String, double>{};
      final dailyTotals = <int, double>{};
      final expenseTypeTotals = <String, double>{};
      final transactions = <TransactionItem>[];

      for (final row in ledger.rows) {
        if (row.type == ReportingLedgerRowType.expense && row.expense != null) {
          final category = row.category ?? ExpenseCategory.other.name;
          categoryTotals.update(
            category,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
          expenseTypeTotals.update(
            row.expense!.expenseType.name,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        }
        if (row.isOutflow && !row.isAuditOnly) {
          final day = row.date.toLocal().day;
          dailyTotals.update(
            day,
            (v) => v + row.amount,
            ifAbsent: () => row.amount,
          );
        }
        transactions.add(_toTransaction(row));
      }

      final accountStats = ledger.accountSummaries.values.map((summary) {
        return AccountStat(
          accountId: summary.account.id,
          accountName: summary.account.accountName,
          endBalance: summary.account.currentBalance,
          startBalance: summary.account.currentBalance - summary.netChange,
          totalDeposited: summary.inflowTotal,
          totalSpent: summary.outflowTotal,
        );
      }).toList();

      final sortedCategories = categoryTotals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final sortedDaily = dailyTotals.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      final monthComparisons = <MonthComparison>[];
      for (int i = 1; i <= 3; i++) {
        final prev = DateTime(year, month - i, 1);
        final previousLedger = await sl<ReportingLedgerService>().load(
          userId: userId,
          period: ReportingPeriod.month(prev),
        );
        if (previousLedger.financialRows.isEmpty) continue;
        monthComparisons.add(
          MonthComparison(
            label: DateFormat('MMM yyyy').format(prev),
            totalSpent: previousLedger.totalSpent,
            totalDeposited: previousLedger.totalDeposited,
          ),
        );
      }

      emit(
        StatisticsState.loaded(
          selectedYear: year,
          selectedMonth: month,
          totalSpent: ledger.totalSpent,
          totalDeposited: ledger.totalDeposited,
          expenseCount: ledger.spentCount,
          depositCount: ledger.depositCount,
          categoryTotals: Map.fromEntries(sortedCategories),
          dailyTotals: Map.fromEntries(sortedDaily),
          expenseTypeTotals: expenseTypeTotals,
          accountStats: accountStats,
          transactions: transactions,
          monthComparisons: monthComparisons,
        ),
      );
    } catch (e) {
      emit(StatisticsState.error(e.toString()));
    }
  }

  TransactionItem _toTransaction(ReportingLedgerRow row) {
    switch (row.type) {
      case ReportingLedgerRowType.expense:
        final expense = row.expense!;
        return ExpenseTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          title: expense.title,
          category: row.category ?? ExpenseCategory.other.name,
          accountId: expense.accountId ?? '',
          paidByUserId: expense.paidByUserId,
        );
      case ReportingLedgerRowType.income:
        return IncomeTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          description: row.description,
          accountId: row.accountId ?? '',
        );
      case ReportingLedgerRowType.manualDeposit:
        return DepositTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          description: row.description,
          accountId: row.accountId ?? '',
        );
      case ReportingLedgerRowType.settlementIn ||
          ReportingLedgerRowType.settlementOut:
        return SettlementTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          accountId: row.accountId ?? '',
          isIncoming: row.type == ReportingLedgerRowType.settlementIn,
        );
      case ReportingLedgerRowType.transferIn ||
          ReportingLedgerRowType.transferOut:
        return TransferTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          accountId: row.accountId ?? '',
          linkedAccountId: row.transferAccountId ?? '',
          isIncoming: row.type == ReportingLedgerRowType.transferIn,
          description: row.description,
        );
      case ReportingLedgerRowType.balanceCorrection:
        return BalanceCorrectionTxn(
          id: row.id,
          amount: row.amount,
          date: row.date,
          accountId: row.accountId ?? '',
          description: row.description,
        );
    }
  }
}
