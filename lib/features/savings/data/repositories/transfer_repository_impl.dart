import '../../../account/domain/repositories/account_repository.dart';
import '../../xcore.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferLocalDatasource _local;
  final TransferRemoteDatasource _remote;
  final AccountRepository _accountRepository;
  final SavingsRepository _savingsRepository;
  final RefreshNotifier _refreshNotifier;

  TransferRepositoryImpl({
    required TransferLocalDatasource local,
    required TransferRemoteDatasource remote,
    required AccountRepository accountRepository,
    required SavingsRepository savingsRepository,
    required RefreshNotifier refreshNotifier,
  }) : _local = local,
       _remote = remote,
       _accountRepository = accountRepository,
       _savingsRepository = savingsRepository,
       _refreshNotifier = refreshNotifier;

  @override
  Future<void> saveTransfer(TransferDto transfer) async {
    if (!transfer.amount.isFinite || transfer.amount <= 0) {
      throw ArgumentError.value(
        transfer.amount,
        'amount',
        'Transfer amount must be finite and greater than zero',
      );
    }
    if (transfer.fromAccountId == transfer.toAccountId) {
      throw ArgumentError('Source and destination accounts must be different');
    }
    if (transfer.fromUserId != transfer.toUserId) {
      throw ArgumentError(
        'Transfers are supported only between accounts owned by the same user',
      );
    }

    final existing = await _local.fetchAll();
    final existingTransfer = existing
        .where((item) => item.id == transfer.id)
        .firstOrNull;
    if (existingTransfer != null) {
      if (existingTransfer.syncStatus == SyncStatus.pending) {
        await _accountRepository.transferBalance(
          userId: existingTransfer.fromUserId,
          fromAccountId: existingTransfer.fromAccountId,
          toAccountId: existingTransfer.toAccountId,
          amount: existingTransfer.amount,
          mutationId: 'transfer-${existingTransfer.id}',
        );
        try {
          final synced = existingTransfer.copyWith(
            syncStatus: SyncStatus.synced,
          );
          await _remote.createTransfer(synced);
          await _local.save(synced);
        } catch (e, stackTrace) {
          AppLogger.error('Transfer retry failed', e, stackTrace);
        }
      }
      return;
    }

    final pending = transfer.copyWith(
      updatedAt: DateTime.now().toUtc(),
      syncStatus: SyncStatus.pending,
    );
    await _local.save(pending);

    ({AccountEntity fromAccount, AccountEntity toAccount}) balances;
    try {
      balances = await _accountRepository.transferBalance(
        userId: transfer.fromUserId,
        fromAccountId: transfer.fromAccountId,
        toAccountId: transfer.toAccountId,
        amount: transfer.amount,
        mutationId: 'transfer-${transfer.id}',
      );
    } catch (_) {
      await _local.deleteTransfer(transfer.id);
      rethrow;
    }

    for (final account in [balances.fromAccount, balances.toAccount]) {
      if (!account.isSavings) continue;
      try {
        await _savingsRepository.computeCurrentMonth(
          account.id,
          account.currentBalance,
          account.monthlySavingsGoal,
        );
      } catch (e, stackTrace) {
        AppLogger.error(
          'Savings snapshot update failed after transfer',
          e,
          stackTrace,
        );
      }
    }

    try {
      final synced = pending.copyWith(syncStatus: SyncStatus.synced);
      await _remote.createTransfer(synced);
      await _local.save(synced);
    } catch (e, stackTrace) {
      AppLogger.warning('Firebase sync failed — saved locally');
      AppLogger.error('Transfer remote save failed', e, stackTrace);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }
  }

  @override
  Future<List<TransferDto>> getAll() async {
    return (await _local.fetchAll())
        .where((transfer) => transfer.fromUserId == transfer.toUserId)
        .toList();
  }

  @override
  Future<List<TransferDto>> getByAccount(String accountId) async {
    return _local.getByAccount(accountId);
  }
}
