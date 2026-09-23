part of 'activity_bloc.dart';

@freezed
sealed class ActivityEvent with _$ActivityEvent {
  const factory ActivityEvent.loadExpenses({
    DateTime? month,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) = LoadExpensesEvent;
}
