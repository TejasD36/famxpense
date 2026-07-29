import '../../../xcore.dart';

class MonthlySavingRemoteDatasourceImpl implements MonthlySavingRemoteDatasource {
  final FirebaseFirestore _firestore;

  MonthlySavingRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'monthly_savings';

  @override
  Future<void> saveSnapshot(MonthlySavingDto snapshot) async {
    await _firestore.collection(_collection).doc(snapshot.id).set(snapshot.toJson());
  }

  @override
  Future<List<MonthlySavingDto>> fetchSnapshots({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => MonthlySavingDto.fromJson(doc.data())).toList();
  }
}
