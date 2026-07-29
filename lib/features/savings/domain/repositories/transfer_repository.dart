import '../../xcore.dart';

abstract interface class TransferRepository {
  Future<void> saveTransfer(TransferDto transfer);
  Future<List<TransferDto>> getAll();
  Future<List<TransferDto>> getByAccount(String accountId);
}
