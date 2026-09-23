import '../../../account/domain/repositories/account_repository.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
import '../../xcore.dart';

class SettleDebtUsecase {
  static const _refundPrefix = 'settlement-refund';
  static const _legacyRefundPrefixes = [
    'settlement-rejection-refund',
    'settlement-cancel-refund',
    'settlement-duplicate-refund',
  ];

  final SettlementRepository _settlementRepository;
  final AccountRepository _accountRepository;

  SettleDebtUsecase({
    required SettlementRepository settlementRepository,
    required AccountRepository accountRepository,
  }) : _settlementRepository = settlementRepository,
       _accountRepository = accountRepository;

  Future<String?> call({
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? fromAccountId,
  }) async {
    /// Prevent duplicate pending settlements
    final hasPending = await _settlementRepository.hasPendingSettlement(
      fromUserId,
      toUserId,
    );
    if (hasPending) {
      return 'A pending settlement already exists between you and this partner';
    }

    final now = DateTime.now().toUtc();
    final settlement = SettlementEntity(
      id: const Uuid().v4(),
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      status: SettlementStatus.pending,
      createdAt: now,
      accountId: fromAccountId,
      fromAccountId: fromAccountId,
    );

    await _settlementRepository.createSettlement(settlement);

    sl<SyncService>().syncAll(userId: fromUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });

    /// Deduct from payer's selected account (money set aside pending confirmation)
    if (fromAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(
          userId: fromUserId,
        );
        final account = accounts
            .where((a) => a.id == fromAccountId)
            .firstOrNull;
        if (account != null) {
          final updatedAccount = await _accountRepository.adjustBalance(
            fromAccountId,
            -amount,
            mutationId: 'settlement-reserve-${settlement.id}',
          );
          if (updatedAccount.isSavings) {
            try {
              await sl<SavingsRepository>().computeCurrentMonth(
                fromAccountId,
                updatedAccount.currentBalance,
                updatedAccount.monthlySavingsGoal,
              );
            } catch (e, stackTrace) {
              AppLogger.error(
                'Savings snapshot update failed after settlement deduction',
                e,
                stackTrace,
              );
            }
          }
          AppLogger.success(
            'Settlement deducted from account: ${account.accountName}',
          );
        }
      } catch (e, stackTrace) {
        AppLogger.error('Payer account deduction failed', e, stackTrace);
      }
    }

    /// Debt NOT updated yet — waits for recipient confirmation

    /// Send notification to recipient
    try {
      final fromNickname = () {
        final fromUser = sl<UserLocalDatasource>().getUser(fromUserId);
        return fromUser?.nickname ?? 'Someone';
      }();
      await sl<NotificationService>().notifySettlement(
        fromUserId: fromUserId,
        toUserId: toUserId,
        fromNickname: fromNickname,
        toNickname: '',
        amount: amount,
        settlementId: settlement.id,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Settlement notification failed', e, stackTrace);
    }
    return null;
  }

  Future<void> cancel(String settlementId) async {
    final settlement = await _settlementRepository.getSettlementById(
      settlementId,
    );
    if (settlement == null) return;
    if (settlement.status != SettlementStatus.pending) return;

    /// Remote terminal-state guard: the recipient may have already confirmed.
    try {
      final remote = await sl<SettlementRemoteDatasource>().fetchSettlementById(
        settlementId,
      );
      if (remote != null && remote.status != SettlementStatus.pending) return;
    } catch (e, stackTrace) {
      AppLogger.warning(
        'Remote settlement verification unavailable — using local status',
      );
      AppLogger.error('Settlement remote status check error', e, stackTrace);
    }

    final resolved = await _settlementRepository.resolveSettlement(
      settlementId: settlementId,
      status: SettlementStatus.cancelled,
      resolvedAt: DateTime.now().toUtc(),
      resolutionType: SettlementStatus.cancelled.name,
      fromAccountId: settlement.fromAccountId ?? settlement.accountId,
      toAccountId: settlement.toAccountId,
    );
    if (resolved == null || resolved.status != SettlementStatus.cancelled) {
      return;
    }

    /// Refund payer's account with the canonical settlement refund mutation.
    if (settlement.accountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(
          userId: settlement.fromUserId,
        );
        final account = accounts
            .where((a) => a.id == settlement.accountId)
            .firstOrNull;
        if (account != null) {
          if (_hasAnyRefundMutation(account, settlement.id)) return;
          final updatedAccount = await _accountRepository.adjustBalance(
            settlement.accountId!,
            settlement.amount,
            mutationId: _refundMutationId(settlement.id),
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
                'Savings snapshot update failed after settlement refund',
                e,
                stackTrace,
              );
            }
          }
        }
      } catch (e, stackTrace) {
        AppLogger.error('Cancel settlement refund failed', e, stackTrace);
        rethrow;
      }
    }

    sl<SyncService>().syncAll(userId: settlement.fromUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });
  }

  String _refundMutationId(String settlementId) {
    return '$_refundPrefix-$settlementId';
  }

  bool _hasAnyRefundMutation(AccountEntity account, String settlementId) {
    final ids = [
      _refundMutationId(settlementId),
      for (final prefix in _legacyRefundPrefixes) '$prefix-$settlementId',
    ];
    return ids.any(
      (id) =>
          account.pendingBalanceMutations.containsKey(id) ||
          account.appliedBalanceMutationIds.contains(id),
    );
  }
}
