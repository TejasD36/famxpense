import '../../../../../core.dart';

extension ExpenseDtoMapper on ExpenseDto {
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      title: title,
      note: note,
      amount: amount,
      paidByUserId: paidByUserId,
      ownerUserId: ownerUserId,
      expenseType: expenseType,
      splitType: splitType,
      participants: participants.map((participant) => participant.toEntity()).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
      isDisabled: isDisabled,
      category: category,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

extension ExpenseEntityMapper on ExpenseEntity {
  ExpenseDto toDto() {
    return ExpenseDto(
      id: id,
      title: title,
      note: note,
      amount: amount,
      paidByUserId: paidByUserId,
      ownerUserId: ownerUserId,
      expenseType: expenseType,
      splitType: splitType,
      participants: participants.map((participant) => participant.toDto()).toList(),
      groupId: groupId,
      accountId: accountId,
      expenseDate: expenseDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
      isDisabled: isDisabled,
      category: category,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
