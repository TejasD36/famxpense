import '../../../xcore.dart';

class AccountRemoteDatasourceImpl implements AccountRemoteDatasource {
  final FirebaseFirestore _firestore;

  AccountRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'accounts';

  @override
  Future<void> createAccount(AccountEntity account) async {
    await _firestore.collection(_collection).doc(account.id).set(_toJson(account));
  }

  @override
  Future<void> updateAccount(AccountEntity account) async {
    await _firestore.collection(_collection).doc(account.id).update(_toJson(account));
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await _firestore.collection(_collection).doc(accountId).delete();
  }

  @override
  Future<List<AccountEntity>> fetchAccounts({required String userId}) async {
    final snapshot = await _firestore.collection(_collection).where('userId', isEqualTo: userId).get();
    return snapshot.docs.map((doc) => _fromJson(doc.data())).toList();
  }

  Map<String, dynamic> _toJson(AccountEntity e) {
    return {
      'id': e.id,
      'userId': e.userId,
      'accountName': e.accountName,
      'accountType': e.accountType.name,
      'currentBalance': e.currentBalance,
      'createdAt': e.createdAt.toIso8601String(),
      'updatedAt': e.updatedAt.toIso8601String(),
      'isArchived': e.isArchived,
      'isSavings': e.isSavings,
      'monthlySavingsGoal': e.monthlySavingsGoal,
    };
  }

  AccountEntity _fromJson(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountName: json['accountName'] as String,
      accountType: AccountType.values.firstWhere((t) => t.name == json['accountType']),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
      isSavings: json['isSavings'] as bool? ?? false,
      monthlySavingsGoal: (json['monthlySavingsGoal'] as num?)?.toDouble() ?? 0,
    );
  }
}