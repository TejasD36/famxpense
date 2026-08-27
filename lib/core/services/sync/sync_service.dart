import '../../../features/account/data/datasources/account_local_datasource.dart';
import '../../../features/account/data/datasources/manual_deposit_local_datasource.dart';
import '../../../features/account/data/datasources/remote/account_remote_datasource.dart';
import '../../../features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import '../../../features/expenses/data/transformers/mappers/expense_remote_mapper.dart';
import '../../../features/income/data/datasources/income_local_datasource.dart';
import '../../../features/income/data/datasources/remote/income_remote_datasource.dart';
import '../../../features/notification/data/datasources/notification_local_datasource.dart';
import '../../../features/notification/data/datasources/remote/notification_remote_datasource.dart';
import '../../../features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../../features/savings/data/datasources/savings_local_datasource.dart';
import '../../../features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart';
import '../../../features/savings/data/datasources/transfer_local_datasource.dart';
import '../../../features/savings/data/datasources/remote/transfer_remote_datasource.dart';
import '../../../features/savings/domain/repositories/savings_repository.dart';
import '../../../features/settlement/data/datasources/settlement_local_datasource.dart';
import '../../../features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import '../../../shared/data/datasources/local/user_local_datasource.dart';
import '../../../shared/data/datasources/remote/user_remote_datasource.dart';
import '../../../shared/data/transformers/dtos/account/manual_deposit_dto.dart';
import '../../../shared/data/transformers/dtos/savings/monthly_saving_dto.dart';
import '../../../shared/data/transformers/dtos/transfer/transfer_dto.dart';
import '../../../shared/data/transformers/dtos/debt_ledger/debt_ledger_dto.dart';
import '../../../shared/data/transformers/dtos/user/user_dto.dart';
import '../../../shared/data/transformers/mappers/account/account_mapper.dart';
import '../../../shared/data/transformers/mappers/debt_ledger/debt_ledger_mapper.dart';
import '../../../shared/data/transformers/mappers/expense/expense_mapper.dart';
import '../../../shared/data/transformers/mappers/settlement/settlement_mapper.dart';
import '../../../shared/enums/settlement_status.dart';
import '../../../shared/enums/sync_status.dart';
import '../../../shared/enums/expense_type.dart';
import '../../logger/app_logger.dart';
import '../../local/settings/app_settings.dart';

class SyncService {
  Future<bool>? _activeSync;
  bool _rerunRequested = false;
  String? _activeUserId;

  final ExpenseLocalDatasource _expenseLocal;
  final ExpenseRemoteDatasource _expenseRemote;
  final AccountLocalDatasource _accountLocal;
  final AccountRemoteDatasource _accountRemote;
  final ManualDepositLocalDatasource _manualDepositLocal;
  final DebtLedgerLocalDatasource _debtLedgerLocal;
  final DebtLedgerRemoteDatasource _debtLedgerRemote;
  final SettlementLocalDatasource _settlementLocal;
  final SettlementRemoteDatasource _settlementRemote;
  final UserLocalDatasource _userLocal;
  final UserRemoteDatasource _userRemote;
  final PartnershipRemoteDatasource _partnershipRemote;
  final IncomeLocalDatasource _incomeLocal;
  final IncomeRemoteDatasource _incomeRemote;
  final NotificationLocalDatasource _notificationLocal;
  final NotificationRemoteDatasource _notificationRemote;
  final TransferLocalDatasource _transferLocal;
  final TransferRemoteDatasource _transferRemote;
  final SavingsLocalDatasource _monthlySavingLocal;
  final MonthlySavingRemoteDatasource _monthlySavingRemote;
  final SavingsRepository _savingsRepository;

  SyncService({
    required ExpenseLocalDatasource expenseLocal,
    required ExpenseRemoteDatasource expenseRemote,
    required AccountLocalDatasource accountLocal,
    required AccountRemoteDatasource accountRemote,
    required ManualDepositLocalDatasource manualDepositLocal,
    required DebtLedgerLocalDatasource debtLedgerLocal,
    required DebtLedgerRemoteDatasource debtLedgerRemote,
    required SettlementLocalDatasource settlementLocal,
    required SettlementRemoteDatasource settlementRemote,
    required UserLocalDatasource userLocal,
    required UserRemoteDatasource userRemote,
    required PartnershipRemoteDatasource partnershipRemote,
    required IncomeLocalDatasource incomeLocal,
    required IncomeRemoteDatasource incomeRemote,
    required NotificationLocalDatasource notificationLocal,
    required NotificationRemoteDatasource notificationRemote,
    required TransferLocalDatasource transferLocal,
    required TransferRemoteDatasource transferRemote,
    required SavingsLocalDatasource monthlySavingLocal,
    required MonthlySavingRemoteDatasource monthlySavingRemote,
    required SavingsRepository savingsRepository,
  }) : _expenseLocal = expenseLocal,
       _expenseRemote = expenseRemote,
       _accountLocal = accountLocal,
       _accountRemote = accountRemote,
       _manualDepositLocal = manualDepositLocal,
       _debtLedgerLocal = debtLedgerLocal,
       _debtLedgerRemote = debtLedgerRemote,
       _settlementLocal = settlementLocal,
       _settlementRemote = settlementRemote,
       _userLocal = userLocal,
       _userRemote = userRemote,
       _partnershipRemote = partnershipRemote,
       _incomeLocal = incomeLocal,
       _incomeRemote = incomeRemote,
       _notificationLocal = notificationLocal,
       _notificationRemote = notificationRemote,
       _transferLocal = transferLocal,
       _transferRemote = transferRemote,
       _monthlySavingLocal = monthlySavingLocal,
       _monthlySavingRemote = monthlySavingRemote,
       _savingsRepository = savingsRepository;

