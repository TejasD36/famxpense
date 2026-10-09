import '../../xcore.dart';

class AccountTile extends StatelessWidget {
  final AccountEntity account;
  final VoidCallback onTap;
  final ValueChanged<bool>? onActivate;

  const AccountTile({
    super.key,
    required this.account,
    required this.onTap,
    this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: ListTile(
        onTap: account.isArchived ? null : onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: account.isSavings
              ? const Icon(Icons.savings_rounded, color: Colors.amber)
              : Icon(
                  _iconForType(account.accountType),
                  color: Theme.of(context).colorScheme.primary,
                ),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                account.accountName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            if (account.isSavings) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Savings',
                  style: TextStyle(fontSize: 10, color: Colors.amber),
                ),
              ),
            ],
            if (account.isArchived) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Deactivated',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          formatIndianRupee(account.currentBalance),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: account.isArchived
            ? Switch(
                value: false,
                onChanged: onActivate,
                activeThumbColor: Theme.of(context).colorScheme.primary,
              )
            : const Icon(Icons.chevron_right_rounded),
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
