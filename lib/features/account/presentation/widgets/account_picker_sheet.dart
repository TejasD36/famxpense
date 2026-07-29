import '../../xcore.dart';

class AccountPickerSheet extends StatelessWidget {
  final List<AccountEntity> accounts;
  final String? selectedAccountId;
  final ValueChanged<AccountEntity> onSelected;
  final VoidCallback onAddNew;

  const AccountPickerSheet({
    super.key,
    required this.accounts,
    this.selectedAccountId,
    required this.onSelected,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Select Account', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                IconButton(
                  onPressed: onAddNew,
                  icon: const Icon(Icons.add_rounded),
                  tooltip: 'Add Account',
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (accounts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text('No accounts yet. Add one!', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ),
              )
            else
              ...accounts.map((account) {
                final isSelected = account.id == selectedAccountId;
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: isSelected ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2) : BorderSide.none,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: account.isSavings ? Colors.amber.withValues(alpha: 0.15) : null,
                      child: Icon(_iconForType(account), color: account.isSavings ? Colors.amber.shade700 : null),
                    ),
                    title: Text(account.accountName),
                    subtitle: Text(formatIndianRupee(account.currentBalance)),
                    trailing: isSelected ? Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary) : null,
                    onTap: () => onSelected(account),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(AccountEntity account) {
    if (account.isSavings) return Icons.savings_rounded;
    return switch (account.accountType) {
      AccountType.bank => Icons.account_balance_rounded,
      AccountType.cash => Icons.money_rounded,
      AccountType.creditCard => Icons.credit_card_rounded,
      AccountType.wallet => Icons.wallet_rounded,
    };
  }
}
