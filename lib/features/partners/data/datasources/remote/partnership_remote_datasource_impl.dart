import '../../../xcore.dart';

class PartnershipRemoteDatasourceImpl implements PartnershipRemoteDatasource {
  final FirebaseFirestore _firestore;

  PartnershipRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'partnerships';

  @override
  Future<void> sendRequest(PartnershipRemoteDto partnership) async {
    AppLogger.firebase('Sending partnership request');

    await _firestore.collection(_collection).doc(partnership.id).set(partnership.toJson());
  }

  @override
  Future<void> updateRequest(PartnershipRemoteDto partnership) async {
    AppLogger.firebase('Updating partnership');

    await _firestore.collection(_collection).doc(partnership.id).update(partnership.toJson());
  }

  @override
  Future<void> deletePartnership(String partnershipId) async {
    await _firestore.collection(_collection).doc(partnershipId).delete();
  }

  @override
  Future<List<PartnershipRemoteDto>> getPartnerships({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('participantIds', arrayContains: userId)
        .get();

    return snapshot.docs.map((doc) => PartnershipRemoteDto.fromJson(doc.data())).toList();
  }
}
