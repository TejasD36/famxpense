import '../../xcore.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferLocalDatasource _local;
  final TransferRemoteDatasource _remote;
  final RefreshNotifier _refreshNotifier;

  TransferRepositoryImpl({
    required TransferLocalDatasource local,
    required TransferRemoteDatasource remote,
    required RefreshNotifier refreshNotifier,
  }) : _local = local,
       _remote = remote,
       _refreshNotifier = refreshNotifier;

  @override
  Future<void> saveTransfer(TransferDto transfer) async {
    final dto = transfer.copyWith(
      updatedAt: DateTime.now().toUtc(),
      syncStatus: SyncStatus.synced,
    );

    try {
      await _remote.createTransfer(dto);
      await _local.save(dto);
    } catch (e) {
      AppLogger.warning('Firebase sync failed — saved locally');
      final pending = dto.copyWith(syncStatus: SyncStatus.pending);
      await _local.save(pending);
      _refreshNotifier.notifySyncError('Firebase sync failed — saved locally');
    }
  }

  @override
  Future<List<TransferDto>> getAll() async {
    return _local.fetchAll();
  }

  @override
  Future<List<TransferDto>> getByAccount(String accountId) async {
    return _local.getByAccount(accountId);
  }
}
