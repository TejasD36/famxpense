import '../../xcore.dart';

class AddExpenseUsecase {
  final ExpenseRepository _repository;

  AddExpenseUsecase(this._repository);

  Future<void> call(ExpenseEntity expense) {
    return _repository.addExpense(expense);
  }
}
