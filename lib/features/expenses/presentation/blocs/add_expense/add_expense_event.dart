part of 'add_expense_bloc.dart';

@freezed
sealed class AddExpenseEvent with _$AddExpenseEvent {
  const factory AddExpenseEvent.submit(ExpenseEntity expense) =
      SubmitExpenseEvent;

  const factory AddExpenseEvent.update({
    required ExpenseEntity original,
    required ExpenseEntity edited,
  }) = UpdateExpenseEvent;

  const factory AddExpenseEvent.delete(ExpenseEntity expense) =
      DeleteExpenseEvent;
}
