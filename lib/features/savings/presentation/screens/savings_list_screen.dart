import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class SavingsListScreen extends StatefulWidget {
  const SavingsListScreen({super.key});

  @override
  State<SavingsListScreen> createState() => _SavingsListScreenState();
}

class _SavingsListScreenState extends State<SavingsListScreen> {
  List<AccountEntity> _savingsAccounts = [];
  Map<String, MonthlySavingEntity?> _currentSnapshots = {};
  List<_MonthSummary> _timeline = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    sl<RefreshNotifier>().addListener(_load);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      final dtos = await sl<AccountLocalDatasource>().getAccounts();
      final accounts = dtos
          .where((a) => a.userId == userId && a.isSavings)
          .map((d) => d.toEntity())
          .toList();

      final repo = sl<SavingsRepository>();
      final now = DateTime.now();
      final snapshots = <String, MonthlySavingEntity?>{};
      final allHistory = <MonthlySavingEntity>[];

      for (final a in accounts) {
        var snap = await repo.getSnapshot(a.id, now.year, now.month);
        if (snap == null ||
            (snap.closingBalance - a.currentBalance).abs() > 0.001 ||
            (snap.goalAmount - a.monthlySavingsGoal).abs() > 0.001) {
          snap = await repo.computeCurrentMonth(
            a.id,
            a.currentBalance,
            a.monthlySavingsGoal,
          );
        }
        snapshots[a.id] = snap;
        final history = await repo.getAccountHistory(a.id);
        allHistory.addAll(history);
      }

      final grouped = <int, Map<int, double>>{};
      for (final h in allHistory) {
        grouped.putIfAbsent(h.year, () => {});
        grouped[h.year]![h.month] =
            (grouped[h.year]![h.month] ?? 0) + h.savedAmount;
      }

      final timeline = <_MonthSummary>[];
      final yearData = grouped[now.year] ?? {};
      final sortedMonths = yearData.keys.toList()
        ..sort((a, b) => b.compareTo(a));
      for (final m in sortedMonths) {
        timeline.add(
          _MonthSummary(year: now.year, month: m, totalSaved: yearData[m]!),
        );
      }

      if (mounted) {
        setState(() {
          _savingsAccounts = accounts;
          _currentSnapshots = snapshots;
          _timeline = timeline;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Savings')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _savingsAccounts.isEmpty
          ? FinanceEmptyState(
              icon: Icons.savings_rounded,
              title: 'No savings accounts yet',
              subtitle:
                  'Mark an account as savings to track monthly goals and progress.',
              action: OutlinedButton.icon(
                onPressed: () => context.pushNamed(AppRoute.addAccount.name),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Account'),
              ),
            )
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSummaryCard(),
                  const SizedBox(height: 14),
                  ..._savingsAccounts.map(
                    (a) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildAccountCard(a),
                    ),
                  ),
                  if (_timeline.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    const CompactSectionHeader(title: 'Monthly History'),
                    ..._timeline.map((m) => _buildTimelineCard(m)),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCard() {
    double totalGoal = 0;
    double totalSaved = 0;
    for (final a in _savingsAccounts) {
      totalGoal += a.monthlySavingsGoal;
      final snap = _currentSnapshots[a.id];
      totalSaved += snap?.savedAmount ?? 0;
    }

    final percent = totalGoal > 0
        ? (totalSaved / totalGoal * 100).clamp(-999.0, 999.0)
        : 0.0;

    Color barColor;
    if (totalSaved < 0) {
      barColor = Colors.red;
    } else if (percent < 50) {
      barColor = Colors.red;
    } else if (percent < 80) {
      barColor = Colors.amber;
    } else {
      barColor = Colors.green;
    }

    return GradientPatternPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.savings_rounded, color: barColor, size: 22),
              const SizedBox(width: 8),
              Text(
                'This Month',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '${percent.toStringAsFixed(1)}%',
                style: TextStyle(fontWeight: FontWeight.w700, color: barColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          MoneyMetricStrip(
            metrics: [
              MoneyMetric(
                label: 'Goal',
                value: formatIndianRupee(totalGoal),
                icon: Icons.flag_rounded,
              ),
              MoneyMetric(
                label: 'Saved',
                value: formatIndianRupee(totalSaved),
                color: barColor,
                icon: Icons.trending_up_rounded,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: totalGoal > 0
                  ? (totalSaved / totalGoal).clamp(0.0, 1.0)
                  : 0,
              minHeight: 8,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(AccountEntity account) {
    final snap = _currentSnapshots[account.id];
    final saved = snap?.savedAmount ?? 0.0;
    final goal = account.monthlySavingsGoal;
    final percent = goal > 0 ? (saved / goal * 100).clamp(-999.0, 999.0) : 0.0;

    Color barColor;
    if (saved < 0) {
      barColor = Colors.red;
    } else if (percent < 50) {
      barColor = Colors.red;
    } else if (percent < 80) {
      barColor = Colors.amber;
    } else {
      barColor = Colors.green;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () =>
            context.pushNamed(AppRoute.accountDetail.name, extra: account),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber.withValues(alpha: 0.12),
                    radius: 18,
                    child: const Icon(
                      Icons.savings_rounded,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.accountName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          formatIndianRupee(account.currentBalance),
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${percent.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: barColor,
                    ),
                  ),
                ],
              ),
              if (goal > 0) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: (saved / goal).clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(barColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatIndianRupee(saved)} / ${formatIndianRupee(goal)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineCard(_MonthSummary month) {
    final label = _monthName(month.month);
    final isNegative = month.totalSaved < 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: isNegative
            ? BorderSide(color: Colors.red.shade200)
            : BorderSide.none,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isNegative
              ? Colors.red.withValues(alpha: 0.1)
              : Colors.green.withValues(alpha: 0.1),
          child: Icon(
            isNegative
                ? Icons.warning_amber_rounded
                : Icons.check_circle_outline_rounded,
            color: isNegative ? Colors.red : Colors.green,
            size: 20,
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isNegative ? Colors.red.shade700 : null,
          ),
        ),
        trailing: Text(
          isNegative
              ? '-${formatIndianRupee(month.totalSaved.abs())}'
              : formatIndianRupee(month.totalSaved),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isNegative ? Colors.red : Colors.green.shade700,
          ),
        ),
      ),
    );
  }

  String _monthName(int m) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[m];
  }
}

class _MonthSummary {
  final int year;
  final int month;
  final double totalSaved;
  const _MonthSummary({
    required this.year,
    required this.month,
    required this.totalSaved,
  });
}
