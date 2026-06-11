import '../../xcore.dart';

abstract interface class ManualDepositLocalDatasource {
  Future<void> save(ManualDepositDto deposit);
  Future<List<ManualDepositDto>> getByAccount(String accountId);
  Future<void> delete(String id);
}
