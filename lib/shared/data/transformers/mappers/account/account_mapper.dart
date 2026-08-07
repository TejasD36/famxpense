import '../../../../../core.dart';

extension AccountDtoMapper on AccountDto {
  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      userId: userId,
      accountName: accountName,
      accountType: accountType,
      currentBalance: currentBalance,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isArchived: isArchived,
      isSavings: isSavings,
      monthlySavingsGoal: monthlySavingsGoal,
      pendingBalanceMutations: pendingBalanceMutations,
      appliedBalanceMutationIds: appliedBalanceMutationIds,
      hasPendingMetadataChanges: hasPendingMetadataChanges,
      isDeleted: isDeleted,
    );
  }
}

extension AccountEntityMapper on AccountEntity {
  AccountDto toDto() {
    return AccountDto(
      id: id,
      userId: userId,
      accountName: accountName,
      accountType: accountType,
      currentBalance: currentBalance,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isArchived: isArchived,
      isSavings: isSavings,
      monthlySavingsGoal: monthlySavingsGoal,
      pendingBalanceMutations: pendingBalanceMutations,
      appliedBalanceMutationIds: appliedBalanceMutationIds,
      hasPendingMetadataChanges: hasPendingMetadataChanges,
      isDeleted: isDeleted,
    );
  }
}
