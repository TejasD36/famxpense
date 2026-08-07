import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
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

  Future<void> confirm({
    required String settlementId,
    required String? toAccountId,
  }) async {
    final settlement = await _settlementRepository.getSettlementById(
      settlementId,
    );
    if (settlement == null) return;
    if (!await _isStillPending(settlement)) return;

    await _debtLedgerRepository.updateDebt(
      settlement.toUserId,
      settlement.fromUserId,
      settlement.amount,
      mutationId: 'settlement-confirm-debt-${settlement.id}',
    );

    /// Auto-reject any other pending settlements between the same pair (race condition guard)
    await _autoRejectDuplicates(
      settlement.fromUserId,
      settlement.toUserId,
      settlement.id,
    );

    /// Determine deposit account: use provided accountId, or recipient's default/first account
    final depositAccountId =
        toAccountId ?? await _resolveDepositAccount(settlement.toUserId);
    if (depositAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(
          userId: settlement.toUserId,
        );
        final account = accounts
            .where((a) => a.id == depositAccountId)
            .firstOrNull;
        if (account != null) {
          final updatedAccount = await _accountRepository.adjustBalance(
            depositAccountId,
            settlement.amount,
            mutationId: 'settlement-receipt-${settlement.id}',
          );
          if (updatedAccount.isSavings) {
            try {
              await sl<SavingsRepository>().computeCurrentMonth(
                depositAccountId,
                updatedAccount.currentBalance,
                updatedAccount.monthlySavingsGoal,
              );
            } catch (e, stackTrace) {
              AppLogger.error(
                'Savings snapshot update failed after deposit',
                e,
                stackTrace,
              );
            }
          }
        }
      } catch (e, stackTrace) {
        AppLogger.error('Recipient deposit failed', e, stackTrace);
      }
    }

    await _settlementRepository.updateSettlementStatus(
      settlementId,
      SettlementStatus.confirmed,
    );

    sl<SyncService>().syncAll(userId: settlement.toUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });
  }

  Future<void> _autoRejectDuplicates(
    String userA,
    String userB,
    String excludeId,
  ) async {
    try {
      final all = await sl<SettlementLocalDatasource>().getSettlements();
      final duplicates = all.where(
        (s) =>
            s.id != excludeId &&
            s.status == SettlementStatus.pending &&
            ((s.fromUserId == userA && s.toUserId == userB) ||
                (s.fromUserId == userB && s.toUserId == userA)),
      );

      for (final s in duplicates) {
        /// Refund payer's account only on the payer's device (see reject()).
        final currentUserId = sl<AuthLocalDatasource>().getUserId();
        if (currentUserId != null && s.fromUserId == currentUserId) {
          if (s.accountId != null) {
            try {
              final accounts = await _accountRepository.getAccounts(
                userId: s.fromUserId,
              );
              final account = accounts
                  .where((a) => a.id == s.accountId)
                  .firstOrNull;
              if (account != null) {
                final updatedAccount = await _accountRepository.adjustBalance(
                  s.accountId!,
                  s.amount,
                  mutationId: 'settlement-duplicate-refund-${s.id}',
                );
                if (updatedAccount.isSavings) {
                  try {
                    await sl<SavingsRepository>().computeCurrentMonth(
                      s.accountId!,
                      updatedAccount.currentBalance,
                      updatedAccount.monthlySavingsGoal,
                    );
                  } catch (e, stackTrace) {
                    AppLogger.error(
                      'Savings snapshot update failed after duplicate refund',
                      e,
                      stackTrace,
                    );
                  }
                }
              }
            } catch (e, stackTrace) {
              AppLogger.error(
                'Duplicate settlement refund failed',
                e,
                stackTrace,
              );
            }
          }
        }

        await _settlementRepository.updateSettlementStatus(
          s.id,
          SettlementStatus.rejected,
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Auto-reject duplicates failed', e, stackTrace);
    }
  }

  Future<String?> _resolveDepositAccount(String userId) async {
    final dtos = await sl<AccountLocalDatasource>().getAccounts();
    final accounts = dtos
        .where(
          (account) =>
              account.userId == userId &&
              !account.isSavings &&
              !account.isArchived,
        )
        .toList();
    final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
    final resolved =
        accounts.where((account) => account.id == defaultId).firstOrNull?.id ??
        accounts.firstOrNull?.id;
    if (resolved != defaultId) {
      await AppSettings.setDefaultAccountId(
        userId: userId,
        accountId: resolved,
      );
    }
    return resolved;
  }

  Future<void> reject({required String settlementId}) async {
    final settlement = await _settlementRepository.getSettlementById(
      settlementId,
    );
    if (settlement == null) return;
    if (!await _isStillPending(settlement)) return;

    /// Refund the payer's account ONLY on the payer's device. On the
    /// recipient's device this refund would mutate a foreign account that
    /// Firestore rules reject — the payer's own sync refunds idempotently.
    final currentUserId = sl<AuthLocalDatasource>().getUserId();
    if (currentUserId != null && settlement.fromUserId == currentUserId) {
      if (settlement.accountId != null) {
        try {
          final accounts = await _accountRepository.getAccounts(
            userId: settlement.fromUserId,
          );
          final account = accounts
              .where((a) => a.id == settlement.accountId)
              .firstOrNull;
          if (account != null) {
            final updatedAccount = await _accountRepository.adjustBalance(
              settlement.accountId!,
              settlement.amount,
              mutationId: 'settlement-rejection-refund-${settlement.id}',
            );
            if (updatedAccount.isSavings) {
              try {
                await sl<SavingsRepository>().computeCurrentMonth(
                  settlement.accountId!,
                  updatedAccount.currentBalance,
                  updatedAccount.monthlySavingsGoal,
                );
              } catch (e, stackTrace) {
                AppLogger.error(
                  'Savings snapshot update failed after reject refund',
                  e,
                  stackTrace,
                );
              }
            }
          }
        } catch (e, stackTrace) {
          AppLogger.error('Payer account refund failed', e, stackTrace);
        }
      }
    }

    await _settlementRepository.updateSettlementStatus(
      settlementId,
      SettlementStatus.rejected,
    );

    sl<RefreshNotifier>().notifyDataChanged();
  }

  /// Guards against acting on a settlement another device already resolved:
  /// checks the local status, then verifies against Firestore when reachable.
  Future<bool> _isStillPending(SettlementEntity settlement) async {
    if (settlement.status != SettlementStatus.pending) return false;
    try {
      final remote = await sl<SettlementRemoteDatasource>()
          .fetchSettlementById(settlement.id);
      if (remote != null && remote.status != SettlementStatus.pending) {
        return false;
      }
    } catch (e, stackTrace) {
      AppLogger.warning(
        'Remote settlement verification unavailable — using local status',
      );
      AppLogger.error('Settlement remote status check error', e, stackTrace);
    }
    return true;
  }
}
