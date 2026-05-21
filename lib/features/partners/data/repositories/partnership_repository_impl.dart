import '../../xcore.dart';

class PartnershipRepositoryImpl implements PartnershipRepository {
  final PartnershipRemoteDatasource _remoteDatasource;

  PartnershipRepositoryImpl({required PartnershipRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override
  Future<void> sendRequest(PartnershipEntity partnership) async {
    await _remoteDatasource.sendRequest(partnership.toRemoteDto());
  }

  @override
  Future<void> updateRequest(PartnershipEntity partnership) async {
    await _remoteDatasource.updateRequest(partnership.toRemoteDto());
  }

  @override
  Future<List<PartnershipEntity>> getPartnerships({required String userId}) async {
    final result = await _remoteDatasource.getPartnerships(userId: userId);

    return result.map((e) => e.toEntity()).toList();
  }
}
