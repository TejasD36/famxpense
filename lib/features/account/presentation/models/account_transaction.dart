import '../../../../shared/domain/entities/expense/expense_entity.dart';
import '../../../../shared/domain/entities/income/income_entity.dart';
import '../../../../shared/domain/entities/settlement/settlement_entity.dart';
import '../../../../shared/domain/entities/transfer/transfer_entity.dart';

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
  final double? previousBalance;
  final double? newBalance;
  final bool isBalanceEdit;
  @override
  final DateTime date;
  ManualDepositEntry({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    this.previousBalance,
    this.newBalance,
    this.isBalanceEdit = false,
  });
}

class IncomeEntry extends AccountTransaction {
  final IncomeEntity income;
  @override
  DateTime get date => income.createdAt;
  IncomeEntry(this.income);
}

class TransferEntry extends AccountTransaction {
  final TransferEntity transfer;
  final bool isOutgoing;
  @override
  DateTime get date => transfer.createdAt;
  TransferEntry(this.transfer, this.isOutgoing);
}
