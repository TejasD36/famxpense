import '../../../xcore.dart';

abstract interface class TransferRemoteDatasource {
  Future<void> createTransfer(TransferDto transfer);
  Future<List<TransferDto>> fetchTransfers({required String userId});
}
