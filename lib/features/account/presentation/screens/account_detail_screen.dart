import '../../xcore.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final account = GoRouterState.of(context).extra as AccountEntity?;

    return Scaffold(
      appBar: AppBar(title: Text(account?.accountName ?? 'Account')),
      body: account == null
          ? const Center(child: Text('Account not found'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                /// Account Info Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            _iconForType(account.accountType),
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(account.accountName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          '₹ ${account.currentBalance.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account.accountType.name.toUpperCase(),
                          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                /// Update Balance
                Text('Update Balance', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () => _showUpdateBalanceDialog(context, account),
                        icon: const Icon(Icons.edit_rounded),
                        label: const Text('Update'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                /// Linked Expenses
                Text('Recent Expenses', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    return const Center(
                      child: Text('Coming soon', style: TextStyle(color: Colors.grey)),
                    );
                  },
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
