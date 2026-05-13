import '../../xcore.dart';

part 'add_expense_event.freezed.dart';

@freezed
sealed class AddExpenseEvent with _$AddExpenseEvent {
  const factory AddExpenseEvent.submit(ExpenseEntity expense) = SubmitExpenseEvent;
}
