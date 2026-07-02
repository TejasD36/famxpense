import '../../xcore.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../expenses/data/datasources/local/expense_local_datasource.dart';

enum _SettlementFilter { all, pending, completed }

sealed class _SettlementListItem {
  final String id;
  final DateTime date;
  final double amount;
  _SettlementListItem({required this.id, required this.date, required this.amount});
}

class _ExpenseListItem extends _SettlementListItem {
  final ExpenseEntity expense;
  _ExpenseListItem(this.expense) : super(id: expense.id, date: expense.expenseDate, amount: expense.amount);
}

class _SettlementListItemData extends _SettlementListItem {
  final SettlementEntity settlement;
  _SettlementListItemData(this.settlement) : super(id: settlement.id, date: settlement.createdAt, amount: settlement.amount);
}

class SettlementScreen extends StatefulWidget {
  const SettlementScreen({super.key});

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  final Set<String> _confirmingIds = {};
  final Set<String> _rejectingIds = {};

  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  DateTimeRange? _dateRange;
  _SettlementFilter _filter = _SettlementFilter.all;

  String? _userId;
  List<SettlementEntity> _allSettlements = [];
  List<ExpenseEntity> _expenses = [];
  List<DebtLedgerDto> _debtLedgers = [];
  bool _loading = true;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _userId = sl<AuthLocalDatasource>().getUserId();
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final userId = _userId;
    if (userId == null) return;

    setState(() => _loading = true);

    final results = await Future.wait([
      sl<SettlementLocalDatasource>().getSettlements(),
      sl<ExpenseLocalDatasource>().getExpenses(ownerUserId: userId),
      sl<DebtLedgerLocalDatasource>().getLedgers(),
    ]);

    final allSettlements = (results[0] as List<SettlementDto>)
        .where((d) => d.fromUserId == userId || d.toUserId == userId)
        .map((d) => d.toEntity())
        .toList();

    final allExpenses = (results[1] as List<ExpenseDto>)
        .where((d) => d.expenseType == ExpenseType.shared && d.participants.any((p) => p.userId == userId))
        .map((d) => d.toEntity())
        .toList();

