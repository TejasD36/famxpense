import '../../../features/account/data/datasources/account_local_datasource.dart';
import '../../../features/account/data/datasources/remote/account_remote_datasource.dart';
import '../../../features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import '../../../features/expenses/data/transformers/mappers/expense_remote_mapper.dart';
import '../../../features/notification/data/datasources/notification_local_datasource.dart';
import '../../../features/notification/data/datasources/remote/notification_remote_datasource.dart';
import '../../../features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../../features/settlement/data/datasources/settlement_local_datasource.dart';
import '../../../features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import '../../../shared/data/datasources/local/user_local_datasource.dart';
import '../../../shared/data/datasources/remote/user_remote_datasource.dart';
import '../../../shared/data/transformers/dtos/user/user_dto.dart';
import '../../../shared/data/transformers/mappers/account/account_mapper.dart';
import '../../../shared/data/transformers/mappers/debt_ledger/debt_ledger_mapper.dart';
import '../../../shared/data/transformers/mappers/expense/expense_mapper.dart';
import '../../../shared/data/transformers/mappers/settlement/settlement_mapper.dart';
import '../../../shared/enums/settlement_status.dart';
import '../../../shared/enums/sync_status.dart';
import '../../logger/app_logger.dart';

class SyncService {
  bool _isSyncing = false;

  final ExpenseLocalDatasource _expenseLocal;
  final ExpenseRemoteDatasource _expenseRemote;
  final AccountLocalDatasource _accountLocal;
  final AccountRemoteDatasource _accountRemote;
  final DebtLedgerLocalDatasource _debtLedgerLocal;
  final DebtLedgerRemoteDatasource _debtLedgerRemote;
  final SettlementLocalDatasource _settlementLocal;
  final SettlementRemoteDatasource _settlementRemote;
  final UserLocalDatasource _userLocal;
  final UserRemoteDatasource _userRemote;
  final PartnershipRemoteDatasource _partnershipRemote;
  final NotificationLocalDatasource _notificationLocal;
  final NotificationRemoteDatasource _notificationRemote;

  SyncService({
    required ExpenseLocalDatasource expenseLocal,
    required ExpenseRemoteDatasource expenseRemote,
    required AccountLocalDatasource accountLocal,
    required AccountRemoteDatasource accountRemote,
    required DebtLedgerLocalDatasource debtLedgerLocal,
    required DebtLedgerRemoteDatasource debtLedgerRemote,
    required SettlementLocalDatasource settlementLocal,
    required SettlementRemoteDatasource settlementRemote,
    required UserLocalDatasource userLocal,
    required UserRemoteDatasource userRemote,
    required PartnershipRemoteDatasource partnershipRemote,
    required NotificationLocalDatasource notificationLocal,
    required NotificationRemoteDatasource notificationRemote,
  }) : _expenseLocal = expenseLocal,
       _expenseRemote = expenseRemote,
       _accountLocal = accountLocal,
       _accountRemote = accountRemote,
       _debtLedgerLocal = debtLedgerLocal,
       _debtLedgerRemote = debtLedgerRemote,
       _settlementLocal = settlementLocal,
       _settlementRemote = settlementRemote,
       _userLocal = userLocal,
       _userRemote = userRemote,
       _partnershipRemote = partnershipRemote,
       _notificationLocal = notificationLocal,
       _notificationRemote = notificationRemote;

