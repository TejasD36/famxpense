import '../../../../../core.dart';

extension SettlementDtoMapper on SettlementDto {
  SettlementEntity toEntity() {
    return SettlementEntity(
      id: id,
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      status: status,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      resolvedAt: resolvedAt,
      resolutionType: resolutionType,
      relatedExpenseIds: relatedExpenseIds,
      accountId: accountId,
      fromAccountId: fromAccountId ?? accountId,
      toAccountId: toAccountId,
    );
  }
}

extension SettlementEntityMapper on SettlementEntity {
  SettlementDto toDto() {
    return SettlementDto(
      id: id,
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      status: status,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      resolvedAt: resolvedAt,
      resolutionType: resolutionType,
      relatedExpenseIds: relatedExpenseIds,
      accountId: accountId,
      fromAccountId: fromAccountId ?? accountId,
      toAccountId: toAccountId,
    );
  }
}
