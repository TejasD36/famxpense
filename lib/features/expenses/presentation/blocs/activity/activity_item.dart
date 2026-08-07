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
        date: settlement.createdAt,
        amount: settlement.amount,
      );
}

class IncomeItem extends ActivityItem {
  final IncomeEntity income;
  final String? accountName;

  IncomeItem(this.income, {this.accountName})
    : super(
        id: income.id,
        date: income.createdAt,
        amount: income.amount,
      );
}
