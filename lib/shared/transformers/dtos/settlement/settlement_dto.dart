import '../../../../core.dart';

part 'settlement_dto.freezed.dart';
part 'settlement_dto.g.dart';

@HiveType(typeId: HiveTypeIds.settlement)
@freezed
sealed class SettlementDto with _$SettlementDto {
  const factory SettlementDto({
    @HiveField(0) required String id,
    @HiveField(1) required String fromUserId,
    @HiveField(2) required String toUserId,
    @HiveField(3) required double amount,
    @HiveField(4) required SettlementStatus status,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? confirmedAt,
    @HiveField(7) List<String>? relatedExpenseIds,
  }) = _SettlementDto;

  factory SettlementDto.fromJson(Map<String, dynamic> json) => _$SettlementDtoFromJson(json);
}
