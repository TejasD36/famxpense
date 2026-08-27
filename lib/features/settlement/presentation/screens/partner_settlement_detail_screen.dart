import '../../xcore.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/presentation/widgets/account_picker_sheet.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../expenses/data/datasources/local/expense_local_datasource.dart';

class PartnerSettlementDetailScreen extends StatefulWidget {
  final String partnerId;
  final String partnerName;

  const PartnerSettlementDetailScreen({
    super.key,
    required this.partnerId,
    required this.partnerName,
  });

  @override
  State<PartnerSettlementDetailScreen> createState() =>
      _PartnerSettlementDetailScreenState();
}

class _PartnerSettlementDetailScreenState
    extends State<PartnerSettlementDetailScreen> {
  String? _userId;
  List<ExpenseEntity> _expenses = [];
  List<SettlementEntity> _settlements = [];
  double _partnerBalance = 0;
  bool _loading = true;
  bool _initialized = false;
  bool _settling = false;

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

    final partnerId = widget.partnerId;

    final results = await Future.wait([
      sl<SettlementLocalDatasource>().getSettlements(),
      sl<ExpenseLocalDatasource>().getExpenses(ownerUserId: userId),
      sl<DebtLedgerLocalDatasource>().getLedgers(),
    ]);

    final allSettlements = (results[0] as List<SettlementDto>)
        .where(
          (d) =>
              (d.fromUserId == userId && d.toUserId == partnerId) ||
              (d.fromUserId == partnerId && d.toUserId == userId),
        )
        .map((d) => d.toEntity())
        .toList();

    final allExpenses = (results[1] as List<ExpenseDto>)
        .where(
          (d) =>
              d.expenseType == ExpenseType.shared &&
              d.participants.any((p) => p.userId == userId) &&
              d.participants.any((p) => p.userId == partnerId),
        )
        .map((d) => d.toEntity())
        .toList();

    final ledgers = results[2] as List<DebtLedgerDto>;
    double balance = 0;
    for (final d in ledgers) {
      if ((d.userA == userId && d.userB == partnerId) ||
          (d.userA == partnerId && d.userB == userId)) {
        balance = d.userA == userId ? d.netBalance : -d.netBalance;
        break;
      }
    }

    if (!mounted) return;
    setState(() {
      _settlements = allSettlements;
      _expenses = allExpenses;
      _partnerBalance = balance;
      _loading = false;
    });
  }

  double _userShare(ExpenseEntity expense) {
    final userId = _userId;
    if (userId == null) return 0;
    final p = expense.participants.where((p) => p.userId == userId).firstOrNull;
    return p?.amount ?? 0;
  }

  Future<void> _handleSettle() async {
    final userId = _userId;
    if (userId == null || _partnerBalance <= 0) return;
    final messenger = ScaffoldMessenger.of(context);

    /// Pick an account to deduct from
    final accountDtos = await sl<AccountLocalDatasource>().getAccounts();
    final userAccounts = accountDtos
        .where((a) => a.userId == userId && !a.isArchived)
        .map((d) => d.toEntity())
        .toList();
    AccountEntity? selectedAccount;
    if (userAccounts.isNotEmpty) {
      final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
      selectedAccount = defaultId != null
          ? userAccounts.where((a) => a.id == defaultId).firstOrNull ??
                userAccounts.first
          : userAccounts.first;
      if (userAccounts.length > 1) {
        if (!mounted) return;
        selectedAccount =
            await showModalBottomSheet<AccountEntity>(
              context: context,
              builder: (ctx) => AccountPickerSheet(
                accounts: userAccounts,
                selectedAccountId: selectedAccount?.id,
                onSelected: (a) {
                  Navigator.of(ctx).pop(a);
                },
                onAddNew: () => Navigator.of(context).pop(),
              ),
            ) ??
            selectedAccount;
      }
    }

    if (selectedAccount?.isSavings == true) {
      if (!mounted) return;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Savings Account'),
          content: const Text(
            'Settling from savings will reduce your monthly savings progress. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Use anyway'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }

    if (!mounted) return;
    setState(() => _settling = true);
    try {
      final error = await sl<SettleDebtUsecase>().call(
        fromUserId: userId,
        toUserId: widget.partnerId,
        amount: _partnerBalance,
        fromAccountId: selectedAccount?.id,
      );
      if (error != null) {
        messenger.showSnackBar(
          SnackBar(content: Text(error), behavior: SnackBarBehavior.floating),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Settlement request sent to @${widget.partnerName}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        await _loadData();
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to create settlement: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _settling = false);
    }
  }

  Future<void> _handleCancel(SettlementEntity settlement) async {
    setState(() => _settling = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await sl<SettleDebtUsecase>().cancel(settlement.id);
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Settlement request cancelled'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _loadData();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to cancel: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _settling = false);
    }
  }

  Future<void> _handleConfirm(SettlementEntity settlement) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await sl<ProcessSettlementUsecase>().confirm(
        settlementId: settlement.id,
        toAccountId: null,
      );
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Settlement confirmed'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _loadData();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to confirm: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _handleReject(SettlementEntity settlement) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await sl<ProcessSettlementUsecase>().reject(settlementId: settlement.id);
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Settlement rejected'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      await _loadData();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to reject: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = _userId ?? '';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('@${widget.partnerName}')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _buildContent(context, userId, theme),
            ),
    );
  }

  Widget _buildContent(BuildContext context, String userId, ThemeData theme) {
    final isOwed = _partnerBalance < 0;
    final owesPartner = _partnerBalance > 0;
    final absBalance = _partnerBalance.abs();

    /// Identify pending settlements
    final incomingPending = _settlements
        .where(
          (s) => s.toUserId == userId && s.status == SettlementStatus.pending,
        )
        .toList();
    final outgoingPending = _settlements
        .where(
          (s) => s.fromUserId == userId && s.status == SettlementStatus.pending,
        )
        .toList();

    /// Has a pending outgoing we can show cancel for
    final hasOutgoingPending = outgoingPending.isNotEmpty;
    final hasIncomingPending = incomingPending.isNotEmpty;

    /// Build combined sorted item list (only completed/confirmed/rejected items)
    final items = <_ItemData>[];
    for (final e in _expenses) {
      items.add(_ItemData(e, null, e.expenseDate));
    }
    for (final s in _settlements.where(
      (s) => s.status != SettlementStatus.pending,
    )) {
      items.add(_ItemData(null, s, s.createdAt));
    }
    items.sort((a, b) => b.date.compareTo(a.date));

    return CustomScrollView(
      slivers: [
        /// Stat card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GradientPatternPanel(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            (_partnerBalance == 0
                                    ? Colors.grey
                                    : isOwed
                                    ? Colors.green
                                    : Colors.red)
                                .withValues(alpha: 0.12),
                        child: Icon(
                          _partnerBalance == 0
                              ? Icons.check_circle_outline_rounded
                              : isOwed
                              ? Icons.call_received_rounded
                              : Icons.send_rounded,
                          size: 20,
                          color: _partnerBalance == 0
                              ? Colors.grey
                              : isOwed
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _partnerBalance == 0
                                  ? 'All settled'
                                  : isOwed
                                  ? '@${widget.partnerName} owes you'
                                  : 'You owe @${widget.partnerName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formatIndianRupee(absBalance),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: _partnerBalance == 0
                                    ? Colors.grey
                                    : isOwed
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (owesPartner && !hasOutgoingPending) ...[
                    const SizedBox(height: 12),
                    if (owesPartner && !hasOutgoingPending)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _settling ? null : _handleSettle,
                          icon: _settling
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send_rounded),
                          label: Text(_settling ? 'Sending...' : 'Settle'),
                        ),
                      ),
                  ],
                  if (hasOutgoingPending) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.hourglass_empty_rounded,
                            size: 16,
                            color: Colors.orange.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Settlement pending',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: _settling
                                ? null
                                : () => _handleCancel(outgoingPending.first),
                            icon: const Icon(Icons.close_rounded, size: 16),
                            label: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 13),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        /// Incoming pending section
        if (hasIncomingPending)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Pending Request',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ...incomingPending.map(
          (s) => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                elevation: 0,
                color: Colors.orange.withValues(alpha: 0.05),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.orange.withValues(
                              alpha: 0.12,
                            ),
                            child: const Icon(
                              Icons.call_received_rounded,
                              size: 18,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Settlement from @${widget.partnerName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                    'dd MMM yyyy · h:mm a',
                                  ).format(s.createdAt),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            formatIndianRupee(s.amount),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: _settling
                                ? null
                                : () => _handleReject(s),
                            child: const Text('Reject'),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: _settling
                                ? null
                                : () => _handleConfirm(s),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        if (hasIncomingPending && items.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 24, color: theme.dividerColor),
            ),
          ),

        /// Transactions header
        if (items.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Transactions',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),

        /// Items
        if (items.isEmpty && !hasIncomingPending)
          SliverFillRemaining(
            child: FinanceEmptyState(
              icon: Icons.receipt_long_rounded,
              title: 'No transactions yet',
              subtitle:
                  'Shared expenses and settlements with @${widget.partnerName} will appear here.',
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = items[index];
              if (item.expense != null) {
                return _buildExpenseTile(context, item.expense!, userId, theme);
              }
              return _buildSettlementTile(
                context,
                item.settlement!,
                userId,
                theme,
              );
            }, childCount: items.length),
          ),
      ],
    );
  }

  Widget _buildExpenseTile(
    BuildContext context,
    ExpenseEntity expense,
    String userId,
    ThemeData theme,
  ) {
    final isPayer = expense.paidByUserId == userId;
    final shareAmount = _userShare(expense);
    final otherName = widget.partnerName;
    final title = isPayer
        ? 'Shared with @$otherName'
        : '@$otherName\'s expense';
    final subtitle =
        '${expense.title} · ${DateFormat('dd MMM yyyy · h:mm a').format(expense.expenseDate)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.withValues(alpha: 0.12),
            child: const Icon(
              Icons.shopping_bag_rounded,
              size: 18,
              color: Colors.blue,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Text(
            formatIndianRupeeSigned(isPayer ? shareAmount : -shareAmount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isPayer ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettlementTile(
    BuildContext context,
    SettlementEntity s,
    String userId,
    ThemeData theme,
  ) {
    final isPayer = s.fromUserId == userId;
    final otherName = widget.partnerName;
    final isPending = s.status == SettlementStatus.pending;
    final title = isPayer
        ? 'Settlement to @$otherName'
        : 'Settlement from @$otherName';
    final subtitle = isPending
        ? 'Pending confirmation · ${DateFormat('dd MMM yyyy · h:mm a').format(s.createdAt)}'
        : DateFormat('dd MMM yyyy · h:mm a').format(s.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor:
                (isPending
                        ? Colors.orange
                        : isPayer
                        ? Colors.red
                        : Colors.green)
                    .withValues(alpha: 0.12),
            child: Icon(
              isPending
                  ? Icons.hourglass_empty_rounded
                  : isPayer
                  ? Icons.send_rounded
                  : Icons.call_received_rounded,
              size: 18,
              color: isPending
                  ? Colors.orange
                  : isPayer
                  ? Colors.red
                  : Colors.green,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Text(
            formatIndianRupeeSigned(isPayer ? -s.amount : s.amount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isPayer ? Colors.red : Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemData {
  final ExpenseEntity? expense;
  final SettlementEntity? settlement;
  final DateTime date;

  _ItemData(this.expense, this.settlement, this.date);
}
