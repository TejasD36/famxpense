import '../../../xcore.dart';

abstract interface class MonthlySavingRemoteDatasource {
  Future<void> saveSnapshot(MonthlySavingDto snapshot);
  Future<List<MonthlySavingDto>> fetchSnapshots({required String userId});
}
