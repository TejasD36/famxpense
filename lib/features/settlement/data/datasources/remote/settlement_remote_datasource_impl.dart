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
    final snapshot = await _firestore
        .collection(_collection)
        .where('participantIds', arrayContains: userId)
        .get();

    return snapshot.docs.map((doc) => _fromJson(doc.data())).toList();
  }

  @override
  Future<SettlementEntity?> fetchSettlementById(String settlementId) async {
    final doc = await _firestore.collection(_collection).doc(settlementId).get();
    if (!doc.exists || doc.data() == null) return null;
    return _fromJson(doc.data()!);
  }

  @override
  Future<void> updateSettlementStatus(String settlementId, SettlementStatus status) async {
    await _firestore.collection(_collection).doc(settlementId).update({'status': status.name});
  }

  @override
  Future<void> deleteSettlement(String settlementId) async {
    await _firestore.collection(_collection).doc(settlementId).delete();
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
      'participantIds': [e.fromUserId, e.toUserId],
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
      participantIds: (json['participantIds'] as List<dynamic>?)?.cast<String>() ?? [json['fromUserId'] as String, json['toUserId'] as String],
    );
  }
}
