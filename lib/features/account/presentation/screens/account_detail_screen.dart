import 'dart:async';

import '../../xcore.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../income/domain/repositories/income_repository.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
import '../../../savings/domain/repositories/transfer_repository.dart';
import '../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../models/account_transaction.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  AccountEntity? _account;
  List<AccountTransaction> _transactions = [];
  double _totalDeposited = 0;
  double _totalSpent = 0;
  bool _loading = true;
  bool _initialized = false;
  int _refreshKey = 0;

  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_onDataChanged);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) {
      _refreshKey++;
      _loadTransactions();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _account = GoRouterState.of(context).extra as AccountEntity?;
      if (_account != null) _loadTransactions();
    }
  }

  Future<void> _loadTransactions() async {
    final account = _account;
    if (account == null) return;

    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';

    final expenseDtos = await sl<ExpenseLocalDatasource>().getExpenses(
      ownerUserId: userId,
    );
    final settlementDtos = await sl<SettlementLocalDatasource>()
        .getSettlements();
    final depositDtos = await sl<ManualDepositLocalDatasource>().getByAccount(
      account.id,
    );
    final incomeEntities = await sl<IncomeRepository>().getIncomesByAccount(
      account.id,
    );
    final transferDtos = await sl<TransferRepository>().getByAccount(
      account.id,
    );

    final defaultAccountId = await AppSettings.getDefaultAccountId(
      userId: userId,
    );

    final transactions = <AccountTransaction>[];

    double totalDeposited = 0;
    double totalSpent = 0;

    /// Expenses paid from this account
    for (final dto in expenseDtos) {
      if (dto.accountId == account.id) {
        transactions.add(ExpensePayment(dto.toEntity()));
        totalSpent += dto.amount;
      }
    }

    /// Settlements paid from this account
    for (final dto in settlementDtos) {
      final entity = dto.toEntity();
      if (entity.accountId == account.id) {
        transactions.add(SettlementPayment(entity));
        totalSpent += entity.amount;
      }
    }

    /// If this is the default account, settlement deposits received
    if (account.id == defaultAccountId) {
      for (final dto in settlementDtos) {
        final entity = dto.toEntity();

        /// Skip if already shown as a payment from this account
        if (entity.toUserId == userId && entity.accountId != account.id) {
          transactions.add(SettlementDeposit(entity));
          totalDeposited += entity.amount;
        }
      }
    }

    /// Manual deposits
    for (final dto in depositDtos) {
      transactions.add(
        ManualDepositEntry(
          id: dto.id,
          amount: dto.amount,
          description: dto.description,
          date: dto.createdAt,
          previousBalance: dto.previousBalance,
          newBalance: dto.newBalance,
          isBalanceEdit: dto.isBalanceEdit,
        ),
      );
      if (!dto.isBalanceEdit) totalDeposited += dto.amount;
    }

    /// Income entries
    for (final entity in incomeEntities) {
      transactions.add(IncomeEntry(entity));
      totalDeposited += entity.amount;
    }

    /// Transfer entries
    for (final dto in transferDtos) {
      final entity = dto.toEntity();
      final isOutgoing = entity.fromAccountId == account.id;
      transactions.add(TransferEntry(entity, isOutgoing));
      if (isOutgoing) {
        totalSpent += entity.amount;
      } else {
        totalDeposited += entity.amount;
      }
    }

    transactions.sort((a, b) => b.date.compareTo(a.date));

    if (!mounted) return;
    setState(() {
      _transactions = transactions;
      _totalDeposited = totalDeposited;
      _totalSpent = totalSpent;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final account = _account;

    return Scaffold(
      appBar: AppBar(
        title: Text(account?.accountName ?? 'Account'),
        actions: [
          if (account != null) ...[
            IconButton(
              icon: Icon(
                account.isSavings
                    ? Icons.savings_rounded
                    : Icons.savings_outlined,
                color: account.isSavings ? Colors.amber : null,
              ),
              tooltip: account.isSavings
                  ? 'Savings account'
                  : 'Mark as savings',
              onPressed: () => _toggleSavings(context, account),
            ),
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              tooltip: 'Rename',
              onPressed: () => _showRenameDialog(context, account),
            ),
            IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
              tooltip: 'Delete Account',
              onPressed: () => _confirmDelete(context, account),
            ),
          ],
        ],
      ),
      body: account == null
          ? const Center(child: Text('Account not found'))
          : RefreshIndicator(
              onRefresh: _loadTransactions,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Column(
                        children: [
                          /// Account Info Card
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    child: Icon(
                                      _iconForType(account.accountType),
                                      size: 22,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          account.accountName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          account.accountType.name
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatIndianRupee(account.currentBalance),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// Action Buttons Row
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton.tonalIcon(
                                  onPressed: () =>
                                      _showDepositDialog(context, account),
                                  icon: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Deposit'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FilledButton.tonalIcon(
                                  onPressed: () =>
                                      _showTransferDialog(context, account),
                                  icon: const Icon(
                                    Icons.swap_horiz_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Transfer'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FilledButton.tonalIcon(
                                  onPressed: () => _showUpdateBalanceDialog(
                                    context,
                                    account,
                                  ),
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    size: 18,
                                  ),
                                  label: const Text('Balance'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// Summary Bar
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _SummaryLabel(
                                      label: 'Deposited',
                                      amount: _totalDeposited,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  Expanded(
                                    child: _SummaryLabel(
                                      label: 'Spent',
                                      amount: _totalSpent,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Savings Progress Section
                          if (account.isSavings) ...[
                            _SavingsProgressCard(
                              account: account,
                              key: ValueKey(
                                'savings_${account.id}_$_refreshKey',
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          /// Transaction History Header
                          Row(
                            children: [
                              Text(
                                'Transactions',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const Spacer(),
                              if (_loading)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  if (_loading)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (_transactions.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Text(
                            'No transactions yet',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    ..._buildMonthGroups(context),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildMonthGroups(BuildContext context) {
    final grouped = <String, List<AccountTransaction>>{};
    for (final tx in _transactions) {
      final key = DateFormat('MMMM yyyy').format(tx.date);
      grouped.putIfAbsent(key, () => []).add(tx);
    }
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final da = DateFormat('MMMM yyyy').parse(a);
        final db = DateFormat('MMMM yyyy').parse(b);
        return db.compareTo(da);
      });

    final slivers = <Widget>[];
    for (int i = 0; i < sortedKeys.length; i++) {
      final key = sortedKeys[i];
      final items = grouped[key]!;

      /// Divider before each month group (except the first)
      if (i > 0) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 1, color: Theme.of(context).dividerColor),
            ),
          ),
        );
      }

      slivers.add(_MonthHeader(label: key));
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTransactionTile(context, items[index]),
            ),
            childCount: items.length,
          ),
        ),
      );
    }
    return slivers;
  }

  Widget _buildTransactionTile(BuildContext context, AccountTransaction tx) {
    return switch (tx) {
      ExpensePayment(:final expense) => _TransactionTile(
        icon: Icons.shopping_cart_rounded,
        iconColor: Theme.of(context).colorScheme.primary,
        title: expense.title,
        subtitle: 'Expense · ${_formatDate(expense.expenseDate)}',
        amount: -expense.amount,
        amountColor: Colors.red,
      ),
      SettlementPayment(:final settlement) => FutureBuilder<String>(
        future: _userName(settlement.toUserId),
        builder: (context, snap) => _TransactionTile(
          icon: Icons.send_rounded,
          iconColor: Colors.orange,
          title: 'Settled to ${snap.data ?? "..."}',
          subtitle: _formatDate(settlement.createdAt),
          amount: -settlement.amount,
          amountColor: Colors.red,
        ),
      ),
      SettlementDeposit(:final settlement) => FutureBuilder<String>(
        future: _userName(settlement.fromUserId),
        builder: (context, snap) => _TransactionTile(
          icon: Icons.call_received_rounded,
          iconColor: Colors.green,
          title: 'Received from ${snap.data ?? "..."}',
          subtitle: _formatDate(settlement.createdAt),
          amount: settlement.amount,
          amountColor: Colors.green,
        ),
      ),
      ManualDepositEntry(
        :final amount,
        :final description,
        :final date,
        :final previousBalance,
        :final newBalance,
        :final isBalanceEdit,
      ) =>
        _TransactionTile(
          icon: isBalanceEdit ? Icons.edit_rounded : Icons.add_circle_rounded,
          iconColor: isBalanceEdit ? Colors.blue : Colors.green,
          title: description,
          subtitle: isBalanceEdit
              ? '${formatIndianRupee(previousBalance ?? 0)} → ${formatIndianRupee(newBalance ?? 0)} · ${_formatDate(date)}'
              : 'Deposit · ${_formatDate(date)}',
          amount: amount,
          amountColor: amount >= 0 ? Colors.green : Colors.red,
        ),
      IncomeEntry(:final income) => _TransactionTile(
        icon: income.source.icon,
        iconColor: Colors.green,
        title: income.description,
        subtitle: '${income.source.label} · ${_formatDate(income.createdAt)}',
        amount: income.amount,
        amountColor: Colors.green,
      ),
      TransferEntry(:final transfer, :final isOutgoing) => _TransactionTile(
        icon: isOutgoing ? Icons.send_rounded : Icons.call_received_rounded,
        iconColor: isOutgoing ? Colors.orange : Colors.blue,
        title: transfer.description,
        subtitle: isOutgoing ? 'Transfer to savings' : 'Transfer from savings',
        amount: isOutgoing ? -transfer.amount : transfer.amount,
        amountColor: isOutgoing ? Colors.orange : Colors.blue,
      ),
    };
  }

  Future<String> _userName(String userId) async {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname ?? userId.substring(0, 6);
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${d.day}/${d.month}/${d.year}';
  }

  void _showDepositDialog(BuildContext context, AccountEntity account) {
    final amountCtl = TextEditingController();
    final descCtl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Manual Deposit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountCtl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtl,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final amount = double.tryParse(amountCtl.text.trim());
              if (amount == null || amount <= 0) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid amount greater than 0'),
                    ),
                  );
                }
                return;
              }
              if (amount > 999999999) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(content: Text('Amount too large')),
                  );
                }
                return;
              }
              final desc = descCtl.text.trim().isEmpty
                  ? 'Manual Deposit'
                  : descCtl.text.trim();

              final freshAccounts = await sl<AccountRepository>().getAccounts(
                userId: account.userId,
              );
              final freshAccount = freshAccounts
                  .where((a) => a.id == account.id)
                  .firstOrNull;
              if (freshAccount == null) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(content: Text('Account not found')),
                  );
                }
                return;
              }

              final deposit = ManualDepositDto(
                id: const Uuid().v4(),
                accountId: freshAccount.id,
                amount: amount,
                description: desc,
                createdAt: DateTime.now().toUtc(),
                balanceApplied: false,
                userId: freshAccount.userId,
                previousBalance: freshAccount.currentBalance,
                newBalance: freshAccount.currentBalance + amount,
              );
              try {
                await sl<ManualDepositLocalDatasource>().save(deposit);

                /// Update account balance
                final updatedAccount = await sl<AccountRepository>()
                    .recordManualBalanceChange(deposit);
                if (updatedAccount.isSavings) {
                  await sl<SavingsRepository>().computeCurrentMonth(
                    updatedAccount.id,
                    updatedAccount.currentBalance,
                    updatedAccount.monthlySavingsGoal,
                  );
                }
                await sl<ManualDepositLocalDatasource>().save(
                  deposit.copyWith(
                    balanceApplied: true,
                    synced: !updatedAccount.pendingBalanceMutations.containsKey(
                      'manual-entry-${deposit.id}',
                    ),
                  ),
                );
                if (mounted) {
                  setState(() {
                    _account = updatedAccount;
                    _refreshKey++;
                  });
                }
                await _loadTransactions();
                sl<RefreshNotifier>().notifyDataChanged();
              } catch (e, stackTrace) {
                await sl<ManualDepositLocalDatasource>().delete(deposit.id);
                AppLogger.error('Balance update failed', e, stackTrace);
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text('Could not record deposit: $e'),
                    ),
                  );
                }
                return;
              }

              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Deposit recorded')));
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showUpdateBalanceDialog(BuildContext context, AccountEntity account) {
    final controller = TextEditingController(
      text: account.currentBalance.toStringAsFixed(0),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Balance'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'New Balance (₹)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final newBalance = double.tryParse(controller.text.trim());
              if (newBalance == null ||
                  !newBalance.isFinite ||
                  newBalance < 0) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Enter a valid balance')),
                );
                return;
              }
              if (newBalance == account.currentBalance) {
                Navigator.pop(ctx);
                return;
              }
              final now = DateTime.now().toUtc();
              final entry = ManualDepositDto(
                id: const Uuid().v4(),
                accountId: account.id,
                amount: newBalance - account.currentBalance,
                description: 'Manual balance edit',
                createdAt: now,
                balanceApplied: false,
                userId: account.userId,
                previousBalance: account.currentBalance,
                newBalance: newBalance,
                isBalanceEdit: true,
              );
              await sl<ManualDepositLocalDatasource>().save(entry);
              try {
                final updated = await sl<AccountRepository>()
                    .recordManualBalanceChange(entry);
                await sl<ManualDepositLocalDatasource>().save(
                  entry.copyWith(
                    balanceApplied: true,
                    synced: !updated.pendingBalanceMutations.containsKey(
                      'manual-entry-${entry.id}',
                    ),
                  ),
                );
                if (account.isSavings) {
                  await sl<SavingsRepository>().computeCurrentMonth(
                    updated.id,
                    updated.currentBalance,
                    updated.monthlySavingsGoal,
                  );
                }
                if (mounted) {
                  setState(() {
                    _account = updated;
                    _refreshKey++;
                  });
                }
                await _loadTransactions();
                sl<RefreshNotifier>().notifyDataChanged();
              } catch (error, stackTrace) {
                AppLogger.error(
                  'Manual balance edit failed',
                  error,
                  stackTrace,
                );
                await sl<ManualDepositLocalDatasource>().delete(entry.id);
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text('Could not update balance: $error')),
                  );
                }
                return;
              }
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Balance updated')));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showTransferDialog(BuildContext context, AccountEntity fromAccount) {
    final amountCtl = TextEditingController();
    final descCtl = TextEditingController();
    AccountEntity? toAccount;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Transfer Money'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'From',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: fromAccount.isSavings
                          ? Colors.amber.withValues(alpha: 0.15)
                          : null,
                      radius: 16,
                      child: Icon(
                        Icons.account_balance_rounded,
                        size: 18,
                        color: fromAccount.isSavings
                            ? Colors.amber.shade700
                            : null,
                      ),
                    ),
                    title: Text(
                      fromAccount.accountName,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      formatIndianRupee(fromAccount.currentBalance),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('To', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: toAccount?.isSavings == true
                          ? Colors.amber.withValues(alpha: 0.15)
                          : null,
                      radius: 16,
                      child: Icon(
                        toAccount != null
                            ? (toAccount!.isSavings
                                  ? Icons.savings_rounded
                                  : Icons.account_balance_rounded)
                            : Icons.help_outline_rounded,
                        size: 18,
                      ),
                    ),
                    title: Text(
                      toAccount?.accountName ?? 'Select account',
                      style: TextStyle(
                        fontSize: 14,
                        color: toAccount == null
                            ? Theme.of(context).colorScheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                    subtitle: toAccount != null
                        ? Text(
                            formatIndianRupee(toAccount!.currentBalance),
                            style: const TextStyle(fontSize: 12),
                          )
                        : null,
                    trailing: const Icon(Icons.chevron_right_rounded, size: 20),
                    onTap: () async {
                      final accounts = await sl<AccountRepository>()
                          .getAccounts(userId: fromAccount.userId);
                      final others = accounts
                          .where((a) => a.id != fromAccount.id && !a.isArchived)
                          .toList();
                      if (!ctx.mounted) return;
                      final picked = await showModalBottomSheet<AccountEntity>(
                        context: ctx,
                        builder: (_) => AccountPickerSheet(
                          accounts: others,
                          selectedAccountId: toAccount?.id,
                          onSelected: (a) => Navigator.pop(ctx, a),
                          onAddNew: () {
                            Navigator.pop(ctx);
                            context.pushNamed(AppRoute.addAccount.name);
                          },
                        ),
                      );
                      if (picked != null) {
                        setDialogState(() => toAccount = picked);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: amountCtl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount (₹)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descCtl,
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (toAccount == null) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Select a destination account'),
                    ),
                  );
                  return;
                }
                final amount = double.tryParse(amountCtl.text.trim());
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid amount greater than 0'),
                    ),
                  );
                  return;
                }
                if (amount > fromAccount.currentBalance) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance')),
                  );
                  return;
                }

                final id = const Uuid().v4();
                final now = DateTime.now().toUtc();
                final desc = descCtl.text.trim().isEmpty
                    ? 'Transfer'
                    : descCtl.text.trim();

                try {
                  await sl<TransferRepository>().saveTransfer(
                    TransferDto(
                      id: id,
                      fromAccountId: fromAccount.id,
                      toAccountId: toAccount!.id,
                      fromUserId: fromAccount.userId,
                      toUserId: toAccount!.userId,
                      amount: amount,
                      description: desc,
                      createdAt: now,
                      updatedAt: now,
                    ),
                  );
                } catch (e, stackTrace) {
                  AppLogger.error('Transfer failed', e, stackTrace);
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text('Transfer failed: $e')),
                    );
                  }
                  return;
                }

                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (!mounted) return;
                final updatedAccounts = await sl<AccountRepository>()
                    .getAccounts(userId: fromAccount.userId);
                if (!mounted || !context.mounted) return;
                setState(() {
                  _account = updatedAccounts.firstWhere(
                    (a) => a.id == fromAccount.id,
                  );
                });
                _refreshKey++;
                _loadTransactions();
                sl<RefreshNotifier>().notifyDataChanged();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transfer completed')),
                );
              },
              child: const Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRenameDialog(
    BuildContext context,
    AccountEntity account,
  ) async {
    final controller = TextEditingController(text: account.accountName);

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Account'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Account Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) return;
              if (!ctx.mounted) return;
              final saved = await _persistAccountUpdate(
                account.copyWith(
                  accountName: name,
                  updatedAt: DateTime.now().toUtc(),
                ),
              );
              if (!saved) return;
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    AccountEntity account,
  ) async {
    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';

    /// Preserve the audit trail for every balance-changing record.
    final expenseDtos = await sl<ExpenseLocalDatasource>().getExpenses(
      ownerUserId: userId,
    );
    final settlementDtos = await sl<SettlementLocalDatasource>()
        .getSettlements();
    final depositDtos = await sl<ManualDepositLocalDatasource>().getByAccount(
      account.id,
    );
    final incomeEntities = await sl<IncomeRepository>().getIncomesByAccount(
      account.id,
    );
    final transferDtos = await sl<TransferRepository>().getByAccount(
      account.id,
    );
    final hasTransactions =
        expenseDtos.any((e) => e.accountId == account.id) ||
        settlementDtos.any((s) => s.accountId == account.id) ||
        depositDtos.isNotEmpty ||
        incomeEntities.isNotEmpty ||
        transferDtos.isNotEmpty;
    if (hasTransactions) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cannot delete an account linked to transactions. Archive it instead.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account'),
        content: Text(
          'Are you sure you want to delete "${account.accountName}"? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await sl<AccountRepository>().deleteAccount(account.id);
      final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
      if (defaultId == account.id) {
        final accounts = await sl<AccountRepository>().getAccounts(
          userId: userId,
        );
        final replacement = accounts
            .where((item) => !item.isSavings && !item.isArchived)
            .firstOrNull;
        await AppSettings.setDefaultAccountId(
          userId: userId,
          accountId: replacement?.id,
        );
      }
      sl<RefreshNotifier>().notifyDataChanged();
      if (context.mounted) context.pop();
    }
  }

  Future<void> _toggleSavings(
    BuildContext context,
    AccountEntity account,
  ) async {
    if (account.isSavings) {
      await _showSavingsGoalDialog(context, account);
    } else {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      final dtos = await sl<AccountLocalDatasource>().getAccounts();
      final userAccounts = dtos.where((a) => a.userId == userId).toList();

      if (userAccounts.length == 1) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add another account to separate expenses first.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
      if (defaultId == account.id) {
        if (!context.mounted) return;
        final pickNew = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Change Default Account'),
            content: const Text(
              'This account is currently your default. Choose another default account first before marking it as savings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Go to Profile'),
              ),
            ],
          ),
        );
        if (!context.mounted) return;
        if (pickNew == true) {
          // Profile belongs to the stateful shell. Replacing the standalone
          // account-detail route avoids duplicate shell page keys in GoRouter.
          context.goNamed(AppRoute.profile.name);
        }
        return;
      }

      if (!context.mounted) return;
      await _showSavingsGoalDialog(context, account.copyWith(isSavings: true));
    }
  }

  Future<void> _showSavingsGoalDialog(
    BuildContext context,
    AccountEntity account,
  ) async {
    if (!account.isSavings) return;

    final goalCtl = TextEditingController(
      text: account.monthlySavingsGoal > 0
          ? account.monthlySavingsGoal.toStringAsFixed(0)
          : '',
    );

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Savings Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Savings Account'),
              value: account.isSavings,
              onChanged: (v) async {
                if (!v) {
                  final confirmed = await showDialog<bool>(
                    context: ctx,
                    builder: (c) => AlertDialog(
                      title: const Text('Disable Savings?'),
                      content: Text(
                        'Are you sure you want to disable savings for "${account.accountName}"? This will also reset the monthly goal.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(c, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(c, true),
                          child: const Text('Disable'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;
                  final updated = account.copyWith(
                    isSavings: false,
                    monthlySavingsGoal: 0,
                    updatedAt: DateTime.now().toUtc(),
                  );
                  if (!ctx.mounted) return;
                  final saved = await _persistAccountUpdate(updated);
                  if (!saved) return;
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: goalCtl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Goal (₹)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final newGoal = double.tryParse(goalCtl.text.trim()) ?? 0;
              if (!newGoal.isFinite || newGoal < 0) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Enter a valid non-negative savings goal'),
                  ),
                );
                return;
              }
              final oldGoal = account.monthlySavingsGoal;

              if (newGoal < oldGoal && ctx.mounted) {
                final confirmed = await showDialog<bool>(
                  context: ctx,
                  builder: (c) => AlertDialog(
                    title: const Text('Decrease Goal?'),
                    content: Text(
                      'Are you sure you want to lower your monthly goal from ${formatIndianRupee(oldGoal)} to ${formatIndianRupee(newGoal)}?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(c, true),
                        child: const Text('Yes, decrease'),
                      ),
                    ],
                  ),
                );
                if (confirmed != true) return;
              }

              final updated = account.copyWith(
                isSavings: true,
                monthlySavingsGoal: newGoal,
                updatedAt: DateTime.now().toUtc(),
              );
              if (!ctx.mounted) return;
              final saved = await _persistAccountUpdate(
                updated,
                recomputeSavings: true,
              );
              if (!saved) return;
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<bool> _persistAccountUpdate(
    AccountEntity updated, {
    bool recomputeSavings = false,
  }) async {
    try {
      /// Merge onto the freshest stored copy so a stale UI snapshot never
      /// journals a spurious balance mutation.
      final accounts = await sl<AccountRepository>().getAccounts(
        userId: updated.userId,
      );
      final current = accounts
          .where((a) => a.id == updated.id)
          .firstOrNull;
      final merged = current == null
          ? updated
          : updated.copyWith(
              currentBalance: current.currentBalance,
              pendingBalanceMutations: current.pendingBalanceMutations,
              appliedBalanceMutationIds: current.appliedBalanceMutationIds,
            );
      await sl<AccountRepository>().saveAccount(merged);
      if (recomputeSavings && merged.isSavings) {
        await sl<SavingsRepository>().computeCurrentMonth(
          merged.id,
          merged.currentBalance,
          merged.monthlySavingsGoal,
        );
      }
      if (mounted) {
        setState(() {
          _account = merged;
          _refreshKey++;
        });
      }
      sl<RefreshNotifier>().notifyDataChanged();
      return true;
    } catch (error, stackTrace) {
      AppLogger.error('Account update failed', error, stackTrace);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not update account: $error')),
        );
      }
      return false;
    }
  }

  IconData _iconForType(AccountType type) {
    return switch (type) {
      AccountType.bank => Icons.account_balance_rounded,
      AccountType.cash => Icons.money_rounded,
      AccountType.creditCard => Icons.credit_card_rounded,
      AccountType.wallet => Icons.wallet_rounded,
    };
  }
}

