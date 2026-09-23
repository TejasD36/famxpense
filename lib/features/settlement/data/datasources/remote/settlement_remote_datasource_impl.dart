import '../../../xcore.dart';

class SettlementRemoteDatasourceImpl implements SettlementRemoteDatasource {
  final FirebaseFirestore _firestore;

  SettlementRemoteDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _collection = 'settlements';

  @override
  Future<void> createSettlement(SettlementEntity settlement) async {
    await _firestore
        .collection(_collection)
        .doc(settlement.id)
        .set(_toJson(settlement));
  }

  @override
  Future<List<SettlementEntity>> fetchSettlements({
    required String userId,
  }) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('participantIds', arrayContains: userId)
        .get();

    return snapshot.docs.map((doc) => _fromJson(doc.data())).toList();
  }

  @override
  Future<SettlementEntity?> fetchSettlementById(String settlementId) async {
    final doc = await _firestore
        .collection(_collection)
        .doc(settlementId)
        .get();
    if (!doc.exists || doc.data() == null) return null;
    return _fromJson(doc.data()!);
  }

  @override
  Future<void> updateSettlementStatus(
    String settlementId,
    SettlementStatus status,
  ) async {
    await _firestore.collection(_collection).doc(settlementId).update({
      'status': status.name,
    });
  }

  @override
  Future<SettlementEntity> resolveSettlement({
    required String settlementId,
    required SettlementStatus status,
    required DateTime resolvedAt,
    required String resolutionType,
    required String? fromAccountId,
    required String? toAccountId,
  }) async {
    if (status == SettlementStatus.pending) {
      throw ArgumentError.value(status, 'status', 'Resolution must be final');
    }

    final settlementRef = _firestore.collection(_collection).doc(settlementId);
    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(settlementRef);
      if (!snapshot.exists || snapshot.data() == null) {
        throw StateError('Settlement $settlementId does not exist');
      }

      final current = _fromJson(snapshot.data()!);
      if (current.status != SettlementStatus.pending) return current;

      final resolved = current.copyWith(
        status: status,
        confirmedAt: status == SettlementStatus.confirmed
            ? resolvedAt
            : current.confirmedAt,
        resolvedAt: resolvedAt,
        resolutionType: resolutionType,
        fromAccountId:
            fromAccountId ?? current.fromAccountId ?? current.accountId,
        toAccountId: toAccountId ?? current.toAccountId,
      );
      transaction.update(settlementRef, _resolutionJson(resolved));
      return resolved;
    });
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
      'amount': e.amount.round(),
      'status': e.status.name,
      'createdAt': e.createdAt.toIso8601String(),
      'confirmedAt': e.confirmedAt?.toIso8601String(),
      'resolvedAt': e.resolvedAt?.toIso8601String(),
      'resolutionType': e.resolutionType,
      'relatedExpenseIds': e.relatedExpenseIds,
      if (e.accountId != null) 'accountId': e.accountId,
      if (e.fromAccountId != null) 'fromAccountId': e.fromAccountId,
      if (e.toAccountId != null) 'toAccountId': e.toAccountId,
      'participantIds': [e.fromUserId, e.toUserId],
    };
  }

  Map<String, dynamic> _resolutionJson(SettlementEntity e) {
    return {
      'status': e.status.name,
      'confirmedAt': e.confirmedAt?.toIso8601String(),
      'resolvedAt': e.resolvedAt?.toIso8601String(),
      'resolutionType': e.resolutionType,
      'fromAccountId': e.fromAccountId ?? e.accountId,
      'toAccountId': e.toAccountId,
    };
  }

  SettlementEntity _fromJson(Map<String, dynamic> json) {
    return SettlementEntity(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: SettlementStatus.values.firstWhere(
        (s) => s.name == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'] as String)
          : null,
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.parse(json['resolvedAt'] as String)
          : null,
      resolutionType: json['resolutionType'] as String?,
      relatedExpenseIds: (json['relatedExpenseIds'] as List<dynamic>?)
          ?.cast<String>(),
      accountId: json['accountId'] as String?,
      fromAccountId:
          json['fromAccountId'] as String? ?? json['accountId'] as String?,
      toAccountId: json['toAccountId'] as String?,
      participantIds:
          (json['participantIds'] as List<dynamic>?)?.cast<String>() ??
          [json['fromUserId'] as String, json['toUserId'] as String],
    );
  }
}
