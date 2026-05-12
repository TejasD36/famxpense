import '../../../../core.dart';

extension ExpenseParticipantDtoMapper on ExpenseParticipantDto {
  ExpenseParticipantEntity toEntity() {
    return ExpenseParticipantEntity(userId: userId, amount: amount, isSettled: isSettled, settledAt: settledAt);
  }
}

extension ExpenseParticipantEntityMapper on ExpenseParticipantEntity {
  ExpenseParticipantDto toDto() {
    return ExpenseParticipantDto(userId: userId, amount: amount, isSettled: isSettled, settledAt: settledAt);
  }
}
