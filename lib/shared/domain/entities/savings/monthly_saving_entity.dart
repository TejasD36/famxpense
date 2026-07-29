import '../../../../core.dart';

part 'monthly_saving_entity.freezed.dart';
part 'monthly_saving_entity.g.dart';

@freezed
sealed class MonthlySavingEntity with _$MonthlySavingEntity {
  const factory MonthlySavingEntity({
    required String id,
    required String accountId,
    required int year,
    required int month,
    required double goalAmount,
    required double savedAmount,
    required double openingBalance,
    required double closingBalance,
    required double achievementPercent,
    @Default(false) bool isCompleted,
    @Default('') String userId,
    @Default(SyncStatus.synced) SyncStatus syncStatus,
  }) = _MonthlySavingEntity;

  factory MonthlySavingEntity.fromJson(Map<String, dynamic> json) => _$MonthlySavingEntityFromJson(json);
}
