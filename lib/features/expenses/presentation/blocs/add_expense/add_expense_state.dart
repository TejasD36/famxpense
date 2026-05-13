part of 'add_expense_bloc.dart';

@freezed
sealed class AddExpenseState with _$AddExpenseState {
  const factory AddExpenseState.initial() = AddExpenseInitial;

  const factory AddExpenseState.loading() = AddExpenseLoading;

  const factory AddExpenseState.success() = AddExpenseSuccess;

  const factory AddExpenseState.error(String message) = AddExpenseError;
}
