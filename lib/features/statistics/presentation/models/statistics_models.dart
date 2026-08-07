sealed class TransactionItem {
  final String id;
  final double amount;
  final DateTime date;

  const TransactionItem({
    required this.id,
    required this.amount,
    required this.date,
  });
}

class ExpenseTxn extends TransactionItem {
  final String title;
  final String category;
  final String accountId;
  final String paidByUserId;

  const ExpenseTxn({
    required super.id,
    required super.amount,
    required super.date,
    required this.title,
    required this.category,
    required this.accountId,
    required this.paidByUserId,
  });
}

class DepositTxn extends TransactionItem {
  final String description;
  final String accountId;

  const DepositTxn({
    required super.id,
    required super.amount,
    required super.date,
    required this.description,
    required this.accountId,
  });
}

class IncomeTxn extends TransactionItem {
  final String description;
  final String accountId;

  const IncomeTxn({
    required super.id,
    required super.amount,
    required super.date,
    required this.description,
    required this.accountId,
  });
}

class SettlementTxn extends TransactionItem {
  final String accountId;
  final bool isIncoming;

  const SettlementTxn({
    required super.id,
    required super.amount,
    required super.date,
    required this.accountId,
    required this.isIncoming,
  });
}

class AccountStat {
  final String accountId;
  final String accountName;
  final double startBalance;
  final double endBalance;
  final double totalDeposited;
  final double totalSpent;

  const AccountStat({
    required this.accountId,
    required this.accountName,
    required this.startBalance,
    required this.endBalance,
    required this.totalDeposited,
    required this.totalSpent,
  });

  double get netChange => totalDeposited - totalSpent;
}

class MonthComparison {
  final String label;
  final double totalSpent;
  final double totalDeposited;

  const MonthComparison({
    required this.label,
    required this.totalSpent,
    required this.totalDeposited,
  });
}
