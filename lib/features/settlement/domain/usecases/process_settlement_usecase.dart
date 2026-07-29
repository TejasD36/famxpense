import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/domain/repositories/account_repository.dart';
import '../../../debt_ledger/domain/repositories/debt_ledger_repository.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
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

    /// Auto-reject any other pending settlements between the same pair (race condition guard)
    await _autoRejectDuplicates(settlement.fromUserId, settlement.toUserId, settlement.id);

    /// Determine deposit account: use provided accountId, or recipient's default/first account
    final depositAccountId = toAccountId ?? await _resolveDepositAccount(settlement.toUserId);
    if (depositAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: settlement.toUserId);
        final account = accounts.where((a) => a.id == depositAccountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(depositAccountId, account.currentBalance + settlement.amount);
          if (account.isSavings) {
            try {
              await sl<SavingsRepository>().computeCurrentMonth(depositAccountId, account.currentBalance + settlement.amount, account.monthlySavingsGoal);
            } catch (e, stackTrace) {
              AppLogger.error('Savings snapshot update failed after deposit', e, stackTrace);
            }
          }
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

  Future<void> _autoRejectDuplicates(String userA, String userB, String excludeId) async {
    try {
      final all = await sl<SettlementLocalDatasource>().getSettlements();
      final duplicates = all.where((s) =>
          s.id != excludeId &&
          s.status == SettlementStatus.pending &&
          ((s.fromUserId == userA && s.toUserId == userB) ||
           (s.fromUserId == userB && s.toUserId == userA)));

      for (final s in duplicates) {
        await _settlementRepository.updateSettlementStatus(s.id, SettlementStatus.rejected);

        /// Refund payer's account if it was deducted
        if (s.accountId != null) {
          try {
            final accounts = await _accountRepository.getAccounts(userId: s.fromUserId);
            final account = accounts.where((a) => a.id == s.accountId).firstOrNull;
            if (account != null) {
              await _accountRepository.updateBalance(s.accountId!, account.currentBalance + s.amount);
              if (account.isSavings) {
                try {
                  await sl<SavingsRepository>().computeCurrentMonth(s.accountId!, account.currentBalance + s.amount, account.monthlySavingsGoal);
                } catch (e, stackTrace) {
                  AppLogger.error('Savings snapshot update failed after duplicate refund', e, stackTrace);
                }
              }
            }
          } catch (e, stackTrace) {
            AppLogger.error('Duplicate settlement refund failed', e, stackTrace);
          }
        }

        try {
          await sl<SettlementRemoteDatasource>().updateSettlementStatus(s.id, SettlementStatus.rejected);
        } catch (_) {}
      }
    } catch (e, stackTrace) {
      AppLogger.error('Auto-reject duplicates failed', e, stackTrace);
    }
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
          if (account.isSavings) {
            try {
              await sl<SavingsRepository>().computeCurrentMonth(settlement.accountId!, account.currentBalance + settlement.amount, account.monthlySavingsGoal);
            } catch (e, stackTrace) {
              AppLogger.error('Savings snapshot update failed after reject refund', e, stackTrace);
            }
          }
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
