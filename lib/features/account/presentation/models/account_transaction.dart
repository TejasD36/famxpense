import '../../../../shared/domain/entities/expense/expense_entity.dart';
import '../../../../shared/domain/entities/settlement/settlement_entity.dart';

sealed class AccountTransaction {
  DateTime get date;
}

class ExpensePayment extends AccountTransaction {
  final ExpenseEntity expense;
  @override
  DateTime get date => expense.expenseDate;
  ExpensePayment(this.expense);
}

class SettlementPayment extends AccountTransaction {
  final SettlementEntity settlement;
  @override
  DateTime get date => settlement.createdAt;
  SettlementPayment(this.settlement);
}

class SettlementDeposit extends AccountTransaction {
  final SettlementEntity settlement;
  @override
  DateTime get date => settlement.createdAt;
  SettlementDeposit(this.settlement);
}

class ManualDepositEntry extends AccountTransaction {
  final String id;
  final double amount;
  final String description;
  @override
  final DateTime date;
  ManualDepositEntry({required this.id, required this.amount, required this.description, required this.date});
}
