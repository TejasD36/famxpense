import 'dart:async';

import '../../xcore.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../expenses/data/datasources/local/expense_local_datasource.dart';
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
    if (mounted) _loadTransactions();
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

    final expenseDtos = await sl<ExpenseLocalDatasource>().getExpenses(ownerUserId: userId);
    final settlementDtos = await sl<SettlementLocalDatasource>().getSettlements();
    final depositDtos = await sl<ManualDepositLocalDatasource>().getByAccount(account.id);

    final defaultAccountId = await AppSettings.getDefaultAccountId(userId: userId);

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
        if (entity.toUserId == userId) {
          transactions.add(SettlementDeposit(entity));
          totalDeposited += entity.amount;
        }
      }
    }

    /// Manual deposits
    for (final dto in depositDtos) {
      transactions.add(ManualDepositEntry(
        id: dto.id,
        amount: dto.amount,
        description: dto.description,
        date: dto.createdAt,
      ));
      totalDeposited += dto.amount;
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
      appBar: AppBar(title: Text(account?.accountName ?? 'Account')),
      body: account == null
          ? const Center(child: Text('Account not found'))
          : RefreshIndicator(
              onRefresh: _loadTransactions,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                children: [
                  /// Smaller Account Info Card
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(
                              _iconForType(account.accountType),
                              size: 22,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(account.accountName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(
                                  account.accountType.name.toUpperCase(),
                                  style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹ ${account.currentBalance.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
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
                          onPressed: () => _showDepositDialog(context, account),
                          icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                          label: const Text('Deposit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.tonalIcon(
                          onPressed: () => _showUpdateBalanceDialog(context, account),
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: const Text('Set Balance'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Summary Bar
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          Container(width: 1, height: 40, color: Theme.of(context).dividerColor),
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

                  /// Transaction History Header
                  Row(
                    children: [
                      Text('Transactions', style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      if (_loading)
                        const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (_loading)
                    const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
                  else if (_transactions.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text('No transactions yet', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      ),
                    )
                  else
                    ..._transactions.map((tx) => _buildTransactionTile(context, tx)),
                ],
              ),
            ),
    );
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
      ManualDepositEntry(:final amount, :final description, :final date) => _TransactionTile(
          icon: Icons.add_circle_rounded,
          iconColor: Colors.green,
          title: description,
          subtitle: 'Deposit · ${_formatDate(date)}',
          amount: amount,
          amountColor: Colors.green,
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
              decoration: InputDecoration(labelText: 'Amount (₹)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtl,
              decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final amount = double.tryParse(amountCtl.text.trim());
              if (amount == null || amount <= 0) return;
              final desc = descCtl.text.trim().isEmpty ? 'Manual Deposit' : descCtl.text.trim();

              await sl<ManualDepositLocalDatasource>().save(ManualDepositDto(
                id: const Uuid().v4(),
                accountId: account.id,
                amount: amount,
                description: desc,
                createdAt: DateTime.now().toUtc(),
              ));

              /// Update account balance
              try {
                await sl<AccountRepository>().updateBalance(account.id, account.currentBalance + amount);
              } catch (e) {
                AppLogger.error('Balance update failed', e);
              }

              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (!mounted) return;
              _loadTransactions();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deposit recorded')));
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showUpdateBalanceDialog(BuildContext context, AccountEntity account) {
    final controller = TextEditingController(text: account.currentBalance.toStringAsFixed(0));

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
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final newBalance = double.tryParse(controller.text.trim());
              if (newBalance != null) {
                context.read<AccountBloc>().add(AccountEvent.updateBalance(accountId: account.id, newBalance: newBalance));
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Balance updated')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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

  const _SummaryLabel({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(
          '₹ ${amount.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
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
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Text(
            '${amount >= 0 ? "+" : ""}₹ ${amount.abs().toStringAsFixed(0)}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: amountColor),
          ),
        ],
      ),
    );
  }
}
