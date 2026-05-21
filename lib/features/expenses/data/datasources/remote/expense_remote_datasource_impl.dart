import '../../../xcore.dart';

class ExpenseRemoteDatasourceImpl implements ExpenseRemoteDatasource {
  final FirebaseFirestore _firestore;

  ExpenseRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _expensesCollection = 'expenses';

  @override
  Future<void> createExpense(ExpenseRemoteDto expense) async {
    await _firestore.collection(_expensesCollection).doc(expense.id).set(expense.toJson());
  }

  @override
  Future<List<ExpenseRemoteDto>> fetchExpenses({required String userId}) async {
    final snapshot = await _firestore.collection(_expensesCollection).where('participantIds', arrayContains: userId).get();

    return snapshot.docs.map((doc) {
      return ExpenseRemoteDto.fromJson(doc.data());
    }).toList();
  }

  @override
  Future<List<ExpenseRemoteDto>> getExpenses({required String userId}) async {
    final snapshot = await _firestore.collection(_expensesCollection).where('participantIds', arrayContains: userId).get();

    return snapshot.docs.map((doc) {
      return ExpenseRemoteDto.fromJson(doc.data());
    }).toList();
  }
}
