import '../../xcore.dart';

class PartnershipRepositoryImpl implements PartnershipRepository {
  final PartnershipRemoteDatasource _remoteDatasource;
  final PartnershipLocalDatasource _localDatasource;

  PartnershipRepositoryImpl({
    required PartnershipRemoteDatasource remoteDatasource,
    required PartnershipLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<void> sendRequest(PartnershipEntity partnership) async {
    await _localDatasource.savePartnership(partnership.toDto());
    try {
      await _remoteDatasource.sendRequest(partnership.toRemoteDto());
    } catch (e, stackTrace) {
      AppLogger.error('Partnership send remote failed', e, stackTrace);
    }
  }

  @override
  Future<void> updateRequest(PartnershipEntity partnership) async {
    await _localDatasource.savePartnership(partnership.toDto());
    try {
      await _remoteDatasource.updateRequest(partnership.toRemoteDto());
    } catch (e, stackTrace) {
      AppLogger.error('Partnership update remote failed', e, stackTrace);
    }
  }

  @override
  Future<void> deletePartnership(String partnershipId) async {
    await _localDatasource.deletePartnership(partnershipId);
    try {
      await _remoteDatasource.deletePartnership(partnershipId);
    } catch (e, stackTrace) {
      AppLogger.error('Partnership delete remote failed', e, stackTrace);
    }
  }

  @override
  Future<List<PartnershipEntity>> getPartnerships({required String userId}) async {
    final result = await _remoteDatasource.getPartnerships(userId: userId);
    final entities = result.map((e) => e.toEntity()).toList();
    await _localDatasource.savePartnerships(entities.map((e) => e.toDto()).toList());
    return entities;
  }
}