  Future<bool> syncAll({required String userId}) {
    final activeSync = _activeSync;
    if (activeSync != null) {
      _rerunRequested = true;
      _activeUserId = userId;
      AppLogger.sync('Sync already in progress, joining and scheduling rerun');
      return activeSync;
    }

    _activeUserId = userId;
    AppSettings.recordSyncAttempt(userId: userId).catchError((_) {});
    _activeSync = _runSyncLoop();
    return _activeSync!;
  }

  Future<bool> _runSyncLoop() async {
    try {
      var finalResult = false;
      do {
        _rerunRequested = false;
        final userId = _activeUserId;
        if (userId == null) {
          AppLogger.warning('Full sync skipped because no user is active');
          return false;
        }
        finalResult = await _runSingleSyncPass(userId);
      } while (_rerunRequested);

      try {
        await AppSettings.recordSyncResult(
          userId: _activeUserId ?? '',
          success: finalResult,
        );
      } catch (_) {
        // Sync health is best-effort and must never change sync semantics.
      }
      return finalResult;
    } catch (e, stackTrace) {
      AppLogger.error('Full sync failed', e, stackTrace);
      final userId = _activeUserId;
      if (userId != null) {
        try {
          await AppSettings.recordSyncResult(userId: userId, success: false);
        } catch (_) {
          // Sync health is best-effort and must never change sync semantics.
        }
      }
      return false;
    } finally {
      _activeSync = null;
      _activeUserId = null;
      _rerunRequested = false;
    }
  }

