import '../../../../../core.dart';

part 'manual_deposit_dto.freezed.dart';
part 'manual_deposit_dto.g.dart';

@HiveType(typeId: HiveTypeIds.manualDeposit)
@freezed
sealed class ManualDepositDto with _$ManualDepositDto {
  const factory ManualDepositDto({
    @HiveField(0) required String id,
    @HiveField(1) required String accountId,
    @HiveField(2) required double amount,
    @HiveField(3) required String description,
    @HiveField(4) required DateTime createdAt,
  }) = _ManualDepositDto;

  factory ManualDepositDto.fromJson(Map<String, dynamic> json) => _$ManualDepositDtoFromJson(json);
}
