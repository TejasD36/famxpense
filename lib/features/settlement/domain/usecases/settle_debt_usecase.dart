import '../../../debt_ledger/domain/repositories/debt_ledger_repository.dart';
import '../../xcore.dart';

class SettleDebtUsecase {
  final SettlementRepository _settlementRepository;
  final DebtLedgerRepository _debtLedgerRepository;

  SettleDebtUsecase({required SettlementRepository settlementRepository, required DebtLedgerRepository debtLedgerRepository})
    : _settlementRepository = settlementRepository,
      _debtLedgerRepository = debtLedgerRepository;

  Future<void> call({
    required String fromUserId,
    required String toUserId,
    required double amount,
  }) async {
    final now = DateTime.now().toUtc();
    final settlement = SettlementEntity(
      id: const Uuid().v4(),
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      status: SettlementStatus.confirmed,
      createdAt: now,
      confirmedAt: now,
    );

    await _settlementRepository.createSettlement(settlement);

    /// Reduce debt by settlement amount (fromUserId pays toUserId)
    await _debtLedgerRepository.updateDebt(toUserId, fromUserId, -amount);
  }
}
