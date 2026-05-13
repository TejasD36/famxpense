part of 'add_expense_bloc.dart';

@freezed
sealed class AddExpenseEvent with _$AddExpenseEvent {
  const factory AddExpenseEvent.submit(ExpenseEntity expense) = SubmitExpenseEvent;
}