  Future<bool> syncAll({required String userId}) async {
    if (_isSyncing) {
      AppLogger.sync('Sync already in progress, skipping');
      return false;
    }
    _isSyncing = true;
    AppLogger.sync('Full sync started');

    try {
      await syncExpenses(userId: userId);
      await syncAccounts(userId: userId);
      await syncDebtLedgers(userId: userId);
      await syncSettlements(userId: userId);
      await syncUsers(userId: userId);
      await syncNotifications(userId: userId);

      AppLogger.success('Full sync completed');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Full sync failed', e, stackTrace);
      return false;
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> syncExpenses({required String userId}) async {
    AppLogger.sync('Expense sync started');

    try {
      final pendingExpenses = await _expenseLocal.getPendingExpenses(ownerUserId: userId);

      AppLogger.sync('Pending expenses: ${pendingExpenses.length}');

      for (final expense in pendingExpenses) {
        try {
          final entity = expense.toEntity();
          await _expenseRemote.createExpense(entity.toRemoteDto());

          final syncedExpense = entity.copyWith(syncStatus: SyncStatus.synced);
          await _expenseLocal.saveExpense(syncedExpense.toDto());
        } catch (e, stackTrace) {
          AppLogger.warning('Failed syncing expense: ${expense.id}');
          AppLogger.error('Pending sync failed', e, stackTrace);
        }
      }

      AppLogger.firebase('Fetching remote expenses');
      final remoteExpenses = await _expenseRemote.fetchExpenses(userId: userId);
      AppLogger.firebase('Fetched ${remoteExpenses.length} remote expenses');

      final localExpenses = remoteExpenses.map((e) => e.toEntity().toDto()).toList();
      final pendingLocal = await _expenseLocal.getPendingExpenses(ownerUserId: userId);
      final pendingIds = pendingLocal.map((e) => e.id).toSet();

      final merged = [
        ...localExpenses.where((e) => !pendingIds.contains(e.id)),
        ...pendingLocal,
      ];

      await _expenseLocal.saveExpenses(merged);

      try {
        await _expenseLocal.clearOldSyncedExpenses(ownerUserId: userId);
      } catch (e, stackTrace) {
        AppLogger.warning('Failed to clear old expenses');
        AppLogger.error('Clear old expenses error', e, stackTrace);
      }

      AppLogger.success('Expense sync completed');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Global sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncAccounts({required String userId}) async {
    AppLogger.sync('Account sync started');

    try {
      final localAccounts = await _accountLocal.getAccounts();
      final localByUser = localAccounts.where((a) => a.userId == userId).toList();

      /// Fetch remote accounts (download first so we merge correctly)
      final remoteAccounts = await _accountRemote.fetchAccounts(userId: userId);
      final remoteById = {for (final a in remoteAccounts) a.id: a};

      /// Save all remote accounts locally (overwrites with remote truth)
      for (final remote in remoteAccounts) {
        await _accountLocal.saveAccount(remote.toDto());
      }

      /// Upload any local-only accounts (created offline) to remote
      for (final account in localByUser) {
        if (!remoteById.containsKey(account.id)) {
          try {
            await _accountRemote.createAccount(account.toEntity());
          } catch (e, stackTrace) {
            AppLogger.warning('Failed uploading account: ${account.id}');
            AppLogger.error('Account upload error', e, stackTrace);
          }
        }
      }

      AppLogger.success('Account sync completed (${remoteAccounts.length} remote)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Account sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncDebtLedgers({required String userId}) async {
    AppLogger.sync('Debt ledger sync started');

    try {
      final localLedgers = await _debtLedgerLocal.getLedgers();
      final localByUser = localLedgers.where((l) => l.userA == userId || l.userB == userId).toList();

      /// Upload local ledgers to remote
      for (final ledger in localByUser) {
        try {
          await _debtLedgerRemote.saveLedger(ledger.toEntity());
        } catch (e, stackTrace) {
          AppLogger.warning('Failed uploading ledger: ${ledger.id}');
          AppLogger.error('Ledger upload error', e, stackTrace);
        }
      }

      /// Fetch remote ledgers
      final remoteLedgers = await _debtLedgerRemote.fetchLedgers(userId: userId);
      final localIds = localByUser.map((l) => l.id).toSet();

      /// Save any remote-only ledgers
      for (final remote in remoteLedgers) {
        if (!localIds.contains(remote.id)) {
          await _debtLedgerLocal.saveLedger(remote.toDto());
        }
      }

      AppLogger.success('Debt ledger sync completed (${remoteLedgers.length} remote)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Debt ledger sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncSettlements({required String userId}) async {
    AppLogger.sync('Settlement sync started');

    try {
      final localSettlements = await _settlementLocal.getSettlements();
      final localByUser = localSettlements.where((s) => s.fromUserId == userId || s.toUserId == userId).toList();

      /// Upload local settlements to remote
      for (final settlement in localByUser) {
        try {
          await _settlementRemote.createSettlement(settlement.toEntity());
        } catch (e, stackTrace) {
          AppLogger.warning('Failed uploading settlement: ${settlement.id}');
          AppLogger.error('Settlement upload error', e, stackTrace);
        }
      }

      /// Fetch remote settlements
      final remoteSettlements = await _settlementRemote.fetchSettlements(userId: userId);
      final localById = {for (final s in localByUser) s.id: s};

      /// Save any remote-only settlements locally and handle status transitions
      for (final remote in remoteSettlements) {
        final local = localById[remote.id];
        if (local == null) {
          /// New remote settlement — save locally
          await _settlementLocal.saveSettlement(remote.toDto());
        } else if (local.status == SettlementStatus.pending && remote.status == SettlementStatus.confirmed) {
          /// Pending was confirmed on remote — update local status (debt already updated by confirmer)
          await _settlementLocal.updateSettlementStatus(remote.id, SettlementStatus.confirmed);
        } else if (local.status == SettlementStatus.pending && remote.status == SettlementStatus.rejected) {
          /// Pending was rejected on remote — refund payer's account
          await _settlementLocal.updateSettlementStatus(remote.id, SettlementStatus.rejected);
          if (remote.accountId != null) {
            try {
              final accounts = await _accountLocal.getAccounts();
              final account = accounts.where((a) => a.id == remote.accountId).firstOrNull;
              if (account != null) {
                await _accountLocal.saveAccount(
                  account.copyWith(currentBalance: account.currentBalance + remote.amount),
                );
              }
            } catch (e, stackTrace) {
              AppLogger.error('Rejected settlement refund failed', e, stackTrace);
            }
          }
        }
      }

      AppLogger.success('Settlement sync completed (${remoteSettlements.length} remote)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Settlement sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncUsers({required String userId}) async {
    AppLogger.sync('User sync started');

    try {
      final partnerships = await _partnershipRemote.getPartnerships(userId: userId);
      final partnerIds = partnerships.map((p) => p.senderId == userId ? p.receiverId : p.senderId).toSet();

      for (final partnerId in partnerIds) {
        final cached = _userLocal.getUser(partnerId);
        if (cached != null) continue;

        final remote = await _userRemote.getUser(partnerId);
        if (remote != null) {
          await _userLocal.saveUser(UserDto(
            id: remote.id,
            name: remote.name,
            nickname: remote.nickname,
            email: remote.email,
            profileImageUrl: remote.profileImageUrl,
            createdAt: remote.createdAt,
            updatedAt: remote.updatedAt,
            isActive: remote.isActive,
          ));
        }
      }

      AppLogger.success('User sync completed (${partnerIds.length} partners)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('User sync failed', e, stackTrace);
      return false;
    }
  }

  Future<bool> syncNotifications({required String userId}) async {
    AppLogger.sync('Notification sync started');

    try {
      /// Upload local notifications
      final local = await _notificationLocal.getNotifications();
      for (final n in local) {
        try {
          await _notificationRemote.uploadNotification(n);
        } catch (e, stackTrace) {
          AppLogger.warning('Failed uploading notification: ${n.id}');
          AppLogger.error('Notification upload error', e, stackTrace);
        }
      }

      /// Fetch remote notifications and merge
      final remote = await _notificationRemote.fetchNotifications(userId: userId);
      final localIds = local.map((n) => n.id).toSet();
      for (final n in remote) {
        if (!localIds.contains(n.id)) {
          await _notificationLocal.saveNotification(n);
        }
      }

      AppLogger.success('Notification sync completed (${remote.length} remote)');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Notification sync failed', e, stackTrace);
      return false;
    }
  }
}