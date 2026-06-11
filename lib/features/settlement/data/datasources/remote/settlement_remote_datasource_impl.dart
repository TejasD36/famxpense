import '../../../xcore.dart';

class SettlementRemoteDatasourceImpl implements SettlementRemoteDatasource {
  final FirebaseFirestore _firestore;

  SettlementRemoteDatasourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  static const _collection = 'settlements';

  @override
  Future<void> createSettlement(SettlementEntity settlement) async {
    await _firestore.collection(_collection).doc(settlement.id).set(_toJson(settlement));
  }

  @override
  Future<List<SettlementEntity>> fetchSettlements({required String userId}) async {
    final fromQuery = await _firestore.collection(_collection).where('fromUserId', isEqualTo: userId).get();
    final toQuery = await _firestore.collection(_collection).where('toUserId', isEqualTo: userId).get();

    final seenIds = <String>{};
    final results = <SettlementEntity>[];

    for (final doc in [...fromQuery.docs, ...toQuery.docs]) {
      if (seenIds.add(doc.id)) {
        results.add(_fromJson(doc.data()));
      }
    }

    return results;
  }

  Map<String, dynamic> _toJson(SettlementEntity e) {
    return {
      'id': e.id,
      'fromUserId': e.fromUserId,
      'toUserId': e.toUserId,
      'amount': e.amount,
      'status': e.status.name,
      'createdAt': e.createdAt.toIso8601String(),
      'confirmedAt': e.confirmedAt?.toIso8601String(),
      'relatedExpenseIds': e.relatedExpenseIds,
      if (e.accountId != null) 'accountId': e.accountId,
    };
  }

  SettlementEntity _fromJson(Map<String, dynamic> json) {
    return SettlementEntity(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: SettlementStatus.values.firstWhere((s) => s.name == json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      confirmedAt: json['confirmedAt'] != null ? DateTime.parse(json['confirmedAt'] as String) : null,
      relatedExpenseIds: (json['relatedExpenseIds'] as List<dynamic>?)?.cast<String>(),
      accountId: json['accountId'] as String?,
    );
  }
}
