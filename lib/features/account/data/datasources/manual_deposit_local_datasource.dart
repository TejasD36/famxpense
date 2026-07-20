import '../../xcore.dart';

abstract interface class ManualDepositLocalDatasource {
  Future<void> save(ManualDepositDto deposit);
  Future<List<ManualDepositDto>> getByAccount(String accountId);
  Future<List<ManualDepositDto>> fetchAll();
  Future<void> delete(String id);
}
