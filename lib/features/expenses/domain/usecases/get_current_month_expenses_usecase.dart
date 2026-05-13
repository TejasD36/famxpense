import '../../xcore.dart';

class GetCurrentMonthExpensesUsecase {
  final ExpenseRepository _repository;

  GetCurrentMonthExpensesUsecase(this._repository);

  Future<List<ExpenseEntity>> call() {
    return _repository.getCurrentMonthExpenses();
  }
}
