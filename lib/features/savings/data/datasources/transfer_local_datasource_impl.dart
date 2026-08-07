import '../../xcore.dart';

class TransferLocalDatasourceImpl extends BaseHiveService<TransferDto>
    implements TransferLocalDatasource {
  TransferLocalDatasourceImpl()
    : super(Hive.box<TransferDto>(HiveBoxes.transfers));

  @override
  Future<void> save(TransferDto transfer) async {
    await put(key: transfer.id, value: transfer);
  }

  @override
  Future<List<TransferDto>> fetchAll() async {
    return getAll();
  }

  @override
  Future<List<TransferDto>> getByAccount(String accountId) async {
    return box.values
        .where(
          (t) => t.fromAccountId == accountId || t.toAccountId == accountId,
        )
        .toList();
  }

  @override
  Future<void> deleteTransfer(String transferId) async {
    await delete(transferId);
  }
}
