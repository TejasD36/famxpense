import '../../xcore.dart';

class UpdateExpenseUsecase {
  final ExpenseRepository _repository;

  UpdateExpenseUsecase(this._repository);

  Future<void> call({
    required ExpenseEntity original,
    required ExpenseEntity edited,
  }) {
    return _repository.updateExpense(original: original, edited: edited);
  }
}
