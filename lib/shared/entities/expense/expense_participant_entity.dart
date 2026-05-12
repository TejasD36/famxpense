import '../../../core.dart';

part 'expense_participant_entity.freezed.dart';
part 'expense_participant_entity.g.dart';

@freezed
sealed class ExpenseParticipantEntity with _$ExpenseParticipantEntity {
  const factory ExpenseParticipantEntity({
    required String userId,
    required double amount,
    @Default(false) bool isSettled,
    DateTime? settledAt,
  }) = _ExpenseParticipantEntity;

  factory ExpenseParticipantEntity.fromJson(Map<String, dynamic> json) => _$ExpenseParticipantEntityFromJson(json);
}