class _SummaryLabel extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _SummaryLabel({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formatIndianRupee(amount),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final double amount;
  final Color amountColor;

  const _TransactionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconColor.withValues(alpha: 0.12),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatIndianRupeeSigned(amount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final String label;

  const _MonthHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _SavingsProgressCard extends StatefulWidget {
  final AccountEntity account;
  const _SavingsProgressCard({super.key, required this.account});

  @override
  State<_SavingsProgressCard> createState() => _SavingsProgressCardState();
}

class _SavingsProgressCardState extends State<_SavingsProgressCard> {
  MonthlySavingEntity? _current;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final repo = sl<SavingsRepository>();
      final result = await repo.computeCurrentMonth(
        widget.account.id,
        widget.account.currentBalance,
        widget.account.monthlySavingsGoal,
      );
      if (mounted) {
        setState(() {
          _current = result;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final goal = widget.account.monthlySavingsGoal;
    if (_loading) {
      return const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final saved = _current?.savedAmount ?? 0.0;
    final percent =
        _current?.achievementPercent ??
        (goal > 0 ? (saved / goal * 100).clamp(-999.0, 999.0) : 0.0);

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.savings_rounded,
                  size: 18,
                  color: Colors.amber,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Monthly Savings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Spacer(),
                Text(
                  formatIndianRupee(saved),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: barColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: goal > 0 ? (saved / goal).clamp(0.0, 2.0) : 0,
                minHeight: 10,
                backgroundColor: Theme.of(context).dividerColor,
                color: barColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Goal: ${formatIndianRupee(goal)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  '${percent.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: barColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (saved < 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Using savings reduces your monthly progress',
                  style: TextStyle(fontSize: 11, color: Colors.red.shade400),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