  Future<bool> _runSingleSyncPass(String userId) async {
    AppLogger.sync('Full sync started');

    try {
      final results = <bool>[
        await syncExpenses(userId: userId),
        await syncDebtLedgers(userId: userId),
        await syncSettlements(userId: userId),
        await syncUsers(userId: userId),
        await syncIncomes(userId: userId),
        await syncTransfers(userId: userId),
        await syncAccounts(userId: userId),
        await syncMonthlySavings(userId: userId),
        await syncNotifications(userId: userId),
      ];

      final succeeded = results.every((result) => result);
      if (succeeded) {
        AppLogger.success('Full sync completed');
      } else {
        AppLogger.warning('Full sync completed with retryable failures');
      }
      return succeeded;
    } catch (e, stackTrace) {
      AppLogger.error('Full sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncExpenses({required String userId}) async {
    AppLogger.sync('Expense sync started');

    try {
      var hadFailures = false;
      final pendingExpenses = await _expenseLocal.getPendingExpenses(
        ownerUserId: userId,
      );

      AppLogger.sync('Pending expenses: ${pendingExpenses.length}');

      for (final expense in pendingExpenses) {
        try {
          final entity = expense.toEntity();
          if (entity.accountId != null) {
            await _ensureAccountBalanceMutation(
              userId: userId,
              accountId: entity.accountId!,
              delta: -entity.amount,
              mutationId: 'expense-balance-${entity.id}',
              updatedAt: entity.updatedAt,
            );
          }
          if (entity.expenseType == ExpenseType.shared) {
            for (final participant in entity.participants) {
              if (participant.userId == entity.paidByUserId) continue;
              await _ensureDebtMutation(
                userA: entity.paidByUserId,
                userB: participant.userId,
                delta: -participant.amount,
                mutationId: 'expense-debt-${entity.id}-${participant.userId}',
                updatedAt: entity.updatedAt,
              );
            }
          }
          await _expenseRemote.createExpense(entity.toRemoteDto());

          final syncedExpense = entity.copyWith(syncStatus: SyncStatus.synced);
          await _expenseLocal.saveExpense(syncedExpense.toDto());
        } catch (e, stackTrace) {
          hadFailures = true;
          AppLogger.warning('Failed syncing expense: ${expense.id}');
          AppLogger.error('Pending sync failed', e, stackTrace);
        }
      }

      AppLogger.firebase('Fetching remote expenses');
      final remoteExpenses = await _expenseRemote.fetchExpenses(userId: userId);
      AppLogger.firebase('Fetched ${remoteExpenses.length} remote expenses');

      final localExpenses = remoteExpenses
          .map((e) => e.toEntity().toDto())
          .toList();
      final pendingLocal = await _expenseLocal.getPendingExpenses(
        ownerUserId: userId,
      );
      final pendingIds = pendingLocal.map((e) => e.id).toSet();

      final merged = [
        ...localExpenses.where((e) => !pendingIds.contains(e.id)),
        ...pendingLocal,
      ];

      await _expenseLocal.saveExpenses(merged);

      AppLogger.success('Expense sync completed');
      return !hadFailures;
    } catch (e, stackTrace) {
      AppLogger.error('Global sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncAccounts({required String userId}) async {
    AppLogger.sync('Account sync started');

    try {
      var succeeded = true;
      final protectedAccountIds = <String>{};
      final localAccounts = (await _accountLocal.getAccountsIncludingDeleted())
          .where((a) => a.userId == userId)
          .toList();
      final remoteAccounts = await _accountRemote.fetchAccounts(userId: userId);
      final remoteById = {
        for (final account in remoteAccounts) account.id: account,
      };

      for (final account in localAccounts) {
        if (account.isDeleted) {
          if (account.pendingBalanceMutations.isNotEmpty) {
            succeeded = false;
            protectedAccountIds.add(account.id);
            AppLogger.warning(
              'Account deletion blocked by pending balance changes: ${account.id}',
            );
            continue;
          }
          if (!remoteById.containsKey(account.id)) {
            await _accountLocal.deleteAccount(account.id);
            continue;
          }
          try {
            await _accountRemote.deleteAccount(account.id);
            await _accountLocal.deleteAccount(account.id);
          } catch (e, stackTrace) {
            succeeded = false;
            protectedAccountIds.add(account.id);
            AppLogger.warning('Failed deleting account: ${account.id}');
            AppLogger.error('Account deletion sync error', e, stackTrace);
          }
          continue;
        }

        final remote = remoteById[account.id];
        if (remote == null) {
          try {
            final pendingDelta = account.pendingBalanceMutations.values
                .fold<double>(0, (total, delta) => total + delta);
            await _accountRemote.createAccount(
              account.toEntity().copyWith(
                currentBalance: account.currentBalance - pendingDelta,
                pendingBalanceMutations: const {},
              ),
            );
            await _acknowledgeAccountChanges(
              accountId: account.id,
              mutationIds: const {},
              metadataUpdatedAt: account.hasPendingMetadataChanges
                  ? account.updatedAt
                  : null,
            );
            for (final mutation in account.pendingBalanceMutations.entries) {
              if (mutation.key.startsWith('manual-entry-')) continue;
              await _accountRemote.adjustBalance(
                accountId: account.id,
                delta: mutation.value,
                mutationId: mutation.key,
                updatedAt: account.updatedAt,
              );
              await _acknowledgeAccountChanges(
                accountId: account.id,
                mutationIds: {mutation.key},
              );
            }
          } catch (e, stackTrace) {
            succeeded = false;
            protectedAccountIds.add(account.id);
            AppLogger.warning('Failed uploading account: ${account.id}');
            AppLogger.error('Account upload error', e, stackTrace);
          }
          continue;
        }

        for (final mutation in account.pendingBalanceMutations.entries) {
          if (mutation.key.startsWith('manual-entry-')) continue;
          try {
            await _accountRemote.adjustBalance(
              accountId: account.id,
              delta: mutation.value,
              mutationId: mutation.key,
              updatedAt: account.updatedAt,
            );
            await _acknowledgeAccountChanges(
              accountId: account.id,
              mutationIds: {mutation.key},
            );
          } catch (e, stackTrace) {
            succeeded = false;
            protectedAccountIds.add(account.id);
            AppLogger.warning(
              'Failed applying account balance change: ${account.id}',
            );
            AppLogger.error('Account balance sync error', e, stackTrace);
          }
        }

        if (account.hasPendingMetadataChanges) {
          try {
            await _accountRemote.updateAccount(account.toEntity());
            await _acknowledgeAccountChanges(
              accountId: account.id,
              mutationIds: const {},
              metadataUpdatedAt: account.updatedAt,
            );
          } catch (e, stackTrace) {
            succeeded = false;
            protectedAccountIds.add(account.id);
            AppLogger.warning('Failed updating account details: ${account.id}');
            AppLogger.error('Account metadata sync error', e, stackTrace);
          }
        }
      }

      if (!await _syncManualDeposits(userId)) succeeded = false;

      final refreshedRemote = await _accountRemote.fetchAccounts(
        userId: userId,
      );
      final currentLocal = await _accountLocal.getAccountsIncludingDeleted();
      final currentById = {
        for (final account in currentLocal.where((a) => a.userId == userId))
          account.id: account,
      };

      for (final remote in refreshedRemote) {
        if (protectedAccountIds.contains(remote.id)) continue;
        final local = currentById[remote.id];
        if (local == null) {
          await _accountLocal.saveAccount(remote.toDto());
          continue;
        }

        final pendingDelta = local.pendingBalanceMutations.values.fold<double>(
          0,
          (total, delta) => total + delta,
        );
        final mergedRemote = remote.toDto().copyWith(
          accountName: local.hasPendingMetadataChanges
              ? local.accountName
              : remote.accountName,
          accountType: local.hasPendingMetadataChanges
              ? local.accountType
              : remote.accountType,
          isArchived: local.hasPendingMetadataChanges
              ? local.isArchived
              : remote.isArchived,
          isSavings: local.hasPendingMetadataChanges
              ? local.isSavings
              : remote.isSavings,
          monthlySavingsGoal: local.hasPendingMetadataChanges
              ? local.monthlySavingsGoal
              : remote.monthlySavingsGoal,
          currentBalance: remote.currentBalance + pendingDelta,
          pendingBalanceMutations: local.pendingBalanceMutations,
          appliedBalanceMutationIds: local.appliedBalanceMutationIds,
          hasPendingMetadataChanges: local.hasPendingMetadataChanges,
        );
        await _accountLocal.saveAccount(mergedRemote);
      }

      if (succeeded) {
        final now = DateTime.now();
        final mergedAccounts = (await _accountLocal.getAccounts())
            .where(
              (account) =>
                  account.userId == userId &&
                  !account.isDeleted &&
                  account.isSavings &&
                  !account.isArchived,
            )
            .toList();
        for (final account in mergedAccounts) {
          final snapshot = await _monthlySavingLocal.getSnapshot(
            account.id,
            now.year,
            now.month,
          );
          if (snapshot == null ||
              snapshot.closingBalance != account.currentBalance ||
              snapshot.goalAmount != account.monthlySavingsGoal) {
            final updated = await _savingsRepository.computeCurrentMonth(
              account.id,
              account.currentBalance,
              account.monthlySavingsGoal,
            );
            if (updated.syncStatus != SyncStatus.synced) succeeded = false;
          }
        }
      }

      AppLogger.success(
        'Account sync completed (${refreshedRemote.length} remote)',
      );
      return succeeded;
    } catch (e, stackTrace) {
      AppLogger.error('Account sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> _syncManualDeposits(String userId) async {
    var succeeded = true;
    final accounts = (await _accountLocal.getAccounts())
        .where((account) => account.userId == userId && !account.isDeleted)
        .toList();
    final accountIds = accounts.map((account) => account.id).toSet();
    final deposits = await _manualDepositLocal.fetchAll();
    for (final deposit in deposits) {
      if (deposit.userId != userId ||
          deposit.synced ||
          !accountIds.contains(deposit.accountId)) {
        continue;
      }
      await _ensureAccountBalanceMutation(
        userId: userId,
        accountId: deposit.accountId,
        delta: deposit.amount,
        mutationId: 'manual-entry-${deposit.id}',
        updatedAt: deposit.createdAt,
        accountEntry: deposit,
      );
      final refreshed = (await _accountLocal.getAccounts())
          .where((account) => account.id == deposit.accountId)
          .firstOrNull;
      final synced =
          refreshed != null &&
          !refreshed.pendingBalanceMutations.containsKey(
            'manual-entry-${deposit.id}',
          );
      if (!synced) succeeded = false;
      await _manualDepositLocal.save(
        deposit.copyWith(balanceApplied: true, synced: synced),
      );
    }

    final remoteEntries = await _accountRemote.fetchAccountEntries(
      userId: userId,
    );
    for (final entry in remoteEntries) {
      await _manualDepositLocal.save(
        entry.copyWith(balanceApplied: true, synced: true),
      );
    }
    return succeeded;
  }

  Future<void> _acknowledgeAccountChanges({
    required String accountId,
    required Set<String> mutationIds,
    DateTime? metadataUpdatedAt,
  }) async {
    final accounts = await _accountLocal.getAccounts();
    final current = accounts.where((item) => item.id == accountId).firstOrNull;
    if (current == null) return;

    final pendingMutations = Map<String, double>.of(
      current.pendingBalanceMutations,
    );
    for (final mutationId in mutationIds) {
      pendingMutations.remove(mutationId);
    }
    final appliedMutationIds = {
      ...current.appliedBalanceMutationIds,
      ...mutationIds,
    }.toList();
    final canAcknowledgeMetadata =
        metadataUpdatedAt != null &&
        !current.updatedAt.isAfter(metadataUpdatedAt);
    await _accountLocal.saveAccount(
      current.copyWith(
        pendingBalanceMutations: pendingMutations,
        appliedBalanceMutationIds: appliedMutationIds,
        hasPendingMetadataChanges: canAcknowledgeMetadata
            ? false
            : current.hasPendingMetadataChanges,
      ),
    );
  }

  Future<void> _ensureAccountBalanceMutation({
    required String userId,
    required String accountId,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
    ManualDepositDto? accountEntry,
  }) async {
    final accounts = await _accountLocal.getAccounts();
    final account = accounts
        .where((item) => item.id == accountId && item.userId == userId)
        .firstOrNull;
    if (account == null) {
      throw StateError('Account $accountId is unavailable for $userId');
    }
    if (account.appliedBalanceMutationIds.contains(mutationId)) return;

    final existingDelta = account.pendingBalanceMutations[mutationId];
    if (existingDelta != null && existingDelta != delta) {
      throw StateError('Balance mutation $mutationId has a different amount');
    }
    if (existingDelta == null) {
      await _accountLocal.saveAccount(
        account.copyWith(
          currentBalance: account.currentBalance + delta,
          pendingBalanceMutations: Map<String, double>.of(
            account.pendingBalanceMutations,
          )..[mutationId] = delta,
          updatedAt: updatedAt,
        ),
      );
    }

    try {
      if (accountEntry == null) {
        await _accountRemote.adjustBalance(
          accountId: accountId,
          delta: delta,
          mutationId: mutationId,
          updatedAt: updatedAt,
        );
      } else {
        await _accountRemote.adjustBalance(
          accountId: accountId,
          delta: delta,
          mutationId: mutationId,
          updatedAt: updatedAt,
          accountEntry: accountEntry,
        );
      }
      await _acknowledgeAccountChanges(
        accountId: accountId,
        mutationIds: {mutationId},
      );
    } catch (e, stackTrace) {
      AppLogger.warning('Balance mutation $mutationId queued for retry');
      AppLogger.error('Balance mutation sync error', e, stackTrace);
    }
  }

  Future<void> _ensureTransferBalanceMutations(TransferDto transfer) async {
    if (transfer.fromUserId != transfer.toUserId) {
      throw StateError('Transfer accounts must have the same owner');
    }
    final accounts = await _accountLocal.getAccounts();
    final from = accounts
        .where(
          (account) =>
              account.id == transfer.fromAccountId &&
              account.userId == transfer.fromUserId,
        )
        .firstOrNull;
    final to = accounts
        .where(
          (account) =>
              account.id == transfer.toAccountId &&
              account.userId == transfer.fromUserId,
        )
        .firstOrNull;
    if (from == null || to == null) {
      throw StateError('Both transfer accounts must be available');
    }

    final mutationBase = 'transfer-${transfer.id}';
    final fromMutationId = '$mutationBase:debit';
    final toMutationId = '$mutationBase:credit';
    final fromApplied = from.appliedBalanceMutationIds.contains(fromMutationId);
    final toApplied = to.appliedBalanceMutationIds.contains(toMutationId);
    if (fromApplied && toApplied) return;

    final fromPending = from.pendingBalanceMutations[fromMutationId];
    final toPending = to.pendingBalanceMutations[toMutationId];
    final fromKnown = fromApplied || fromPending != null;
    final toKnown = toApplied || toPending != null;
    if (fromKnown != toKnown) {
      throw StateError('Transfer balance journal is incomplete');
    }
    if (fromPending != null && fromPending != -transfer.amount ||
        toPending != null && toPending != transfer.amount) {
      throw StateError('Transfer balance journal has a different amount');
    }

    if (!fromKnown) {
      if (from.currentBalance < transfer.amount) {
        throw StateError('Insufficient balance for pending transfer');
      }
      await _accountLocal.saveAccounts([
        from.copyWith(
          currentBalance: from.currentBalance - transfer.amount,
          pendingBalanceMutations: Map<String, double>.of(
            from.pendingBalanceMutations,
          )..[fromMutationId] = -transfer.amount,
          updatedAt: transfer.updatedAt,
        ),
        to.copyWith(
          currentBalance: to.currentBalance + transfer.amount,
          pendingBalanceMutations: Map<String, double>.of(
            to.pendingBalanceMutations,
          )..[toMutationId] = transfer.amount,
          updatedAt: transfer.updatedAt,
        ),
      ]);
    }

    try {
      await _accountRemote.transferBalance(
        fromAccountId: transfer.fromAccountId,
        toAccountId: transfer.toAccountId,
        amount: transfer.amount,
        fromMutationId: fromMutationId,
        toMutationId: toMutationId,
        updatedAt: transfer.updatedAt,
      );
      await _acknowledgeAccountChanges(
        accountId: transfer.fromAccountId,
        mutationIds: {fromMutationId},
      );
      await _acknowledgeAccountChanges(
        accountId: transfer.toAccountId,
        mutationIds: {toMutationId},
      );
    } catch (e, stackTrace) {
      AppLogger.warning('Transfer balance mutations queued for retry');
      AppLogger.error('Transfer balance mutation sync error', e, stackTrace);
    }
  }

  Future<void> _ensureDebtMutation({
    required String userA,
    required String userB,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
  }) async {
    final sorted = [userA, userB]..sort();
    final canonicalA = sorted[0];
    final canonicalB = sorted[1];
    final canonicalDelta = canonicalA == userB ? -delta : delta;
    final ledgerId = '${canonicalA}_$canonicalB';
    final ledgers = await _debtLedgerLocal.getLedgers();
    final current = ledgers
        .where(
          (ledger) =>
              ledger.id == ledgerId ||
              (ledger.userA == canonicalA && ledger.userB == canonicalB),
        )
        .firstOrNull;
    if (current?.appliedMutationIds.contains(mutationId) ?? false) return;

    final existingDelta = current?.pendingMutations[mutationId];
    if (existingDelta != null && existingDelta != canonicalDelta) {
      throw StateError('Debt mutation $mutationId has a different amount');
    }
    if (existingDelta == null) {
      final pending = Map<String, double>.of(
        current?.pendingMutations ?? const {},
      )..[mutationId] = canonicalDelta;
      await _debtLedgerLocal.saveLedger(
        current == null
            ? DebtLedgerDto(
                id: ledgerId,
                userA: canonicalA,
                userB: canonicalB,
                netBalance: canonicalDelta,
                updatedAt: updatedAt,
                pendingMutations: pending,
              )
            : current.copyWith(
                netBalance: current.netBalance + canonicalDelta,
                updatedAt: updatedAt,
                pendingMutations: pending,
              ),
      );
    }

    try {
      await _debtLedgerRemote.adjustDebt(
        userA: canonicalA,
        userB: canonicalB,
        delta: canonicalDelta,
        mutationId: mutationId,
        updatedAt: updatedAt,
      );
      await _markDebtMutationsApplied(ledgerId, {mutationId});
    } catch (e, stackTrace) {
      AppLogger.warning('Debt mutation $mutationId queued for retry');
      AppLogger.error('Debt mutation sync error', e, stackTrace);
    }
  }

  Future<bool> syncDebtLedgers({required String userId}) async {
    AppLogger.sync('Debt ledger sync started');

    try {
      var succeeded = true;
      final protectedLedgerIds = <String>{};
      final localByUser = (await _debtLedgerLocal.getLedgers())
          .where((l) => l.userA == userId || l.userB == userId)
          .toList();
      final remoteLedgers = await _debtLedgerRemote.fetchLedgers(
        userId: userId,
      );
      final remoteById = {for (final r in remoteLedgers) r.id: r};

      for (final ledger in localByUser) {
        final remote = remoteById[ledger.id];
        if (remote == null) {
          try {
            await _debtLedgerRemote.saveLedger(ledger.toEntity());
            await _markDebtMutationsApplied(
              ledger.id,
              ledger.pendingMutations.keys.toSet(),
            );
          } catch (e, stackTrace) {
            succeeded = false;
            protectedLedgerIds.add(ledger.id);
            AppLogger.warning('Failed uploading ledger: ${ledger.id}');
            AppLogger.error('Ledger upload error', e, stackTrace);
          }
          continue;
        }

        for (final mutation in ledger.pendingMutations.entries) {
          try {
            await _debtLedgerRemote.adjustDebt(
              userA: ledger.userA,
              userB: ledger.userB,
              delta: mutation.value,
              mutationId: mutation.key,
              updatedAt: ledger.updatedAt,
            );
            await _markDebtMutationsApplied(ledger.id, {mutation.key});
          } catch (e, stackTrace) {
            succeeded = false;
            protectedLedgerIds.add(ledger.id);
            AppLogger.warning(
              'Failed applying debt ledger mutation: ${ledger.id}',
            );
            AppLogger.error('Debt ledger mutation sync error', e, stackTrace);
          }
        }
      }

      final refreshedRemote = await _debtLedgerRemote.fetchLedgers(
        userId: userId,
      );
      final currentLocal = await _debtLedgerLocal.getLedgers();
      final currentById = {
        for (final ledger in currentLocal) ledger.id: ledger,
      };
      for (final remote in refreshedRemote) {
        if (protectedLedgerIds.contains(remote.id)) continue;
        final local = currentById[remote.id];
        if (local == null) {
          await _debtLedgerLocal.saveLedger(remote.toDto());
          continue;
        }

        final pendingDelta = local.pendingMutations.values.fold<double>(
          0,
          (total, delta) => total + delta,
        );
        await _debtLedgerLocal.saveLedger(
          remote.toDto().copyWith(
            netBalance: remote.netBalance + pendingDelta,
            pendingMutations: local.pendingMutations,
            appliedMutationIds: local.appliedMutationIds,
          ),
        );
      }

      AppLogger.success(
        'Debt ledger sync completed (${refreshedRemote.length} remote)',
      );
      return succeeded;
    } catch (e, stackTrace) {
      AppLogger.error('Debt ledger sync failed', e, stackTrace);
      return false;
    }
  }

  Future<void> _markDebtMutationsApplied(
    String ledgerId,
    Set<String> mutationIds,
  ) async {
    final ledgers = await _debtLedgerLocal.getLedgers();
    final current = ledgers
        .where((ledger) => ledger.id == ledgerId)
        .firstOrNull;
    if (current == null) return;

    final pending = Map<String, double>.of(current.pendingMutations);
    for (final mutationId in mutationIds) {
      pending.remove(mutationId);
    }
    await _debtLedgerLocal.saveLedger(
      current.copyWith(
        pendingMutations: pending,
        appliedMutationIds: {
          ...current.appliedMutationIds,
          ...mutationIds,
        }.toList(),
      ),
    );
  }

  Future<bool> syncSettlements({required String userId}) async {
    AppLogger.sync('Settlement sync started');

    try {
      var succeeded = true;
      final localSettlements = await _settlementLocal.getSettlements();
      final localByUser = localSettlements
          .where((s) => s.fromUserId == userId || s.toUserId == userId)
          .toList();
      final localById = {for (final s in localByUser) s.id: s};

      /// Fetch remote settlements FIRST to avoid overwriting status changes
      final remoteSettlements = await _settlementRemote.fetchSettlements(
        userId: userId,
      );
      final remoteById = {for (final r in remoteSettlements) r.id: r};

      /// Merge: save remote-only settlements and handle status transitions
      for (final remote in remoteSettlements) {
        final local = localById[remote.id];
        if (local == null) {
          await _settlementLocal.saveSettlement(remote.toDto());
        }

        final localStatus = local?.status ?? remote.status;
        if (_isTerminalSettlement(remote.status)) {
          if (remote.status != localStatus) {
            AppLogger.warning(
              'Settlement ${remote.id}: adopting terminal remote status '
              '${remote.status.name}',
            );
          }

          if ((remote.status == SettlementStatus.rejected ||
                  remote.status == SettlementStatus.cancelled) &&
              localStatus == SettlementStatus.pending &&
              remote.fromUserId == userId &&
              remote.accountId != null) {
            try {
              if (!await _hasAnySettlementRefundMutation(
                userId: userId,
                accountId: remote.accountId!,
                settlementId: remote.id,
              )) {
                await _ensureAccountBalanceMutation(
                  userId: userId,
                  accountId: remote.accountId!,
                  delta: remote.amount,
                  mutationId: _settlementRefundMutationId(remote.id),
                  updatedAt: remote.resolvedAt ?? DateTime.now().toUtc(),
                );
              }
            } catch (e, stackTrace) {
              succeeded = false;
              AppLogger.error(
                'Rejected settlement refund failed',
                e,
                stackTrace,
              );
            }
          }
          await _settlementLocal.saveResolvedSettlement(remote);
        } else if (remote.status == SettlementStatus.pending &&
            local != null &&
            local.status != SettlementStatus.pending) {
          try {
            final resolvedAt = local.resolvedAt ?? DateTime.now().toUtc();
            final resolved = await _settlementRemote.resolveSettlement(
              settlementId: remote.id,
              status: local.status,
              resolvedAt: resolvedAt,
              resolutionType: local.resolutionType ?? local.status.name,
              fromAccountId: local.fromAccountId ?? local.accountId,
              toAccountId: local.toAccountId,
            );
            await _settlementLocal.saveResolvedSettlement(resolved);
          } catch (e, stackTrace) {
            succeeded = false;
            AppLogger.warning('Failed syncing settlement status: ${remote.id}');
            AppLogger.error('Settlement status sync error', e, stackTrace);
          }
        } else if (remote.status == SettlementStatus.pending &&
            remote.fromUserId == userId &&
            remote.accountId != null) {
          try {
            await _ensureAccountBalanceMutation(
              userId: userId,
              accountId: remote.accountId!,
              delta: -remote.amount,
              mutationId: 'settlement-reserve-${remote.id}',
              updatedAt: remote.createdAt,
            );
          } catch (e, stackTrace) {
            succeeded = false;
            AppLogger.warning('Settlement reserve skipped for ${remote.id}');
            AppLogger.error('Settlement reserve error', e, stackTrace);
          }
        }
      }

      /// Upload only settlements that don't exist remotely (local-only)
      for (final settlement in localByUser) {
        if (!remoteById.containsKey(settlement.id)) {
          try {
            if (settlement.status == SettlementStatus.pending &&
                settlement.fromUserId == userId &&
                settlement.accountId != null) {
              await _ensureAccountBalanceMutation(
                userId: userId,
                accountId: settlement.accountId!,
                delta: -settlement.amount,
                mutationId: 'settlement-reserve-${settlement.id}',
                updatedAt: settlement.createdAt,
              );
            }
            await _settlementRemote.createSettlement(settlement.toEntity());
          } catch (e, stackTrace) {
            succeeded = false;
            AppLogger.warning('Failed uploading settlement: ${settlement.id}');
            AppLogger.error('Settlement upload error', e, stackTrace);
          }
        }
      }

      AppLogger.success(
        'Settlement sync completed (${remoteSettlements.length} remote)',
      );
      return succeeded;
    } catch (e, stackTrace) {
      AppLogger.error('Settlement sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncUsers({required String userId}) async {
    AppLogger.sync('User sync started');

    try {
      final partnerships = await _partnershipRemote.getPartnerships(
        userId: userId,
      );
      final partnerIds = partnerships
          .map((p) => p.senderId == userId ? p.receiverId : p.senderId)
          .toSet();

      for (final partnerId in partnerIds) {
        final cached = _userLocal.getUser(partnerId);
        if (cached != null) continue;

        final remote = await _userRemote.getUser(partnerId);
        if (remote != null) {
          await _userLocal.saveUser(
            UserDto(
              id: remote.id,
              name: remote.name,
              nickname: remote.nickname,
              email: remote.email,
              profileImageUrl: remote.profileImageUrl,
              createdAt: remote.createdAt,
              updatedAt: remote.updatedAt,
              isActive: remote.isActive,
            ),
          );
        }
      }

      AppLogger.success('User sync completed (${partnerIds.length} partners)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('User sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncIncomes({required String userId}) async {
    AppLogger.sync('Income sync started');

    try {
      var hadFailures = false;
      final localIncomes = (await _incomeLocal.fetchAll())
          .where((income) => income.userId == userId)
          .toList();

      for (final income in localIncomes) {
        if (income.syncStatus != SyncStatus.pending) continue;
        try {
          if (income.isDeleted) {
            await _ensureAccountBalanceMutation(
              userId: userId,
              accountId: income.accountId,
              delta: -income.amount,
              mutationId: 'income-reversal-${income.id}',
              updatedAt: income.updatedAt,
            );
            await _incomeRemote.deleteIncome(income.id);
            await _incomeLocal.deleteIncome(income.id);
          } else {
            await _ensureAccountBalanceMutation(
              userId: userId,
              accountId: income.accountId,
              delta: income.amount,
              mutationId: 'income-credit-${income.id}',
              updatedAt: income.updatedAt,
            );
            final synced = income.copyWith(syncStatus: SyncStatus.synced);
            await _incomeRemote.createIncome(synced);
            await _incomeLocal.save(synced);
          }
        } catch (e, stackTrace) {
          hadFailures = true;
          AppLogger.warning('Failed uploading income: ${income.id}');
          AppLogger.error('Income upload error', e, stackTrace);
        }
      }

      final remoteIncomes = await _incomeRemote.fetchIncomes(userId: userId);
      final localAfterUpload = (await _incomeLocal.fetchAll())
          .where((income) => income.userId == userId)
          .toList();
      final localById = {
        for (final income in localAfterUpload) income.id: income,
      };

      for (final remote in remoteIncomes) {
        if (remote.userId != userId || remote.isDeleted) continue;
        final local = localById[remote.id];
        if (local == null ||
            (local.syncStatus == SyncStatus.synced &&
                remote.updatedAt.isAfter(local.updatedAt))) {
          await _incomeLocal.save(
            remote.copyWith(syncStatus: SyncStatus.synced, isDeleted: false),
          );
        }
      }

      AppLogger.success(
        'Income sync completed (${remoteIncomes.length} remote)',
      );
      return !hadFailures;
    } catch (e, stackTrace) {
      AppLogger.error('Income sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncTransfers({required String userId}) async {
    AppLogger.sync('Transfer sync started');

    try {
      var hadFailures = false;
      final localTransfers = (await _transferLocal.fetchAll())
          .where((transfer) => transfer.fromUserId == userId)
          .toList();

      for (final transfer in localTransfers) {
        if (transfer.syncStatus != SyncStatus.pending) continue;
        try {
          await _ensureTransferBalanceMutations(transfer);
          final synced = transfer.copyWith(syncStatus: SyncStatus.synced);
          await _transferRemote.createTransfer(synced);
          await _transferLocal.save(synced);
        } catch (e, stackTrace) {
          hadFailures = true;
          AppLogger.warning('Failed uploading transfer: ${transfer.id}');
          AppLogger.error('Transfer upload error', e, stackTrace);
        }
      }

      final remoteTransfers = await _transferRemote.fetchTransfers(
        userId: userId,
      );
      final localAfterUpload = (await _transferLocal.fetchAll())
          .where((transfer) => transfer.fromUserId == userId)
          .toList();
      final localById = {
        for (final transfer in localAfterUpload) transfer.id: transfer,
      };

      for (final remote in remoteTransfers) {
        if (remote.fromUserId != userId) continue;
        final local = localById[remote.id];
        if (local == null ||
            (local.syncStatus == SyncStatus.synced &&
                remote.updatedAt.isAfter(local.updatedAt))) {
          await _transferLocal.save(
            remote.copyWith(syncStatus: SyncStatus.synced),
          );
        }
      }

      AppLogger.success(
        'Transfer sync completed (${remoteTransfers.length} remote)',
      );
      return !hadFailures;
    } catch (e, stackTrace) {
      AppLogger.error('Transfer sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncMonthlySavings({required String userId}) async {
    AppLogger.sync('Monthly savings sync started');

    try {
      var hadFailures = false;
      final accounts = await _accountLocal.getAccounts();
      final accountIds = accounts
          .where((account) => account.userId == userId)
          .map((account) => account.id)
          .toSet();
      final allLocalSnapshots = await _monthlySavingLocal.getAllSnapshots();
      final localSnapshots = <MonthlySavingDto>[];
      for (final snapshot in allLocalSnapshots) {
        final belongsToUser =
            snapshot.userId == userId ||
            (snapshot.userId.isEmpty &&
                accountIds.contains(snapshot.accountId));
        if (!belongsToUser) continue;

        if (snapshot.userId.isEmpty || snapshot.updatedAt == null) {
          final migrated = snapshot.copyWith(
            userId: userId,
            updatedAt:
                snapshot.updatedAt ??
                DateTime.utc(snapshot.year, snapshot.month),
            syncStatus: snapshot.userId.isEmpty
                ? SyncStatus.pending
                : snapshot.syncStatus,
          );
          await _monthlySavingLocal.saveSnapshot(migrated);
          localSnapshots.add(migrated);
        } else {
          localSnapshots.add(snapshot);
        }
      }

      for (final snap in localSnapshots) {
        if (snap.syncStatus != SyncStatus.pending) continue;
        try {
          final synced = snap.copyWith(syncStatus: SyncStatus.synced);
          await _monthlySavingRemote.saveSnapshot(synced);
          await _monthlySavingLocal.saveSnapshot(synced);
        } catch (e, stackTrace) {
          hadFailures = true;
          AppLogger.warning('Failed uploading monthly snapshot: ${snap.id}');
          AppLogger.error('Monthly snapshot upload error', e, stackTrace);
        }
      }

      final remoteSnapshots = await _monthlySavingRemote.fetchSnapshots(
        userId: userId,
      );
      final localAfterUpload = (await _monthlySavingLocal.getAllSnapshots())
          .where((snapshot) => snapshot.userId == userId)
          .toList();
      final localById = {
        for (final snapshot in localAfterUpload) snapshot.id: snapshot,
      };

      for (final remote in remoteSnapshots) {
        if (remote.userId != userId) continue;
        final local = localById[remote.id];
        if (local == null ||
            (local.syncStatus == SyncStatus.synced &&
                _snapshotIsNewer(remote, local))) {
          await _monthlySavingLocal.saveSnapshot(
            remote.copyWith(syncStatus: SyncStatus.synced),
          );
        }
      }

      AppLogger.success(
        'Monthly savings sync completed (${remoteSnapshots.length} remote)',
      );
      return !hadFailures;
    } catch (e, stackTrace) {
      AppLogger.error('Monthly savings sync failed', e, stackTrace);
      return false;
    }
  }

  bool _isTerminalSettlement(SettlementStatus status) {
    return status == SettlementStatus.confirmed ||
        status == SettlementStatus.rejected ||
        status == SettlementStatus.cancelled;
  }

  String _settlementRefundMutationId(String settlementId) {
    return 'settlement-refund-$settlementId';
  }

  Future<bool> _hasAnySettlementRefundMutation({
    required String userId,
    required String accountId,
    required String settlementId,
  }) async {
    final accounts = await _accountLocal.getAccounts();
    final account = accounts
        .where((item) => item.id == accountId && item.userId == userId)
        .firstOrNull;
    if (account == null) return false;

    final ids = [
      _settlementRefundMutationId(settlementId),
      'settlement-rejection-refund-$settlementId',
      'settlement-cancel-refund-$settlementId',
      'settlement-duplicate-refund-$settlementId',
    ];
    return ids.any(
      (id) =>
          account.pendingBalanceMutations.containsKey(id) ||
          account.appliedBalanceMutationIds.contains(id),
    );
  }

  Future<bool> syncNotifications({required String userId}) async {
    AppLogger.sync('Notification sync started');

    try {
      var hadFailures = false;

      /// Upload local notifications (only own notifications — others fail the update rule)
      final local = await _notificationLocal.getNotifications();
      for (final n in local) {
        if (n.userId != userId) continue;
        try {
          await _notificationRemote.uploadNotification(n);
        } catch (e, stackTrace) {
          hadFailures = true;
          AppLogger.warning('Failed uploading notification: ${n.id}');
          AppLogger.error('Notification upload error', e, stackTrace);
        }
      }

      /// Fetch remote notifications and merge
      final remote = await _notificationRemote.fetchNotifications(
        userId: userId,
      );
      final localIds = local.map((n) => n.id).toSet();
      for (final n in remote) {
        if (!localIds.contains(n.id)) {
          await _notificationLocal.saveNotification(n);
        }
      }

      AppLogger.success(
        'Notification sync completed (${remote.length} remote)',
      );
      return !hadFailures;
    } catch (e, stackTrace) {
      AppLogger.error('Notification sync failed', e, stackTrace);
      return false;
    }
  }

  bool _snapshotIsNewer(MonthlySavingDto candidate, MonthlySavingDto current) {
    final candidateUpdated =
        candidate.updatedAt ?? DateTime.utc(candidate.year, candidate.month);
    final currentUpdated =
        current.updatedAt ?? DateTime.utc(current.year, current.month);
    final comparison = candidateUpdated.compareTo(currentUpdated);
    if (comparison != 0) return comparison > 0;
    return candidate.isCompleted && !current.isCompleted;
  }
}
