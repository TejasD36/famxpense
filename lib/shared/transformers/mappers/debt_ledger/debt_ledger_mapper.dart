import '../../../../core.dart';

extension DebtLedgerDtoMapper on DebtLedgerDto {
  DebtLedgerEntity toEntity() {
    return DebtLedgerEntity(id: id, userA: userA, userB: userB, netBalance: netBalance, updatedAt: updatedAt);
  }
}

extension DebtLedgerEntityMapper on DebtLedgerEntity {
  DebtLedgerDto toDto() {
    return DebtLedgerDto(id: id, userA: userA, userB: userB, netBalance: netBalance, updatedAt: updatedAt);
  }
}
