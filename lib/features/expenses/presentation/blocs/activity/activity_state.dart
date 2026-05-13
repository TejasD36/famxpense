part of 'activity_bloc.dart';

@freezed
sealed class ActivityState with _$ActivityState {
  const factory ActivityState.initial() = ActivityInitial;

  const factory ActivityState.loading() = ActivityLoading;

  const factory ActivityState.loaded(List<ExpenseEntity> expenses) = ActivityLoaded;

  const factory ActivityState.empty() = ActivityEmpty;

  const factory ActivityState.error(String message) = ActivityError;
}
