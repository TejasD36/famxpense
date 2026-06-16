part of 'statistics_bloc.dart';

@freezed
sealed class StatisticsEvent with _$StatisticsEvent {
  const factory StatisticsEvent.load({DateTime? month}) = LoadStatisticsEvent;
}
