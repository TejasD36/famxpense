import '../../../../core.dart';

part 'expense_participant_dto.freezed.dart';
part 'expense_participant_dto.g.dart';

@HiveType(typeId: HiveTypeIds.expenseParticipant)
@freezed
sealed class ExpenseParticipantDto with _$ExpenseParticipantDto {
  const factory ExpenseParticipantDto({
    @HiveField(0) required String userId,
    @HiveField(1) required double amount,
    @HiveField(2) @Default(false) bool isSettled,
    @HiveField(3) DateTime? settledAt,
  }) = _ExpenseParticipantDto;

  factory ExpenseParticipantDto.fromJson(Map<String, dynamic> json) => _$ExpenseParticipantDtoFromJson(json);
}
