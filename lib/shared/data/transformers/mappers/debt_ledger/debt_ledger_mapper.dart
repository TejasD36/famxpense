import '../../../../../core.dart';

extension DebtLedgerDtoMapper on DebtLedgerDto {
  DebtLedgerEntity toEntity() {
    return DebtLedgerEntity(
      id: id,
      userA: userA,
      userB: userB,
      netBalance: netBalance,
      updatedAt: updatedAt,
      participantIds: [userA, userB],
    );
  }
}

extension DebtLedgerEntityMapper on DebtLedgerEntity {
  DebtLedgerDto toDto() {
    return DebtLedgerDto(id: id, userA: userA, userB: userB, netBalance: netBalance, updatedAt: updatedAt);
  }
}
