import '../../../xcore.dart';

class TransferRemoteDatasourceImpl implements TransferRemoteDatasource {
  final FirebaseFirestore _firestore;

  TransferRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'transfers';

  @override
  Future<void> createTransfer(TransferDto transfer) async {
    await _firestore.collection(_collection).doc(transfer.id).set(transfer.toJson());
  }

  @override
  Future<List<TransferDto>> fetchTransfers({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('fromUserId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => TransferDto.fromJson(doc.data())).toList();
  }
}
