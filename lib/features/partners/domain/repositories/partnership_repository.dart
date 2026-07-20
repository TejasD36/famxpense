import '../../../../shared/domain/entities/partnership/partnership_entity.dart';

abstract interface class PartnershipRepository {
  Future<void> sendRequest(PartnershipEntity partnership);

  Future<void> updateRequest(PartnershipEntity partnership);

  Future<void> deletePartnership(String partnershipId);

  Future<List<PartnershipEntity>> getPartnerships({required String userId});
}
