import '../../../xcore.dart';

extension ExpenseRemoteMapper on ExpenseEntity {
  ExpenseRemoteDto toRemoteDto() {
    return ExpenseRemoteDto(
      id: id,
      title: title,
      note: note,
      amount: amount,
      paidByUserId: paidByUserId,
      expenseType: expenseType.name,
      splitType: splitType.name,
      ownerUserId: ownerUserId,
      participants: participants.map((e) {
        return {'userId': e.userId, 'amount': e.amount};
      }).toList(),
      participantIds: participants.map((e) => e.userId).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDisabled: isDisabled,
    );
  }
}

/// REMOTE DTO -> ENTITY

extension ExpenseRemoteDtoMapper on ExpenseRemoteDto {
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      title: title,
      note: note,
      amount: amount,
      paidByUserId: paidByUserId,
      ownerUserId: ownerUserId,
      expenseType: ExpenseType.values.byName(expenseType),
      splitType: SplitType.values.byName(splitType),
      participants: participants.map((e) {
        return ExpenseParticipantEntity(userId: e['userId'] as String, amount: (e['amount'] as num).toDouble());
      }).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: SyncStatus.synced,
      isDisabled: isDisabled,
    );
  }
}
