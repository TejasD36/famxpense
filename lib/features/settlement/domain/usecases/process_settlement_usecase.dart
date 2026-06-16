import '../../../account/domain/repositories/account_repository.dart';
import '../../../debt_ledger/domain/repositories/debt_ledger_repository.dart';
import '../../xcore.dart';

class ProcessSettlementUsecase {
  final SettlementRepository _settlementRepository;
  final DebtLedgerRepository _debtLedgerRepository;
  final AccountRepository _accountRepository;

  ProcessSettlementUsecase({
    required SettlementRepository settlementRepository,
    required DebtLedgerRepository debtLedgerRepository,
    required AccountRepository accountRepository,
  }) : _settlementRepository = settlementRepository,
       _debtLedgerRepository = debtLedgerRepository,
       _accountRepository = accountRepository;

  Future<void> confirm({required String settlementId, required String? toAccountId}) async {
    final settlement = await _settlementRepository.getSettlementById(settlementId);
    if (settlement == null) return;

    await _settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.confirmed);

    await _debtLedgerRepository.updateDebt(
      settlement.toUserId,
      settlement.fromUserId,
      settlement.amount,
    );

    if (toAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: settlement.toUserId);
        final account = accounts.where((a) => a.id == toAccountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(toAccountId, account.currentBalance + settlement.amount);
        }
      } catch (e, stackTrace) {
        AppLogger.error('Recipient deposit failed', e, stackTrace);
      }
    }

    try {
      await sl<SettlementRemoteDatasource>().updateSettlementStatus(settlementId, SettlementStatus.confirmed);
    } catch (_) {}

    sl<RefreshNotifier>().notifyDataChanged();
  }

  Future<void> reject({required String settlementId}) async {
    final settlement = await _settlementRepository.getSettlementById(settlementId);
    if (settlement == null) return;

    await _settlementRepository.updateSettlementStatus(settlementId, SettlementStatus.rejected);

    if (settlement.accountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: settlement.fromUserId);
        final account = accounts.where((a) => a.id == settlement.accountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(settlement.accountId!, account.currentBalance + settlement.amount);
        }
      } catch (e, stackTrace) {
        AppLogger.error('Payer account refund failed', e, stackTrace);
      }
    }

    try {
      await sl<SettlementRemoteDatasource>().updateSettlementStatus(settlementId, SettlementStatus.rejected);
    } catch (_) {}

    sl<RefreshNotifier>().notifyDataChanged();
  }
}
