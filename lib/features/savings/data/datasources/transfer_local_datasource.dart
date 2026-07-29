import '../../xcore.dart';

abstract interface class TransferLocalDatasource {
  Future<void> save(TransferDto transfer);
  Future<List<TransferDto>> fetchAll();
  Future<List<TransferDto>> getByAccount(String accountId);
}
