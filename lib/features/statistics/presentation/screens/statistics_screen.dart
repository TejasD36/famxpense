import 'dart:io';

import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../xcore.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
    _load();
    final notifier = sl<RefreshNotifier>();
    if (notifier.hasData) {
      _load();
    }
    notifier.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) _load();
  }

  void _load() {
    context.read<StatisticsBloc>().add(StatisticsEvent.load(month: _selectedMonth));
  }

  void _prevMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      _load();
    });
  }

  void _nextMonth() {
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    final now = DateTime(DateTime.now().year, DateTime.now().month);
    if (next.isAfter(now)) return;
    setState(() {
      _selectedMonth = next;
      _load();
    });
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: DateTimeRange(
        start: _selectedMonth,
        end: DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).isAfter(now) ? now : DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0),
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedMonth = DateTime(picked.start.year, picked.start.month);
        _load();
      });
    }
  }

  Future<void> _exportCsv(StatisticsLoaded state) async {
    final accountNames = {for (final a in state.accountStats) a.accountId: a.accountName};

    final rows = <List<String>>[
      ['Type', 'Date', 'Amount', 'Category / Description', 'Account'],
    ];

    for (final txn in state.transactions) {
      final accountName = switch (txn) {
        ExpenseTxn(:final accountId) => accountNames[accountId] ?? accountId,
        DepositTxn(:final accountId) => accountNames[accountId] ?? accountId,
        SettlementTxn(:final accountId, :final isIncoming) => isIncoming ? '' : (accountNames[accountId] ?? accountId),
      };
      rows.add([
        switch (txn) {
          ExpenseTxn _ => 'Expense',
          DepositTxn _ => 'Deposit',
          SettlementTxn(:final isIncoming) => isIncoming ? 'Settlement Received' : 'Settlement Paid',
        },
        DateFormat('yyyy-MM-dd').format(txn.date),
        txn.amount.toStringAsFixed(2),
        switch (txn) {
          ExpenseTxn(:final title, :final category) => category.isNotEmpty && category != 'other' ? '$title ($category)' : title,
          DepositTxn(:final description) => description,
          SettlementTxn(:final isIncoming) => isIncoming ? 'Settlement received' : 'Settlement paid',
        },
        accountName,
      ]);
    }

    final csv = const CsvEncoder().convert(rows);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/famxpense_${_selectedMonth.year}_${_selectedMonth.month.toString().padLeft(2, '0')}.csv');
    await file.writeAsString(csv);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: 'FamXpense Report ${DateFormat('MMM yyyy').format(_selectedMonth)}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(padding: const EdgeInsets.symmetric(horizontal: 13.0), child: const Text('Statistics')),
        centerTitle: false,
        actions: [
          BlocBuilder<StatisticsBloc, StatisticsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (_, _, _, _, _, _, _, _, _, _, _, _) => IconButton(
                  icon: const Icon(Icons.file_download_rounded),
                  tooltip: 'Export CSV',
                  onPressed: () => _exportCsv(state as StatisticsLoaded),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _MonthBar(selectedMonth: _selectedMonth, onPrev: _prevMonth, onNext: _nextMonth, onCalendar: _pickDateRange),
          Expanded(
            child: BlocBuilder<StatisticsBloc, StatisticsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded:
                      (
                        _,
                        _,
                        totalSpent,
                        totalDeposited,
                        expenseCount,
                        depositCount,
                        categoryTotals,
                        dailyTotals,
                        expenseTypeTotals,
                        accountStats,
                        transactions,
                        monthComparisons,
                      ) => RefreshIndicator(
                        onRefresh: () async => _load(),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SummaryCards(
                                totalSpent: totalSpent,
                                totalDeposited: totalDeposited,
                                expenseCount: expenseCount,
                                depositCount: depositCount,
                              ),
                              if (accountStats.any((a) => a.totalSpent > 0 || a.totalDeposited > 0)) ...[
                                const SizedBox(height: 20),
                                _AccountBalanceSection(accountStats: accountStats),
                              ],
                              if (expenseTypeTotals.isNotEmpty) ...[
                                const SizedBox(height: 20),
                                _ExpenseTypeChart(expenseTypeTotals: expenseTypeTotals, totalSpent: totalSpent),
                              ],
                              if (categoryTotals.isNotEmpty) ...[
                                const SizedBox(height: 20),
                                _CategorySection(categoryTotals: categoryTotals, totalSpent: totalSpent),
                              ],
                              if (dailyTotals.isNotEmpty) ...[const SizedBox(height: 20), _DailySection(dailyTotals: dailyTotals)],
                              if (transactions.isNotEmpty) ...[const SizedBox(height: 20), _TransactionSection(transactions: transactions)],
                              if (monthComparisons.isNotEmpty) ...[
                                const SizedBox(height: 20),
                                _ComparisonSection(
                                  monthComparisons: monthComparisons,
                                  currentSpent: totalSpent,
                                  currentDeposited: totalDeposited,
                                ),
                              ],
                              if (categoryTotals.isEmpty && dailyTotals.isEmpty && expenseTypeTotals.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 64),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bar_chart_rounded,
                                          size: 64,
                                          color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No data for this month',
                                          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  error: (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        message,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthBar extends StatelessWidget {
  final DateTime selectedMonth;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onCalendar;

  const _MonthBar({required this.selectedMonth, required this.onPrev, required this.onNext, required this.onCalendar});

  bool get _isAtCurrentMonth {
    final now = DateTime.now();
    return selectedMonth.month == now.month && selectedMonth.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.chevron_left_rounded), onPressed: onPrev),
          Text(DateFormat('MMM yyyy').format(selectedMonth), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          IconButton(
            icon: Icon(
              Icons.chevron_right_rounded,
              color: _isAtCurrentMonth ? Theme.of(context).disabledColor : null,
            ),
            onPressed: _isAtCurrentMonth ? null : onNext,
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.calendar_month_rounded), onPressed: onCalendar, tooltip: 'Pick date range'),
        ],
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  final double totalSpent;
  final double totalDeposited;
  final int expenseCount;
  final int depositCount;

  const _SummaryCards({required this.totalSpent, required this.totalDeposited, required this.expenseCount, required this.depositCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: 'Total Spent',
            value: '₹${totalSpent.toStringAsFixed(0)}',
            icon: Icons.arrow_upward_rounded,
            color: theme.colorScheme.error,
            subtext: '$expenseCount expenses',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            label: 'Deposited',
            value: '₹${totalDeposited.toStringAsFixed(0)}',
            icon: Icons.arrow_downward_rounded,
            color: Colors.green,
            subtext: '$depositCount deposits',
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String subtext;

  const _MetricCard({required this.label, required this.value, required this.icon, required this.color, required this.subtext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Text(label, style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(subtext, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _AccountBalanceSection extends StatelessWidget {
  final List<AccountStat> accountStats;

  const _AccountBalanceSection({required this.accountStats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalBalance = accountStats.fold<double>(0, (s, a) => s + a.endBalance);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Account Balance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text('₹${totalBalance.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            ...accountStats.where((a) => a.endBalance > 0 || a.totalDeposited > 0 || a.totalSpent > 0).map((a) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.accountName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(
                            'Start: ₹${a.startBalance.toStringAsFixed(0)}  →  End: ₹${a.endBalance.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.arrow_downward_rounded, size: 12, color: Colors.green),
                              const SizedBox(width: 2),
                              Text('₹${a.totalDeposited.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: Colors.green)),
                              const SizedBox(width: 12),
                              Icon(Icons.arrow_upward_rounded, size: 12, color: theme.colorScheme.error),
                              const SizedBox(width: 2),
                              Text('₹${a.totalSpent.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: theme.colorScheme.error)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: a.netChange >= 0 ? Colors.green.withValues(alpha: 0.12) : theme.colorScheme.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${a.netChange >= 0 ? '+' : ''}${a.netChange.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: a.netChange >= 0 ? Colors.green.shade700 : theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTypeChart extends StatelessWidget {
  final Map<String, double> expenseTypeTotals;
  final double totalSpent;

  const _ExpenseTypeChart({required this.expenseTypeTotals, required this.totalSpent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = <String, Color>{'personal': Colors.blue, 'shared': Colors.orange, 'group': Colors.purple};

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pie_chart_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Expense Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: expenseTypeTotals.entries
                            .map(
                              (e) => PieChartSectionData(
                                value: e.value,
                                color: colors[e.key] ?? (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                                title: '${((totalSpent > 0 ? e.value / totalSpent * 100 : 0)).toStringAsFixed(0)}%',
                                titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                                radius: 60,
                              ),
                            )
                            .toList(),
                        centerSpaceRadius: 30,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: expenseTypeTotals.entries.map((e) {
                      final pct = totalSpent > 0 ? e.value / totalSpent * 100 : 0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: colors[e.key] ?? (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${_typeLabel(e.key)}  ₹${e.value.toStringAsFixed(0)} (${pct.toStringAsFixed(1)}%)',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    return switch (type) {
      'personal' => 'Personal',
      'shared' => 'Shared',
      'group' => 'Group',
      _ => type,
    };
  }
}

class _CategorySection extends StatelessWidget {
  final Map<String, double> categoryTotals;
  final double totalSpent;

  const _CategorySection({required this.categoryTotals, required this.totalSpent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.category_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Category Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: categoryTotals.entries
                      .map(
                        (e) => PieChartSectionData(
                          value: e.value,
                          color: categoryColor(e.key, isDark),
                          title: '${((totalSpent > 0 ? e.value / totalSpent * 100 : 0)).toStringAsFixed(0)}%',
                          titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                          radius: 70,
                        ),
                      )
                      .toList(),
                  centerSpaceRadius: 35,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: categoryTotals.entries.map((e) {
                final pct = totalSpent > 0 ? e.value / totalSpent * 100 : 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: categoryColor(e.key, isDark), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${categoryLabel(e.key)}  ₹${e.value.toStringAsFixed(0)} (${pct.toStringAsFixed(1)}%)',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailySection extends StatelessWidget {
  final Map<int, double> dailyTotals;

  const _DailySection({required this.dailyTotals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final entries = dailyTotals.entries.toList();
    final maxY = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Daily Spending', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxY * 1.2,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Day ${group.x}\n₹${rod.toY.toStringAsFixed(0)}',
                          const TextStyle(fontSize: 12, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() % 5 != 0 && value.toInt() != 1) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text('${value.toInt()}', style: const TextStyle(fontSize: 10)),
                          );
                        },
                        reservedSize: 22,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) => Text('₹${value.toInt()}', style: const TextStyle(fontSize: 10)),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: maxY * 1.2 / 4),
                  borderData: FlBorderData(show: false),
                  barGroups: entries
                      .map(
                        (e) => BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: e.value,
                              color: isDark ? Colors.amber.shade300 : Colors.blue.shade600,
                              width: 12,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionSection extends StatelessWidget {
  final List<TransactionItem> transactions;

  const _TransactionSection({required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayTxns = transactions.take(20).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Recent Transactions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                if (transactions.length > 20) ...[
                  const Spacer(),
                  Text('Top 20', style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                ],
              ],
            ),
            const SizedBox(height: 8),
            ...displayTxns.map((txn) {
              final (icon, color, label, amountColor) = switch (txn) {
                ExpenseTxn() => (Icons.shopping_bag_rounded, Colors.orange.shade100, txn.title, theme.colorScheme.error),
                DepositTxn() => (Icons.account_balance_rounded, Colors.green.shade100, txn.description, Colors.green),
                SettlementTxn(:final isIncoming) => (
                  isIncoming ? Icons.call_received_rounded : Icons.call_made_rounded,
                  isIncoming ? Colors.green.shade100 : Colors.red.shade100,
                  isIncoming ? 'Settlement received' : 'Settlement paid',
                  isIncoming ? Colors.green : theme.colorScheme.error,
                ),
              };
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      child: Icon(icon, size: 16, color: amountColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            DateFormat('MMM d, HH:mm').format(txn.date),
                            style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '₹${txn.amount.toStringAsFixed(0)}',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: amountColor),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  final List<MonthComparison> monthComparisons;
  final double currentSpent;
  final double currentDeposited;

  const _ComparisonSection({required this.monthComparisons, required this.currentSpent, required this.currentDeposited});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allMonths = [
      ...monthComparisons,
      MonthComparison(label: DateFormat('MMM yyyy').format(DateTime.now()), totalSpent: currentSpent, totalDeposited: currentDeposited),
    ];
    final maxVal = allMonths.fold<double>(0, (s, m) => m.totalSpent > s ? m.totalSpent : (m.totalDeposited > s ? m.totalDeposited : s));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Monthly Comparison', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxVal * 1.3,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final month = allMonths[groupIndex];
                        final label = rodIndex == 0 ? 'Spent' : 'Deposited';
                        return BarTooltipItem(
                          '${month.label}\n$label: ₹${rod.toY.toStringAsFixed(0)}',
                          const TextStyle(fontSize: 12, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= allMonths.length) return const SizedBox.shrink();
                          final parts = allMonths[i].label.split(' ');
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(parts.isNotEmpty ? parts[0] : '', style: const TextStyle(fontSize: 10)),
                          );
                        },
                        reservedSize: 22,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) => Text('₹${value.toInt()}', style: const TextStyle(fontSize: 10)),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: maxVal * 1.3 / 4),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(allMonths.length, (i) {
                    final m = allMonths[i];
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: m.totalSpent,
                          color: theme.colorScheme.error,
                          width: 10,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                        ),
                        BarChartRodData(
                          toY: m.totalDeposited,
                          color: Colors.green,
                          width: 10,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                        ),
                      ],
                      barsSpace: 4,
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendDot(color: theme.colorScheme.error, label: 'Spent'),
                const SizedBox(width: 20),
                _LegendDot(color: Colors.green, label: 'Deposited'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
