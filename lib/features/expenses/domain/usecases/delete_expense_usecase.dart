import '../../xcore.dart';

class DeleteExpenseUsecase {
  final ExpenseRepository _repository;

  DeleteExpenseUsecase(this._repository);

  Future<void> call(ExpenseEntity expense) {
    return _repository.deleteExpense(expense);
  }
}
