import '../../../account/domain/repositories/account_repository.dart';
import '../../xcore.dart';

class SettleDebtUsecase {
  final SettlementRepository _settlementRepository;
  final AccountRepository _accountRepository;

  SettleDebtUsecase({
    required SettlementRepository settlementRepository,
    required AccountRepository accountRepository,
  }) : _settlementRepository = settlementRepository,
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
  }
}
