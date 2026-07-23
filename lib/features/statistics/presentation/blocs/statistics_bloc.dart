import '../../../../core.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/data/datasources/manual_deposit_local_datasource.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../presentation/models/statistics_models.dart';

part 'statistics_event.dart';
part 'statistics_bloc.freezed.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(const StatisticsState.initial()) {
    on<LoadStatisticsEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadStatisticsEvent event, Emitter<StatisticsState> emit) async {
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

      final allExpenses = await sl<ExpenseLocalDatasource>().getExpenses(ownerUserId: userId);
      final accounts = await sl<AccountLocalDatasource>().getAccounts();
      final deposits = await sl<ManualDepositLocalDatasource>().fetchAll();
      final settlements = await sl<SettlementLocalDatasource>().getSettlements();

      final monthExpenses = allExpenses.where((e) => e.expenseDate.year == year && e.expenseDate.month == month).toList();
      final monthDeposits = deposits.where((d) => d.createdAt.year == year && d.createdAt.month == month).toList();
      final monthSettlements = settlements.where((s) =>
        s.createdAt.year == year && s.createdAt.month == month &&
        s.status == SettlementStatus.confirmed).toList();

      double totalSpent = 0;
      double totalDeposited = 0;
      final categoryTotals = <String, double>{};
      final dailyTotals = <int, double>{};
      final expenseTypeTotals = <String, double>{};
      final transactions = <TransactionItem>[];
      final accountSpend = <String, double>{};
      final accountDeposit = <String, double>{};

      for (final expense in monthExpenses) {
        ExpenseParticipantDto? participant;
        for (final p in expense.participants) {
          if (p.userId == userId) {
            participant = p;
            break;
          }
        }
        if (participant == null) continue;

        final userShare = participant.amount;
        totalSpent += userShare;

        final category = expense.category ?? ExpenseCategory.other.name;
        categoryTotals.update(category, (v) => v + userShare, ifAbsent: () => userShare);

        final day = expense.expenseDate.day;
        dailyTotals.update(day, (v) => v + userShare, ifAbsent: () => userShare);

        expenseTypeTotals.update(expense.expenseType.name, (v) => v + userShare, ifAbsent: () => userShare);

        if (expense.accountId != null) {
          accountSpend.update(expense.accountId!, (v) => v + expense.amount, ifAbsent: () => expense.amount);
        }

        transactions.add(ExpenseTxn(
          id: expense.id,
          amount: userShare,
          date: expense.expenseDate,
          title: expense.title,
          category: category,
          accountId: expense.accountId ?? '',
          paidByUserId: expense.paidByUserId,
        ));
      }

      for (final deposit in monthDeposits) {
        totalDeposited += deposit.amount;
        accountDeposit.update(deposit.accountId, (v) => v + deposit.amount, ifAbsent: () => deposit.amount);
        transactions.add(DepositTxn(
          id: deposit.id,
          amount: deposit.amount,
          date: deposit.createdAt,
          description: deposit.description,
          accountId: deposit.accountId,
        ));
      }

      final seenSettlementIds = <String>{};
      for (final settlement in monthSettlements) {
        if (!seenSettlementIds.add(settlement.id)) continue;
        final isIncoming = settlement.toUserId == userId;
        if (settlement.accountId != null) {
          if (isIncoming) {
            accountDeposit.update(settlement.accountId!, (v) => v + settlement.amount, ifAbsent: () => settlement.amount);
            totalDeposited += settlement.amount;
          } else {
            accountSpend.update(settlement.accountId!, (v) => v + settlement.amount, ifAbsent: () => settlement.amount);
            totalSpent += settlement.amount;
          }
        }
        transactions.add(SettlementTxn(
          id: settlement.id,
          amount: settlement.amount,
          date: settlement.createdAt,
          accountId: isIncoming ? '' : (settlement.accountId ?? ''),
          isIncoming: isIncoming,
        ));
      }

      transactions.sort((a, b) => b.date.compareTo(a.date));

      final myAccounts = accounts.where((a) => a.userId == userId).toList();

      final accountStats = myAccounts.map((a) {
        final spent = accountSpend[a.id] ?? 0.0;
        final deposited = accountDeposit[a.id] ?? 0.0;
        return AccountStat(
          accountId: a.id,
          accountName: a.accountName,
          endBalance: a.currentBalance,
          startBalance: a.currentBalance - deposited + spent,
          totalDeposited: deposited,
          totalSpent: spent,
        );
      }).toList();

      final sortedCategories = categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      final sortedDaily = dailyTotals.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

      final monthComparisons = <MonthComparison>[];
      for (int i = 1; i <= 3; i++) {
        final prev = DateTime(year, month - i, 1);
        final prevExpenses = allExpenses.where((e) => e.expenseDate.year == prev.year && e.expenseDate.month == prev.month).toList();
        final prevDeposits = deposits.where((d) => d.createdAt.year == prev.year && d.createdAt.month == prev.month).toList();
        if (prevExpenses.isEmpty && prevDeposits.isEmpty) continue;

        double prevSpent = 0;
        for (final e in prevExpenses) {
          for (final p in e.participants) {
            if (p.userId == userId) { prevSpent += p.amount; break; }
          }
        }
        final prevDeposited = prevDeposits.fold<double>(0, (s, d) => s + d.amount);

        monthComparisons.add(MonthComparison(
          label: DateFormat('MMM yyyy').format(prev),
          totalSpent: prevSpent,
          totalDeposited: prevDeposited,
        ));
      }

      emit(StatisticsState.loaded(
        selectedYear: year,
        selectedMonth: month,
        totalSpent: totalSpent,
        totalDeposited: totalDeposited,
        expenseCount: monthExpenses.length,
        depositCount: monthDeposits.length + monthSettlements.where((s) => s.toUserId == userId).length,
        categoryTotals: Map.fromEntries(sortedCategories),
        dailyTotals: Map.fromEntries(sortedDaily),
        expenseTypeTotals: expenseTypeTotals,
        accountStats: accountStats,
        transactions: transactions,
        monthComparisons: monthComparisons,
      ));
    } catch (e) {
      emit(StatisticsState.error(e.toString()));
    }
  }
}
