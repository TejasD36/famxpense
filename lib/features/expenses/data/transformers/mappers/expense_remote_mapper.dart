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
        return {
          'userId': e.userId,
          'amount': e.amount,
          if (e.isSettled) 'isSettled': true,
          if (e.settledAt != null) 'settledAt': e.settledAt!.toIso8601String(),
        };
      }).toList(),
      participantIds: participants.map((e) => e.userId).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDisabled: isDisabled,
      category: category,
      latitude: latitude,
      longitude: longitude,
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
      ownerUserId: ownerUserId ?? paidByUserId,
      expenseType:
          ExpenseType.values.where((e) => e.name == expenseType).firstOrNull ??
          ExpenseType.personal,
      splitType:
          SplitType.values.where((e) => e.name == splitType).firstOrNull ??
          SplitType.equal,
      participants: participants.map((e) {
        return ExpenseParticipantEntity(
          userId: e['userId'] as String,
          amount: (e['amount'] as num).toDouble(),
          isSettled: (e['isSettled'] as bool?) ?? false,
          settledAt: e['settledAt'] != null
              ? DateTime.tryParse(e['settledAt'] as String)
              : null,
        );
      }).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: SyncStatus.synced,
      isDisabled: isDisabled,
      category: category,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
