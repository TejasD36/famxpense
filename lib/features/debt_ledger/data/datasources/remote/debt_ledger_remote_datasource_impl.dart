import '../../../xcore.dart';

class DebtLedgerRemoteDatasourceImpl implements DebtLedgerRemoteDatasource {
  final FirebaseFirestore _firestore;

  DebtLedgerRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'debt_ledgers';

  @override
  Future<void> saveLedger(DebtLedgerEntity ledger) async {
    await _firestore.collection(_collection).doc(ledger.id).set(_toJson(ledger));
  }

  @override
  Future<List<DebtLedgerEntity>> fetchLedgers({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('participantIds', arrayContains: userId)
        .get();

    return snapshot.docs.map((doc) => _fromJson(doc.data())).toList();
  }

  Map<String, dynamic> _toJson(DebtLedgerEntity e) {
    return {
      'id': e.id,
      'userA': e.userA,
      'userB': e.userB,
      'netBalance': e.netBalance,
      'updatedAt': e.updatedAt.toIso8601String(),
      'participantIds': [e.userA, e.userB],
    };
  }

  DebtLedgerEntity _fromJson(Map<String, dynamic> json) {
    return DebtLedgerEntity(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      netBalance: (json['netBalance'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participantIds: (json['participantIds'] as List<dynamic>?)?.cast<String>() ?? [json['userA'] as String, json['userB'] as String],
    );
  }
}