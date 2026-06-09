import '../../../features/account/data/datasources/account_local_datasource.dart';
import '../../../features/account/data/datasources/remote/account_remote_datasource.dart';
import '../../../features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import '../../../features/expenses/data/transformers/mappers/expense_remote_mapper.dart';
import '../../../shared/data/transformers/mappers/account/account_mapper.dart';
import '../../../shared/data/transformers/mappers/debt_ledger/debt_ledger_mapper.dart';
import '../../../shared/data/transformers/mappers/expense/expense_mapper.dart';
import '../../../shared/enums/sync_status.dart';
import '../../logger/app_logger.dart';

class SyncService {
  final ExpenseLocalDatasource _expenseLocal;
  final ExpenseRemoteDatasource _expenseRemote;
  final AccountLocalDatasource _accountLocal;
  final AccountRemoteDatasource _accountRemote;
  final DebtLedgerLocalDatasource _debtLedgerLocal;
  final DebtLedgerRemoteDatasource _debtLedgerRemote;

  SyncService({
    required ExpenseLocalDatasource expenseLocal,
    required ExpenseRemoteDatasource expenseRemote,
    required AccountLocalDatasource accountLocal,
    required AccountRemoteDatasource accountRemote,
    required DebtLedgerLocalDatasource debtLedgerLocal,
    required DebtLedgerRemoteDatasource debtLedgerRemote,
  }) : _expenseLocal = expenseLocal,
       _expenseRemote = expenseRemote,
       _accountLocal = accountLocal,
       _accountRemote = accountRemote,
       _debtLedgerLocal = debtLedgerLocal,
       _debtLedgerRemote = debtLedgerRemote;

  Future<bool> syncAll({required String userId}) async {
    AppLogger.sync('Full sync started');

    try {
      await syncExpenses(userId: userId);
      await syncAccounts(userId: userId);
      await syncDebtLedgers(userId: userId);

      AppLogger.success('Full sync completed');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Full sync failed', e, stackTrace);
      return false;
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

      /// Upload all local accounts to remote
      for (final account in localByUser) {
        try {
          await _accountRemote.createAccount(account.toEntity());
        } catch (e, stackTrace) {
          AppLogger.warning('Failed uploading account: ${account.id}');
          AppLogger.error('Account upload error', e, stackTrace);
        }
      }

      /// Fetch remote accounts
      final remoteAccounts = await _accountRemote.fetchAccounts(userId: userId);
      final localIds = localByUser.map((a) => a.id).toSet();

      /// Save any remote-only accounts locally
      for (final remote in remoteAccounts) {
        if (!localIds.contains(remote.id)) {
          await _accountLocal.saveAccount(remote.toDto());
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
}