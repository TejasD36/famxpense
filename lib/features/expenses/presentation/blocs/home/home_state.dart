part of 'home_bloc.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;

  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.loaded({
    required double totalSpend,
    required double personalSpend,
    required double sharedSpend,
    required int pendingSyncCount,
    required List<ExpenseEntity> recentExpenses,
  }) = HomeLoaded;

  const factory HomeState.empty() = HomeEmpty;

  const factory HomeState.error(String message) = HomeError;
}
