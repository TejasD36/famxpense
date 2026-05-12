import '../../../../core.dart';

part 'debt_ledger_dto.freezed.dart';
part 'debt_ledger_dto.g.dart';

@HiveType(typeId: HiveTypeIds.debtLedger)
@freezed
sealed class DebtLedgerDto with _$DebtLedgerDto {
  const factory DebtLedgerDto({
    @HiveField(0) required String id,
    @HiveField(1) required String userA,
    @HiveField(2) required String userB,
    @HiveField(3) required double netBalance,
    @HiveField(4) required DateTime updatedAt,
  }) = _DebtLedgerDto;

  factory DebtLedgerDto.fromJson(Map<String, dynamic> json) => _$DebtLedgerDtoFromJson(json);
}
