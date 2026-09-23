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
    @HiveField(5) @Default(true) bool balanceApplied,
    @HiveField(6) @Default('') String userId,
    @HiveField(7) double? previousBalance,
    @HiveField(8) double? newBalance,
    @HiveField(9) @Default(false) bool isBalanceEdit,
    @HiveField(10) @Default(false) bool synced,
  }) = _ManualDepositDto;

  factory ManualDepositDto.fromJson(Map<String, dynamic> json) =>
      _$ManualDepositDtoFromJson(json);
}
