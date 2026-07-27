import '../../../../../core.dart';

part 'income_dto.freezed.dart';
part 'income_dto.g.dart';

@HiveType(typeId: HiveTypeIds.income)
@freezed
sealed class IncomeDto with _$IncomeDto {
  const factory IncomeDto({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String accountId,
    @HiveField(3) required double amount,
    @HiveField(4) required IncomeSource source,
    @HiveField(5) required String description,
    @HiveField(6) required DateTime createdAt,
    @HiveField(7) required DateTime updatedAt,
    @HiveField(8) @Default(SyncStatus.pending) SyncStatus syncStatus,
  }) = _IncomeDto;

  factory IncomeDto.fromJson(Map<String, dynamic> json) => _$IncomeDtoFromJson(json);
}
