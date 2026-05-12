import '../../../../core.dart';

extension DraftExpenseDtoMapper on DraftExpenseDto {
  DraftExpenseEntity toEntity() {
    return DraftExpenseEntity(
      userId: userId,
      title: title,
      note: note,
      amount: amount,
      expenseDate: expenseDate,
      groupId: groupId,
      accountId: accountId,
      updatedAt: updatedAt,
    );
  }
}

extension DraftExpenseEntityMapper on DraftExpenseEntity {
  DraftExpenseDto toDto() {
    return DraftExpenseDto(
      userId: userId,
      title: title,
      note: note,
      amount: amount,
      expenseDate: expenseDate,
      groupId: groupId,
      accountId: accountId,
      updatedAt: updatedAt,
    );
  }
}
