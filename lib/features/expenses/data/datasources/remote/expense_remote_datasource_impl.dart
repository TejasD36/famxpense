import '../../../xcore.dart';

class ExpenseRemoteDatasourceImpl implements ExpenseRemoteDatasource {
  final FirebaseFirestore _firestore;

  ExpenseRemoteDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _expensesCollection = 'expenses';

  @override
  Future<void> createExpense(ExpenseRemoteDto expense) async {
    await _firestore
        .collection(_expensesCollection)
        .doc(expense.id)
        .set(_toFirestoreJson(expense));
  }

  @override
  Future<void> updateExpense(ExpenseRemoteDto expense) async {
    await _firestore
        .collection(_expensesCollection)
        .doc(expense.id)
        .set(_toFirestoreJson(expense));
  }

  @override
  Future<List<ExpenseRemoteDto>> fetchExpenses({required String userId}) async {
    final snapshot = await _firestore
        .collection(_expensesCollection)
        .where('participantIds', arrayContains: userId)
        .get();

    return snapshot.docs.map((doc) {
      return ExpenseRemoteDto.fromJson(doc.data());
    }).toList();
  }

  Map<String, dynamic> _toFirestoreJson(ExpenseRemoteDto expense) {
    return {
      ...expense.toJson(),
      'amount': expense.amount.round(),
      'participants': expense.participants
          .map(
            (participant) => {
              ...participant,
              if (participant['amount'] is num)
                'amount': (participant['amount'] as num).round(),
            },
          )
          .toList(),
    };
  }
}
