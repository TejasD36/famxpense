import '../../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../../features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import '../../../features/expenses/data/transformers/mappers/expense_remote_mapper.dart';
import '../../../shared/data/transformers/mappers/expense/expense_mapper.dart';
import '../../../shared/enums/sync_status.dart';
import '../../logger/app_logger.dart';

class SyncService {
  final ExpenseLocalDatasource _localDatasource;

  final ExpenseRemoteDatasource _remoteDatasource;

  SyncService({required ExpenseLocalDatasource localDatasource, required ExpenseRemoteDatasource remoteDatasource})
    : _localDatasource = localDatasource,
      _remoteDatasource = remoteDatasource;

  Future<void> syncExpenses({required String userId}) async {
    AppLogger.sync('Expense sync started');

    try {
      /// STEP 1
      /// GET PENDING LOCAL EXPENSES

      final pendingExpenses = await _localDatasource.getPendingExpenses();

      AppLogger.sync(
        'Pending expenses: '
        '${pendingExpenses.length}',
      );

      /// STEP 2
      /// UPLOAD PENDING

      for (final expense in pendingExpenses) {
        try {
          final entity = expense.toEntity();

          AppLogger.firebase(
            'Uploading pending expense: '
            '${entity.id}',
          );

          await _remoteDatasource.createExpense(entity.toRemoteDto());

          final syncedExpense = entity.copyWith(syncStatus: SyncStatus.synced);

          await _localDatasource.saveExpense(syncedExpense.toDto());

          AppLogger.success(
            'Expense synced: '
            '${entity.id}',
          );
        } catch (e, stackTrace) {
          AppLogger.warning(
            'Failed syncing expense: '
            '${expense.id}',
          );

          AppLogger.error('Pending sync failed', e, stackTrace);
        }
      }

      /// STEP 3
      /// FETCH REMOTE EXPENSES

      AppLogger.firebase('Fetching remote expenses');

      final remoteExpenses = await _remoteDatasource.fetchExpenses(userId: userId);

      AppLogger.firebase(
        'Fetched ${remoteExpenses.length} '
        'remote expenses',
      );

      /// STEP 4
      /// MERGE INTO LOCAL HIVE

      final localExpenses = remoteExpenses.map((e) => e.toEntity().toDto()).toList();

      await _localDatasource.saveExpenses(localExpenses);

      AppLogger.sync('Remote merge completed');

      AppLogger.success('Expense sync completed');
    } catch (e, stackTrace) {
      AppLogger.error('Global sync failed', e, stackTrace);
    }
  }
}
