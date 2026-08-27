import '../../../xcore.dart';

sealed class ActivityItem {
  final String id;
  final DateTime date;
  final double amount;

  ActivityItem({required this.id, required this.date, required this.amount});
}

class ExpenseItem extends ActivityItem {
  final ExpenseEntity expense;
  ExpenseItem(this.expense)
    : super(id: expense.id, date: expense.expenseDate, amount: expense.amount);
}

class SettlementItem extends ActivityItem {
  final SettlementEntity settlement;
  final String? depositAccountName;

  SettlementItem(this.settlement, {this.depositAccountName})
    : super(
        id: settlement.id,
        date: settlement.resolvedAt ?? settlement.createdAt,
        amount: settlement.amount,
      );
}

class IncomeItem extends ActivityItem {
  final IncomeEntity income;
  final String? accountName;

  IncomeItem(this.income, {this.accountName})
    : super(id: income.id, date: income.createdAt, amount: income.amount);
}

class ManualDepositItem extends ActivityItem {
  final ManualDepositDto deposit;
  final String? accountName;

  ManualDepositItem(this.deposit, {this.accountName})
    : super(id: deposit.id, date: deposit.createdAt, amount: deposit.amount);
}

class TransferActivityItem extends ActivityItem {
  final TransferDto transfer;
  final bool isIncoming;
  final String? accountName;
  final String? linkedAccountName;

  TransferActivityItem(
    this.transfer, {
    required this.isIncoming,
    this.accountName,
    this.linkedAccountName,
  }) : super(
         id: '${transfer.id}:${isIncoming ? 'in' : 'out'}',
         date: transfer.createdAt,
         amount: transfer.amount,
       );
}

class BalanceCorrectionItem extends ActivityItem {
  final ManualDepositDto deposit;
  final String? accountName;

  BalanceCorrectionItem(this.deposit, {this.accountName})
    : super(id: deposit.id, date: deposit.createdAt, amount: deposit.amount);
}
