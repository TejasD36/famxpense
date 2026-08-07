import '../../../../../core.dart';

part 'monthly_saving_dto.freezed.dart';
part 'monthly_saving_dto.g.dart';

@HiveType(typeId: HiveTypeIds.monthlySaving)
@freezed
sealed class MonthlySavingDto with _$MonthlySavingDto {
  const factory MonthlySavingDto({
    @HiveField(0) required String id,
    @HiveField(1) required String accountId,
    @HiveField(2) required int year,
    @HiveField(3) required int month,
    @HiveField(4) required double goalAmount,
    @HiveField(5) required double savedAmount,
    @HiveField(6) required double openingBalance,
    @HiveField(7) required double closingBalance,
    @HiveField(8) required double achievementPercent,
    @HiveField(9) @Default(false) bool isCompleted,
    @HiveField(10) @Default('') String userId,
    @HiveField(11) @Default(SyncStatus.synced) SyncStatus syncStatus,
    @HiveField(12) DateTime? updatedAt,
  }) = _MonthlySavingDto;

  factory MonthlySavingDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlySavingDtoFromJson(json);
}
