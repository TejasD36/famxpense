import '../../../account/data/datasources/account_local_datasource.dart';
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

    /// Determine deposit account: use provided accountId, or recipient's default/first account
    final depositAccountId = toAccountId ?? await _resolveDepositAccount(settlement.toUserId);
    if (depositAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: settlement.toUserId);
        final account = accounts.where((a) => a.id == depositAccountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(depositAccountId, account.currentBalance + settlement.amount);
        }
      } catch (e, stackTrace) {
        AppLogger.error('Recipient deposit failed', e, stackTrace);
      }
    }

    try {
      await sl<SettlementRemoteDatasource>().updateSettlementStatus(settlementId, SettlementStatus.confirmed);
    } catch (_) {}

    sl<SyncService>().syncAll(userId: settlement.toUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });
  }

  Future<String?> _resolveDepositAccount(String userId) async {
    final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
    if (defaultId != null) return defaultId;
    final dtos = await sl<AccountLocalDatasource>().getAccounts();
    final first = dtos.where((a) => a.userId == userId).firstOrNull;
    return first?.id;
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
