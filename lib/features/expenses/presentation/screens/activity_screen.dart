import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

enum _ActivityFilter { all, expenses, deposits, settlements, transfers, audits }

enum _ExpenseTypeFilter { all, personal, shared }

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final Set<String> _expandedIds = {};
  _ActivityFilter _filter = _ActivityFilter.all;
  _ExpenseTypeFilter _expenseTypeFilter = _ExpenseTypeFilter.all;
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTimeRange? _dateRange;

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
    context.read<ActivityBloc>().add(
      ActivityEvent.loadExpenses(
        month: _selectedMonth,
        rangeStart: _dateRange?.start,
        rangeEnd: _dateRange?.end,
      ),
    );
  }

  void _prevMonth() {
    _dateRange = null;
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      _load();
    });
  }

  void _nextMonth() {
    _dateRange = null;
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    final now = DateTime(DateTime.now().year, DateTime.now().month);
    if (next.isAfter(now)) return;
    setState(() {
      _selectedMonth = next;
      _load();
    });
  }

  void _clearDateRange() {
    setState(() {
      _dateRange = null;
      _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
      _load();
    });
  }

  void _clearFilters() {
    setState(() {
      _filter = _ActivityFilter.all;
      _expenseTypeFilter = _ExpenseTypeFilter.all;
    });
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final monthEnd = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange:
          _dateRange ??
          DateTimeRange(
            start: _selectedMonth,
            end: monthEnd.isAfter(now) ? now : monthEnd,
          ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _dateRange = picked;
      _selectedMonth = DateTime(picked.start.year, picked.start.month);
      _load();
    });
  }

  String? _nickname(String userId) {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname;
  }

  double _userShare(String currentUserId, ExpenseEntity expense) {
    if (expense.expenseType == ExpenseType.personal) return expense.amount;
    final participant = expense.participants
        .where((p) => p.userId == currentUserId)
        .firstOrNull;
    return participant?.amount ?? 0;
  }

  List<ActivityItem> _visibleItems(List<ActivityItem> items, String? userId) {
    var filtered = items;
    if (_filter == _ActivityFilter.expenses) {
      filtered = items.whereType<ExpenseItem>().toList();
    } else if (_filter == _ActivityFilter.deposits) {
      filtered = items
          .where(
            (i) =>
                (i is SettlementItem && i.settlement.toUserId == userId) ||
                i is IncomeItem ||
                i is ManualDepositItem,
          )
          .toList();
    } else if (_filter == _ActivityFilter.settlements) {
      filtered = items.whereType<SettlementItem>().toList();
    } else if (_filter == _ActivityFilter.transfers) {
      filtered = items.whereType<TransferActivityItem>().toList();
    } else if (_filter == _ActivityFilter.audits) {
      filtered = items.whereType<BalanceCorrectionItem>().toList();
    }

    if (_expenseTypeFilter != _ExpenseTypeFilter.all) {
      filtered = filtered.where((item) {
        if (item is! ExpenseItem) return true;
        return item.expense.expenseType.name == _expenseTypeFilter.name;
      }).toList();
    }

    return filtered;
  }

  ({double spent, double deposited, int spentCount, int depositCount})
  _visibleTotals(List<ActivityItem> items, String? userId) {
    var spent = 0.0;
    var deposited = 0.0;
    var spentCount = 0;
    var depositCount = 0;

    for (final item in items) {
      switch (item) {
        case ExpenseItem(:final expense):
          spent += userId != null
              ? _userShare(userId, expense)
              : expense.amount;
          spentCount += 1;
        case SettlementItem(:final settlement):
          if (settlement.toUserId == userId) {
            deposited += settlement.amount;
            depositCount += 1;
          } else {
            spent += settlement.amount;
            spentCount += 1;
          }
        case IncomeItem(:final income):
          deposited += income.amount;
          depositCount += 1;
        case ManualDepositItem(:final deposit):
          deposited += deposit.amount;
          depositCount += 1;
        case TransferActivityItem(:final transfer, :final isIncoming):
          if (isIncoming) {
            deposited += transfer.amount;
            depositCount += 1;
          } else {
            spent += transfer.amount;
            spentCount += 1;
          }
        case BalanceCorrectionItem():
          break;
      }
    }

    return (
      spent: spent,
      deposited: deposited,
      spentCount: spentCount,
      depositCount: depositCount,
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SheetGrabber(),
                const SizedBox(height: 12),
                const Text(
                  'Filter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                _filterOption(
                  label: 'All',
                  value: _ActivityFilter.all,
                  icon: Icons.all_inclusive_rounded,
                ),
                _filterOption(
                  label: 'Expenses only',
                  value: _ActivityFilter.expenses,
                  icon: Icons.shopping_bag_rounded,
                ),
                _filterOption(
                  label: 'Deposits only',
                  value: _ActivityFilter.deposits,
                  icon: Icons.account_balance_rounded,
                ),
                _filterOption(
                  label: 'Settlements only',
                  value: _ActivityFilter.settlements,
                  icon: Icons.swap_horiz_rounded,
                ),
                _filterOption(
                  label: 'Transfers only',
                  value: _ActivityFilter.transfers,
                  icon: Icons.compare_arrows_rounded,
                ),
                _filterOption(
                  label: 'Audit entries',
                  value: _ActivityFilter.audits,
                  icon: Icons.fact_check_rounded,
                ),
                const SizedBox(height: 8),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Expense type',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                _expenseTypeOption(
                  label: 'Both',
                  value: _ExpenseTypeFilter.all,
                  icon: Icons.all_inclusive_rounded,
                ),
                _expenseTypeOption(
                  label: 'Personal',
                  value: _ExpenseTypeFilter.personal,
                  icon: Icons.person_rounded,
                ),
                _expenseTypeOption(
                  label: 'Shared',
                  value: _ExpenseTypeFilter.shared,
                  icon: Icons.groups_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterOption({
    required String label,
    required _ActivityFilter value,
    required IconData icon,
  }) {
    final isSelected = _filter == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        label,
        style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : null),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () {
        setState(() => _filter = value);
        context.pop();
      },
    );
  }

  Widget _expenseTypeOption({
    required String label,
    required _ExpenseTypeFilter value,
    required IconData icon,
  }) {
    final isSelected = _expenseTypeFilter == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        label,
        style: TextStyle(fontWeight: isSelected ? FontWeight.w600 : null),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () {
        setState(() => _expenseTypeFilter = value);
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: const Text('Activity'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
            onPressed: () => context.pushNamed(AppRoute.searchActivity.name),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Filter',
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMonthBar(),
          _buildStatisticsSummary(),
          Expanded(
            child: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  empty: () => const FinanceEmptyState(
                    icon: Icons.receipt_long_rounded,
                    title: 'No activity yet',
                    subtitle:
                        'Your expenses, income, and settlements will appear here.',
                  ),
                  error: (message) => FinanceEmptyState(
                    icon: Icons.cloud_off_rounded,
                    title: 'Could not load activity',
                    subtitle: message,
                  ),
                  loaded: (items) {
                    final userId = sl<AuthLocalDatasource>().getUserId();

                    final filtered = _visibleItems(items, userId);

                    if (filtered.isEmpty) {
                      return FinanceEmptyState(
                        icon: Icons.search_off_rounded,
                        title: 'No matching transactions',
                        subtitle:
                            'Try another month or clear the active filters.',
                        action: OutlinedButton.icon(
                          onPressed: _clearFilters,
                          icon: const Icon(Icons.filter_alt_off_rounded),
                          label: const Text('Clear filters'),
                        ),
                      );
                    }

                    final grouped = <String, List<ActivityItem>>{};
                    for (final item in filtered) {
                      final key = DateFormat('MMMM yyyy').format(item.date);
                      grouped.putIfAbsent(key, () => []).add(item);
                    }

                    final sortedKeys = grouped.keys.toList()
                      ..sort((a, b) {
                        final da = DateFormat('MMMM yyyy').parse(a);
                        final db = DateFormat('MMMM yyyy').parse(b);
                        return db.compareTo(da);
                      });

                    return RefreshIndicator(
                      onRefresh: () async {
                        _load();
                        await context.read<ActivityBloc>().stream.firstWhere(
                          (s) => s is! ActivityLoading,
                        );
                      },
                      child: CustomScrollView(
                        slivers: [
                          for (int i = 0; i < sortedKeys.length; i++) ...[
                            /// Divider before each month group (except the first)
                            if (i > 0)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: _MonthHeaderDelegate(
                                monthLabel: sortedKeys[i],
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final item = grouped[sortedKeys[i]]![index];
                                final card = switch (item) {
                                  ExpenseItem(:final expense) =>
                                    _buildExpenseCard(expense, userId),
                                  SettlementItem(
                                    :final settlement,
                                    :final depositAccountName,
                                  ) =>
                                    _buildSettlementCard(
                                      settlement,
                                      depositAccountName,
                                      userId,
                                    ),
                                  IncomeItem(
                                    :final income,
                                    :final accountName,
                                  ) =>
                                    _buildIncomeCard(income, accountName),
                                  ManualDepositItem(
                                    :final deposit,
                                    :final accountName,
                                  ) =>
                                    _buildManualDepositCard(
                                      deposit,
                                      accountName,
                                    ),
                                  TransferActivityItem(
                                    :final transfer,
                                    :final isIncoming,
                                    :final accountName,
                                    :final linkedAccountName,
                                  ) =>
                                    _buildTransferCard(
                                      transfer,
                                      isIncoming,
                                      accountName,
                                      linkedAccountName,
                                    ),
                                  BalanceCorrectionItem(
                                    :final deposit,
                                    :final accountName,
                                  ) =>
                                    _buildBalanceCorrectionCard(
                                      deposit,
                                      accountName,
                                    ),
                                };
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom:
                                        index ==
                                            grouped[sortedKeys[i]]!.length - 1
                                        ? 0
                                        : 12,
                                  ),
                                  child: card,
                                );
                              }, childCount: grouped[sortedKeys[i]]!.length),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthBar() {
    final now = DateTime.now();
    final label = _dateRange == null
        ? DateFormat('MMM yyyy').format(_selectedMonth)
        : '${DateFormat('dd MMM').format(_dateRange!.start)} – ${DateFormat('dd MMM yyyy').format(_dateRange!.end)}';
    final isAtCurrent =
        _selectedMonth.month == now.month && _selectedMonth.year == now.year;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: _prevMonth,
            tooltip: 'Previous month',
          ),
          GestureDetector(
            onTap: _dateRange == null ? null : _clearDateRange,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_dateRange != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right_rounded,
              color: isAtCurrent ? Theme.of(context).disabledColor : null,
            ),
            onPressed: isAtCurrent ? null : _nextMonth,
            tooltip: 'Next month',
          ),
          const Spacer(),
          IconButton(
            onPressed: _pickDateRange,
            icon: const Icon(Icons.calendar_month_rounded),
            tooltip: 'Pick date range',
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSummary() {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) => state.maybeWhen(
        loaded: (items) {
          final userId = sl<AuthLocalDatasource>().getUserId();
          final visible = _visibleItems(items, userId);
          final totals = _visibleTotals(visible, userId);
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _ActivityMetricCard(
                        label: 'Total Spent',
                        value: formatIndianRupee(totals.spent),
                        subtext: '${totals.spentCount} visible outflows',
                        icon: Icons.arrow_upward_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActivityMetricCard(
                        label: 'Deposited',
                        value: formatIndianRupee(totals.deposited),
                        subtext: '${totals.depositCount} visible inflows',
                        icon: Icons.arrow_downward_rounded,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Showing ${visible.length} transactions',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () =>
                        context.pushNamed(AppRoute.statistics.name),
                    icon: const Icon(Icons.bar_chart_rounded, size: 18),
                    label: const Text('View more stats'),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: LinearProgressIndicator(),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildExpenseCard(ExpenseEntity expense, String? userId) {
    final isExpanded = _expandedIds.contains(expense.id);
    final shareAmount = userId != null
        ? _userShare(userId, expense)
        : expense.amount;
    final isPayer = userId != null && expense.paidByUserId == userId;
    final paidByNickname =
        _nickname(expense.paidByUserId) ?? expense.paidByUserId;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(expense.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: expense.expenseType == ExpenseType.shared
                    ? Icons.groups_rounded
                    : Icons.person_rounded,
                iconColor: expense.expenseType == ExpenseType.shared
                    ? Colors.orange
                    : Colors.green,
                title: expense.title,
                date: expense.expenseDate,
                amount: shareAmount,
                badge: expense.expenseType.name.toUpperCase(),
                badgeColor: expense.expenseType == ExpenseType.shared
                    ? Colors.orange
                    : Colors.green,
                isExpanded: isExpanded,
                category: expense.category,
                onDetailTap: () => _showTransactionDetail(expense),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.paypal_rounded,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isPayer
                                ? 'Paid by You'
                                : 'Paid by @$paidByNickname',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (expense.expenseType == ExpenseType.shared) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Split',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...expense.participants.map((p) {
                          final pNickname = _nickname(p.userId) ?? p.userId;
                          final isMe = p.userId == userId;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(
                                  isMe
                                      ? Icons.person_rounded
                                      : Icons.person_outline_rounded,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    isMe ? 'You' : '@$pNickname',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Text(
                                  formatIndianRupee(p.amount),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                      const SizedBox(height: 6),
                      Text(
                        'Total: ${formatIndianRupee(expense.amount)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettlementCard(
    SettlementEntity settlement,
    String? depositAccountName,
    String? userId,
  ) {
    final s = settlement;
    final isExpanded = _expandedIds.contains(s.id);
    final isPayer = s.fromUserId == userId;
    final otherId = isPayer ? s.toUserId : s.fromUserId;
    final otherNickname = _nickname(otherId) ?? otherId;
    final title = isPayer
        ? 'Settlement to @$otherNickname'
        : 'Settlement from @$otherNickname';

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(s.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: Icons.swap_horiz_rounded,
                iconColor: Colors.blue,
                title: title,
                date: s.resolvedAt ?? s.createdAt,
                amount: s.amount,
                badge: 'SETTLEMENT',
                badgeColor: Colors.blue,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.person_rounded,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isPayer
                                ? 'Paid to @$otherNickname'
                                : 'Received from @$otherNickname',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (depositAccountName != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Deposited to $depositAccountName',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeCard(IncomeEntity income, String? accountName) {
    final isExpanded = _expandedIds.contains(income.id);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(income.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: income.source.icon,
                iconColor: Colors.green,
                title: income.description,
                date: income.createdAt,
                amount: income.amount,
                badge: 'INCOME',
                badgeColor: Colors.green,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            income.source.icon,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            income.source.label,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      if (accountName != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Credited to $accountName',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManualDepositCard(
    ManualDepositDto deposit,
    String? accountName,
  ) {
    final isExpanded = _expandedIds.contains(deposit.id);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(deposit.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: Icons.account_balance_wallet_rounded,
                iconColor: Colors.green,
                title: deposit.description.isEmpty
                    ? 'Manual deposit'
                    : deposit.description,
                date: deposit.createdAt,
                amount: deposit.amount,
                badge: 'DEPOSIT',
                badgeColor: Colors.green,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _accountDetailLine(
                    icon: Icons.account_balance_rounded,
                    text: accountName == null
                        ? 'Manual deposit'
                        : 'Deposited to $accountName',
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransferCard(
    TransferDto transfer,
    bool isIncoming,
    String? accountName,
    String? linkedAccountName,
  ) {
    final id = '${transfer.id}:${isIncoming ? 'in' : 'out'}';
    final isExpanded = _expandedIds.contains(id);
    final title = isIncoming ? 'Transfer in' : 'Transfer out';
    final detail = isIncoming
        ? 'From ${linkedAccountName ?? 'another account'} to ${accountName ?? 'this account'}'
        : 'From ${accountName ?? 'this account'} to ${linkedAccountName ?? 'another account'}';

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: isIncoming
                    ? Icons.call_received_rounded
                    : Icons.call_made_rounded,
                iconColor: Colors.indigo,
                title: transfer.description.isEmpty
                    ? title
                    : transfer.description,
                date: transfer.createdAt,
                amount: transfer.amount,
                badge: isIncoming ? 'TRANSFER IN' : 'TRANSFER OUT',
                badgeColor: Colors.indigo,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _accountDetailLine(
                    icon: Icons.compare_arrows_rounded,
                    text: detail,
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCorrectionCard(
    ManualDepositDto deposit,
    String? accountName,
  ) {
    final isExpanded = _expandedIds.contains(deposit.id);
    final previous = deposit.previousBalance;
    final updated = deposit.newBalance;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(deposit.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: Icons.fact_check_rounded,
                iconColor: Colors.orange,
                title: deposit.description.isEmpty
                    ? 'Balance correction'
                    : deposit.description,
                date: deposit.createdAt,
                amount: deposit.amount,
                badge: 'AUDIT',
                badgeColor: Colors.orange,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      _accountDetailLine(
                        icon: Icons.account_balance_rounded,
                        text: accountName == null
                            ? 'Balance correction'
                            : 'Corrected $accountName',
                      ),
                      if (previous != null && updated != null) ...[
                        const SizedBox(height: 6),
                        _accountDetailLine(
                          icon: Icons.edit_note_rounded,
                          text:
                              '${formatIndianRupee(previous)} to ${formatIndianRupee(updated)}',
                        ),
                      ],
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountDetailLine({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(String category, ThemeData theme) {
    final catEnum = ExpenseCategory.values
        .where((c) => c.name == category)
        .firstOrNull;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color:
            catEnum?.color.withValues(alpha: 0.15) ??
            theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(catEnum?.icon, size: 10, color: catEnum?.color),
          const SizedBox(width: 4),
          Text(
            catEnum?.label ?? category,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: catEnum?.color,
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetail(ExpenseEntity expense) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TransactionDetailSheet(expense: expense),
    );
  }

  Widget _cardHeader({
    required IconData icon,
    required MaterialColor iconColor,
    required String title,
    required DateTime date,
    required double amount,
    required String badge,
    required MaterialColor badgeColor,
    required bool isExpanded,
    String? category,
    VoidCallback? onDetailTap,
  }) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy').format(date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (isExpanded) ...[
                    Text(
                      DateFormat('h:mm a').format(date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                  if (category != null &&
                      category != ExpenseCategory.other.name)
                    _buildCategoryBadge(category, Theme.of(context)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatIndianRupee(amount),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (onDetailTap != null) ...[
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 20),
            onPressed: onDetailTap,
            tooltip: 'View details',
            visualDensity: VisualDensity.compact,
          ),
        ],
        AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }
}

extension on Set<String> {
  void toggle(String id) {
    if (contains(id)) {
      remove(id);
    } else {
      add(id);
    }
  }
}

class _ActivityMetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtext;
  final IconData icon;
  final Color color;

  const _ActivityMetricCard({
    required this.label,
    required this.value,
    required this.subtext,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              subtext,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String monthLabel;

  _MonthHeaderDelegate({required this.monthLabel});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 40,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          monthLabel,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant _MonthHeaderDelegate oldDelegate) {
    return monthLabel != oldDelegate.monthLabel;
  }
}
