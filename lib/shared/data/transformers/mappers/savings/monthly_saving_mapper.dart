import '../../../../../core.dart';

extension MonthlySavingDtoMapper on MonthlySavingDto {
  MonthlySavingEntity toEntity() {
    return MonthlySavingEntity(
      id: id,
      accountId: accountId,
      year: year,
      month: month,
      goalAmount: goalAmount,
      savedAmount: savedAmount,
      openingBalance: openingBalance,
      closingBalance: closingBalance,
      achievementPercent: achievementPercent,
      isCompleted: isCompleted,
      userId: userId,
      syncStatus: syncStatus,
      updatedAt: updatedAt,
    );
  }
}

extension MonthlySavingEntityMapper on MonthlySavingEntity {
  MonthlySavingDto toDto() {
    return MonthlySavingDto(
      id: id,
      accountId: accountId,
      year: year,
      month: month,
      goalAmount: goalAmount,
      savedAmount: savedAmount,
      openingBalance: openingBalance,
      closingBalance: closingBalance,
      achievementPercent: achievementPercent,
      isCompleted: isCompleted,
      userId: userId,
      syncStatus: syncStatus,
      updatedAt: updatedAt,
    );
  }
}
