import '../../../account/domain/repositories/account_repository.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
import '../../xcore.dart';

class SettleDebtUsecase {
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
    final hasPending = await _settlementRepository.hasPendingSettlement(fromUserId, toUserId);
    if (hasPending) return 'A pending settlement already exists between you and this partner';

    final now = DateTime.now().toUtc();
    final settlement = SettlementEntity(
      id: const Uuid().v4(),
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      status: SettlementStatus.pending,
      createdAt: now,
      accountId: fromAccountId,
    );

    await _settlementRepository.createSettlement(settlement);

    sl<SyncService>().syncAll(userId: fromUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });

    /// Deduct from payer's selected account (money set aside pending confirmation)
    if (fromAccountId != null) {
      try {
        final accounts = await _accountRepository.getAccounts(userId: fromUserId);
        final account = accounts.where((a) => a.id == fromAccountId).firstOrNull;
        if (account != null) {
          await _accountRepository.updateBalance(fromAccountId, account.currentBalance - amount);
          if (account.isSavings) {
            try {
              await sl<SavingsRepository>().computeCurrentMonth(fromAccountId, account.currentBalance - amount, account.monthlySavingsGoal);
            } catch (e, stackTrace) {
              AppLogger.error('Savings snapshot update failed after settlement deduction', e, stackTrace);
            }
          }
          AppLogger.success('Settlement deducted from account: ${account.accountName}');
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
    final settlement = await _settlementRepository.getSettlementById(settlementId);
    if (settlement == null) return;

    /// Refund payer's account FIRST before deleting the settlement record.
    /// If refund fails, money would be lost if we delete first.
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
              AppLogger.error('Savings snapshot update failed after settlement refund', e, stackTrace);
            }
          }
        }
      } catch (e, stackTrace) {
        AppLogger.error('Cancel settlement refund failed', e, stackTrace);
        rethrow;
      }
    }

    await _settlementRepository.deleteSettlement(settlementId);

    sl<SyncService>().syncAll(userId: settlement.fromUserId).then((_) {
      sl<RefreshNotifier>().notifyDataChanged();
    });
  }
}
