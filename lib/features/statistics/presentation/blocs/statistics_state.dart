part of 'statistics_bloc.dart';

@freezed
sealed class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = StatisticsInitial;
  const factory StatisticsState.loading() = StatisticsLoading;
  const factory StatisticsState.loaded({
    required int selectedYear,
    required int selectedMonth,
    required double totalSpent,
    required double totalDeposited,
    required int expenseCount,
    required int depositCount,
    required Map<String, double> categoryTotals,
    required Map<int, double> dailyTotals,
    required Map<String, double> expenseTypeTotals,
    required List<AccountStat> accountStats,
    required List<TransactionItem> transactions,
    required List<MonthComparison> monthComparisons,
  }) = StatisticsLoaded;
  const factory StatisticsState.error(String message) = StatisticsError;
}
