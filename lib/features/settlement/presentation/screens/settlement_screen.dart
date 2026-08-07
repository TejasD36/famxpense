import '../../xcore.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import 'partner_settlement_detail_screen.dart';

class _PartnerData {
  final String partnerId;
  final String partnerName;
  final double balance;

  _PartnerData(this.partnerId, this.partnerName, this.balance);
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

  String? _userId;
  List<_PartnerData> _partners = [];
  List<SettlementEntity> _incomingPending = [];
  List<SettlementEntity> _outgoingPending = [];
  bool _loading = true;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_onRefresh);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onRefresh);
    super.dispose();
  }

  void _onRefresh() {
    if (!_initialized) return;
    _loadData();
  }

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
      sl<DebtLedgerLocalDatasource>().getLedgers(),
    ]);

    final allSettlements = (results[0] as List<SettlementDto>)
        .where((d) => d.fromUserId == userId || d.toUserId == userId)
        .map((d) => d.toEntity())
        .toList();

    final debtLedgers = results[1] as List<DebtLedgerDto>;

    /// Build partner list from non-zero debt ledgers
    final partners = <_PartnerData>[];
    for (final d in debtLedgers) {
      String partnerId;
      double balance;
      if (d.userA == userId) {
        partnerId = d.userB;
        balance = d.netBalance;
      } else if (d.userB == userId) {
        partnerId = d.userA;
        balance = -d.netBalance;
      } else {
        continue;
      }
      final nickname = _nickname(partnerId) ?? partnerId.substring(0, 6);
      partners.add(_PartnerData(partnerId, nickname, balance));
    }

    /// Pending settlements
    final incomingPending =
        allSettlements
            .where(
              (s) =>
                  s.toUserId == userId && s.status == SettlementStatus.pending,
            )
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final outgoingPending =
        allSettlements
            .where(
              (s) =>
                  s.fromUserId == userId &&
                  s.status == SettlementStatus.pending,
            )
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (!mounted) return;
    setState(() {
      _partners = partners;
      _incomingPending = incomingPending;
      _outgoingPending = outgoingPending;
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
      initialDateRange:
          _dateRange ??
          DateTimeRange(
            start: _selectedMonth,
            end:
                DateTime(
                  _selectedMonth.year,
                  _selectedMonth.month + 1,
                  0,
                ).isAfter(now)
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

  String? _nickname(String userId) {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// Compute summary from partners list
    double iAmOwed = 0;
    double iOwe = 0;
    for (final p in _partners) {
      if (p.balance < 0) {
        iAmOwed += p.balance.abs();
      } else {
        iOwe += p.balance;
      }
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
                  SliverToBoxAdapter(child: _buildMonthBar(context)),

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
                  if (_incomingPending.isNotEmpty ||
                      _outgoingPending.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Pending Settlements',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    ..._incomingPending.map(
                      (s) => _buildPendingSettlementCard(
                        context,
                        s,
                        isIncoming: true,
                      ),
                    ),
                    ..._outgoingPending.map(
                      (s) => _buildPendingSettlementCard(
                        context,
                        s,
                        isIncoming: false,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 24, color: theme.dividerColor),
                      ),
                    ),
                  ],

                  /// Partners section header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Partners',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                  /// Partner list
                  if (_partners.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        child: Center(
                          child: Text(
                            'No outstanding balances',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildPartnerCard(context, _partners[index], theme),
                        childCount: _partners.length,
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildMonthBar(BuildContext context) {
    final now = DateTime.now();
    final isAtCurrentMonth =
        _selectedMonth.month == now.month && _selectedMonth.year == now.year;

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
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: _prevMonth,
            ),
            Text(
              DateFormat('MMM yyyy').format(_selectedMonth),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: Icon(
                Icons.chevron_right_rounded,
                color: isAtCurrentMonth
                    ? Theme.of(context).disabledColor
                    : null,
              ),
              onPressed: isAtCurrentMonth ? null : _nextMonth,
            ),
          ],
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: _pickDateRange,
            tooltip: 'Pick date range',
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(
    BuildContext context,
    _PartnerData partner,
    ThemeData theme,
  ) {
    final isSettled = partner.balance == 0;
    final isOwed = partner.balance < 0;
    final absBalance = partner.balance.abs();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: isSettled
                ? Colors.grey.withValues(alpha: 0.12)
                : (isOwed ? Colors.green : Colors.red).withValues(alpha: 0.12),
            child: Icon(
              isSettled
                  ? Icons.check_circle_outline_rounded
                  : (isOwed ? Icons.call_received_rounded : Icons.send_rounded),
              size: 18,
              color: isSettled
                  ? Colors.grey
                  : (isOwed ? Colors.green : Colors.red),
            ),
          ),
          title: Text(
            '@${partner.partnerName}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          subtitle: Text(
            isSettled ? 'All settled' : (isOwed ? 'Owes you' : 'You owe'),
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isSettled) ...[
                Text(
                  formatIndianRupee(absBalance),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isOwed ? Colors.green : Colors.red,
                  ),
                ),
              ] else
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade400,
                  size: 20,
                ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PartnerSettlementDetailScreen(
                  partnerId: partner.partnerId,
                  partnerName: partner.partnerName,
                ),
              ),
            ).then((_) => _loadData());
          },
        ),
      ),
    );
  }

  Widget _buildPendingSettlementCard(
    BuildContext context,
    SettlementEntity s, {
    required bool isIncoming,
  }) {
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
                      backgroundColor: isIncoming
                          ? Colors.green.withValues(alpha: 0.12)
                          : Colors.orange.withValues(alpha: 0.12),
                      child: Icon(
                        isIncoming
                            ? Icons.call_received_rounded
                            : Icons.send_rounded,
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
                            isIncoming
                                ? 'Settlement from @$otherName'
                                : 'Settlement to @$otherName',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'dd MMM yyyy, HH:mm',
                            ).format(s.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatIndianRupee(s.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isIncoming ? Colors.green : Colors.red,
                      ),
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
                                  await sl<ProcessSettlementUsecase>().reject(
                                    settlementId: s.id,
                                  );
                                  sl<RefreshNotifier>().notifyDataChanged();
                                  await _loadData();
                                } catch (e) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to reject: $e'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() => _rejectingIds.remove(s.id));
                                  }
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
                                  await sl<ProcessSettlementUsecase>().confirm(
                                    settlementId: s.id,
                                    toAccountId: null,
                                  );
                                  sl<RefreshNotifier>().notifyDataChanged();
                                  await _loadData();
                                } catch (e) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to confirm: $e'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() => _confirmingIds.remove(s.id));
                                  }
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
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              formatIndianRupee(amount),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: amount > 0
                    ? color
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
