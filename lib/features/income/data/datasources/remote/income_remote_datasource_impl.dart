import '../../../xcore.dart';

class IncomeRemoteDatasourceImpl implements IncomeRemoteDatasource {
  final FirebaseFirestore _firestore;

  IncomeRemoteDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _collection = 'incomes';

  @override
  Future<void> createIncome(IncomeDto income) async {
    await _firestore
        .collection(_collection)
        .doc(income.id)
        .set(income.toJson());
  }

  @override
  Future<List<IncomeDto>> fetchIncomes({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => IncomeDto.fromJson(doc.data())).toList();
  }

  @override
  Future<void> deleteIncome(String incomeId) async {
    await _firestore.collection(_collection).doc(incomeId).delete();
  }
}
