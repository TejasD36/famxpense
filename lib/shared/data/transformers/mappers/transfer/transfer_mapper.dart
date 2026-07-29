import '../../../../../core.dart';

extension TransferDtoMapper on TransferDto {
  TransferEntity toEntity() {
    return TransferEntity(
      id: id,
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
    );
  }
}

extension TransferEntityMapper on TransferEntity {
  TransferDto toDto() {
    return TransferDto(
      id: id,
      fromAccountId: fromAccountId,
      toAccountId: toAccountId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
    );
  }
}
