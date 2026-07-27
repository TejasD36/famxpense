import '../../../../../core.dart';

extension IncomeDtoMapper on IncomeDto {
  IncomeEntity toEntity() {
    return IncomeEntity(
      id: id,
      userId: userId,
      accountId: accountId,
      amount: amount,
      source: source,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
    );
  }
}

extension IncomeEntityMapper on IncomeEntity {
  IncomeDto toDto() {
    return IncomeDto(
      id: id,
      userId: userId,
      accountId: accountId,
      amount: amount,
      source: source,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      syncStatus: syncStatus,
    );
  }
}
