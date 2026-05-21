import '../../../xcore.dart';

abstract interface class PartnershipRemoteDatasource {
  Future<void> sendRequest(PartnershipRemoteDto partnership);

  Future<void> updateRequest(PartnershipRemoteDto partnership);

  Future<List<PartnershipRemoteDto>> getPartnerships({required String userId});
}