    if (!mounted) return;
    setState(() {
      _allSettlements = allSettlements;
      _expenses = allExpenses;
      _debtLedgers = results[2] as List<DebtLedgerDto>;
      _loading = false;
    });
  }

  void _prevMonth() {
    _dateRange = null;
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _nextMonth() {
    _dateRange = null;
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    final now = DateTime(DateTime.now().year, DateTime.now().month);
    if (next.isAfter(now)) return;
    setState(() {
      _selectedMonth = next;
    });
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: _dateRange ?? DateTimeRange(
        start: _selectedMonth,
        end: DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).isAfter(now)
            ? now
            : DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0),
      ),
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
        _selectedMonth = DateTime(picked.start.year, picked.start.month);
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _dateRange = null;
      _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
    });
  }

  bool _isCurrentMonth(DateTime d) {
    return d.month == _selectedMonth.month && d.year == _selectedMonth.year;
  }

  String? _nickname(String userId) {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname;
  }

  double _userShare(ExpenseEntity expense) {
    final userId = _userId;
    if (userId == null) return 0;
    if (expense.expenseType == ExpenseType.personal) return expense.amount;
    final p = expense.participants.where((p) => p.userId == userId).firstOrNull;
    return p?.amount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final userId = _userId ?? '';
    final theme = Theme.of(context);

    /// Compute summary
    double iAmOwed = 0;
    double iOwe = 0;
    for (final d in _debtLedgers) {
      if (d.userA == userId) {
        if (d.netBalance < 0) {
          iAmOwed += d.netBalance.abs();
        } else {
          iOwe += d.netBalance;
        }
      } else if (d.userB == userId) {
        if (d.netBalance > 0) {
          iAmOwed += d.netBalance;
        } else {
          iOwe += d.netBalance.abs();
        }
      }
    }

    final monthStr = DateFormat('MMMM yyyy').format(_selectedMonth);

    /// Filter items for the selected month
    final monthSettlements = _allSettlements.where((s) => _isCurrentMonth(s.createdAt)).toList();
    final monthExpenses = _expenses.where((e) => _isCurrentMonth(e.expenseDate)).toList();

    /// Pending settlements (always shown regardless of month filter)
    final incomingPending = _allSettlements
        .where((s) => s.toUserId == userId && s.status == SettlementStatus.pending)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final outgoingPending = _allSettlements
        .where((s) => s.fromUserId == userId && s.status == SettlementStatus.pending)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    /// Build combined list for the month
    final items = <_SettlementListItem>[];
    for (final s in monthSettlements) {
      items.add(_SettlementListItemData(s));
    }
    for (final e in monthExpenses) {
      items.add(_ExpenseListItem(e));
    }
    items.sort((a, b) => b.date.compareTo(a.date));

    /// Apply filter
    Iterable<_SettlementListItem> filteredItems = items;
    if (_filter == _SettlementFilter.pending) {
      filteredItems = items.where((i) => i is _SettlementListItemData && i.settlement.status == SettlementStatus.pending);
    } else if (_filter == _SettlementFilter.completed) {
      filteredItems = items.where((i) => i is! _SettlementListItemData || i.settlement.status != SettlementStatus.pending);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settlements')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
                  /// Month bar
                  SliverToBoxAdapter(
                    child: _buildMonthBar(context),
                  ),

                  /// Summary cards
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              label: 'You\'re owed',
                              amount: iAmOwed,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _SummaryCard(
                              label: 'You owe',
                              amount: iOwe,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Pending settlements section
                  if (incomingPending.isNotEmpty || outgoingPending.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Pending Settlements',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
                        ),
                      ),
                    ),
                    ...incomingPending.map((s) => _buildPendingSettlementCard(context, s, isIncoming: true)),
                    ...outgoingPending.map((s) => _buildPendingSettlementCard(context, s, isIncoming: false)),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 24, color: theme.dividerColor),
                      ),
                    ),
                  ],

                  /// Month header + filter chips
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        children: [
                          Text(monthStr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                          const Spacer(),
                          _FilterChip(
                            label: 'All',
                            selected: _filter == _SettlementFilter.all,
                            onTap: () => setState(() => _filter = _SettlementFilter.all),
                          ),
                          const SizedBox(width: 6),
                          _FilterChip(
                            label: 'Pending',
                            selected: _filter == _SettlementFilter.pending,
                            onTap: () => setState(() => _filter = _SettlementFilter.pending),
                          ),
                          const SizedBox(width: 6),
                          _FilterChip(
                            label: 'Completed',
                            selected: _filter == _SettlementFilter.completed,
                            onTap: () => setState(() => _filter = _SettlementFilter.completed),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Items list
                  if (filteredItems.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          _filter == _SettlementFilter.all ? 'No transactions for this month' : 'No matching transactions',
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = filteredItems.elementAt(index);
                          return _buildItemTile(context, item, userId);
                        },
                        childCount: filteredItems.length,
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildMonthBar(BuildContext context) {
    final now = DateTime.now();
    final isAtCurrentMonth = _selectedMonth.month == now.month && _selectedMonth.year == now.year;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_dateRange != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InputChip(
                  label: Text(
                    '${DateFormat('dd MMM yyyy').format(_dateRange!.start)} - ${DateFormat('dd MMM yyyy').format(_dateRange!.end)}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  deleteIcon: const Icon(Icons.close_rounded, size: 18),
                  onDeleted: _clearDateRange,
                ),
              ),
            )
          else ...[
            IconButton(icon: const Icon(Icons.chevron_left_rounded), onPressed: _prevMonth),
            Text(DateFormat('MMM yyyy').format(_selectedMonth), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            IconButton(
              icon: Icon(
                Icons.chevron_right_rounded,
                color: isAtCurrentMonth ? Theme.of(context).disabledColor : null,
              ),
              onPressed: isAtCurrentMonth ? null : _nextMonth,
            ),
          ],
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.calendar_month_rounded), onPressed: _pickDateRange, tooltip: 'Pick date range'),
        ],
      ),
    );
  }

  Widget _buildPendingSettlementCard(BuildContext context, SettlementEntity s, {required bool isIncoming}) {
    final otherId = isIncoming ? s.fromUserId : s.toUserId;
    final otherName = _nickname(otherId) ?? otherId.substring(0, 6);
    final isConfirming = _confirmingIds.contains(s.id);
    final isRejecting = _rejectingIds.contains(s.id);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: isIncoming ? Colors.green.withValues(alpha: 0.12) : Colors.orange.withValues(alpha: 0.12),
                      child: Icon(
                        isIncoming ? Icons.call_received_rounded : Icons.send_rounded,
                        size: 18,
                        color: isIncoming ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isIncoming ? 'Settlement from @$otherName' : 'Settlement to @$otherName',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy, HH:mm').format(s.createdAt),
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatIndianRupee(s.amount),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isIncoming ? Colors.green : Colors.red),
                    ),
                  ],
                ),
                if (isIncoming) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: isRejecting || isConfirming
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);
                                setState(() => _rejectingIds.add(s.id));
                                try {
                                  await sl<ProcessSettlementUsecase>().reject(settlementId: s.id);
                                  sl<RefreshNotifier>().notifyDataChanged();
                                  await _loadData();
                                } catch (e) {
                                  messenger.showSnackBar(SnackBar(
                                    content: Text('Failed to reject: $e'),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                } finally {
                                  if (mounted) setState(() => _rejectingIds.remove(s.id));
                                }
                              },
                        child: const Text('Reject'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: isConfirming || isRejecting
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);
                                setState(() => _confirmingIds.add(s.id));
                                try {
                                  await sl<ProcessSettlementUsecase>().confirm(settlementId: s.id, toAccountId: null);
                                  sl<RefreshNotifier>().notifyDataChanged();
                                  await _loadData();
                                } catch (e) {
                                  messenger.showSnackBar(SnackBar(
                                    content: Text('Failed to confirm: $e'),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                } finally {
                                  if (mounted) setState(() => _confirmingIds.remove(s.id));
                                }
                              },
                        child: Text(isConfirming ? 'Confirming...' : 'Confirm'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemTile(BuildContext context, _SettlementListItem item, String userId) {
    final theme = Theme.of(context);

    return switch (item) {
      _ExpenseListItem(:final expense) => _buildExpenseTile(context, expense, userId, theme),
      _SettlementListItemData(:final settlement) => _buildSettlementTile(context, settlement, userId, theme),
    };
  }

  Widget _buildExpenseTile(BuildContext context, ExpenseEntity expense, String userId, ThemeData theme) {
    final isPayer = expense.paidByUserId == userId;
    final shareAmount = _userShare(expense);
    final otherName = isPayer
        ? _nickname(expense.participants.where((p) => p.userId != userId).firstOrNull?.userId ?? '')
        : _nickname(expense.paidByUserId);
    final title = isPayer ? 'Shared with @$otherName' : '@$otherName\'s expense';
    final subtitle = '${expense.title} · ${DateFormat('dd MMM').format(expense.expenseDate)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.withValues(alpha: 0.12),
            child: const Icon(Icons.shopping_bag_rounded, size: 18, color: Colors.blue),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
          trailing: Text(
            formatIndianRupeeSigned(isPayer ? shareAmount : -shareAmount),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isPayer ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildSettlementTile(BuildContext context, SettlementEntity s, String userId, ThemeData theme) {
    final isPayer = s.fromUserId == userId;
    final otherId = isPayer ? s.toUserId : s.fromUserId;
    final otherName = _nickname(otherId) ?? otherId.substring(0, 6);
    final isPending = s.status == SettlementStatus.pending;
    final title = isPayer ? 'Settlement to @$otherName' : 'Settlement from @$otherName';
    final subtitle = isPending ? 'Pending confirmation · ${DateFormat('dd MMM').format(s.createdAt)}' : DateFormat('dd MMM yyyy').format(s.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: (isPending ? Colors.orange : isPayer ? Colors.red : Colors.green).withValues(alpha: 0.12),
            child: Icon(
              isPending
                  ? Icons.hourglass_empty_rounded
                  : isPayer
                      ? Icons.send_rounded
                      : Icons.call_received_rounded,
              size: 18,
              color: isPending ? Colors.orange : isPayer ? Colors.red : Colors.green,
            ),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
          trailing: Text(
            formatIndianRupeeSigned(isPayer ? -s.amount : s.amount),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isPayer ? Colors.red : Colors.green),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryCard({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 6),
            Text(
              formatIndianRupee(amount),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: amount > 0 ? color : Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : null,
            color: selected ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ),
    );
  }
}
