import '../../xcore.dart';

class AccountTile extends StatelessWidget {
  final AccountEntity account;
  final VoidCallback onTap;

  const AccountTile({super.key, required this.account, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(_iconForType(account.accountType), color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(account.accountName, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          '₹ ${account.currentBalance.toStringAsFixed(0)}',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
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
