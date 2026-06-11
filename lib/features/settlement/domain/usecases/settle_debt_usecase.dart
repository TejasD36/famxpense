import '../../../account/domain/repositories/account_repository.dart';
import '../../../debt_ledger/domain/repositories/debt_ledger_repository.dart';
import '../../xcore.dart';

class SettleDebtUsecase {
  final SettlementRepository _settlementRepository;
  final DebtLedgerRepository _debtLedgerRepository;
  final AccountRepository _accountRepository;

  SettleDebtUsecase({
    required SettlementRepository settlementRepository,
    required DebtLedgerRepository debtLedgerRepository,
    required AccountRepository accountRepository,
  }) : _settlementRepository = settlementRepository,
       _debtLedgerRepository = debtLedgerRepository,
       _accountRepository = accountRepository;

  Future<void> call({
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? fromAccountId,
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
      accountId: fromAccountId,
    );

    await _settlementRepository.createSettlement(settlement);

    /// Reduce debt by settlement amount (fromUserId pays toUserId)
    await _debtLedgerRepository.updateDebt(toUserId, fromUserId, amount);

    /// Deduct from payer's selected account
    if (fromAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: fromUserId);
        final account = accounts.where((a) => a.id == fromAccountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(fromAccountId, account.currentBalance - amount);
          AppLogger.success('Settlement deducted from account: ${account.accountName}');
        }
      } catch (e, stackTrace) {
        AppLogger.error('Payer account deduction failed', e, stackTrace);
      }
    }

    /// Deposit into recipient's default account (if accessible locally)
    /// Cross-device deposit requires future sync-based handling
  }
}
