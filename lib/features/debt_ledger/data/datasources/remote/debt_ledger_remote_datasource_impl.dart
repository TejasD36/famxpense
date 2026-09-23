import '../../../xcore.dart';

class DebtLedgerRemoteDatasourceImpl implements DebtLedgerRemoteDatasource {
  final FirebaseFirestore _firestore;

  DebtLedgerRemoteDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _collection = 'debt_ledgers';
  static const _mutationCollection = 'debt_ledger_mutations';

  @override
  Future<void> saveLedger(DebtLedgerEntity ledger) async {
    final ledgerRef = _firestore.collection(_collection).doc(ledger.id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(ledgerRef);
      if (snapshot.exists) return;

      transaction.set(ledgerRef, _toJson(ledger));
      for (final mutation in ledger.pendingMutations.entries) {
        transaction.set(
          _firestore.collection(_mutationCollection).doc(mutation.key),
          _mutationJson(
            mutationId: mutation.key,
            ledgerId: ledger.id,
            participantIds: [ledger.userA, ledger.userB],
            delta: mutation.value,
            updatedAt: ledger.updatedAt,
          ),
        );
      }
    });
  }

  @override
  Future<void> adjustDebt({
    required String userA,
    required String userB,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
  }) async {
    final ledgerId = '${userA}_$userB';
    final ledgerRef = _firestore.collection(_collection).doc(ledgerId);
    final mutationRef = _firestore
        .collection(_mutationCollection)
        .doc(mutationId);

    await _firestore.runTransaction((transaction) async {
      final mutation = await transaction.get(mutationRef);
      final ledger = await transaction.get(ledgerRef);
      if (mutation.exists) return;

      if (ledger.exists) {
        final data = ledger.data()!;
        if (data['userA'] != userA || data['userB'] != userB) {
          throw StateError('Debt ledger participants do not match');
        }
        transaction.update(ledgerRef, {
          'netBalance': FieldValue.increment(delta),
          'updatedAt': updatedAt.toIso8601String(),
        });
      } else {
        transaction.set(ledgerRef, {
          'id': ledgerId,
          'userA': userA,
          'userB': userB,
          'netBalance': delta,
          'updatedAt': updatedAt.toIso8601String(),
          'participantIds': [userA, userB],
        });
      }
      transaction.set(
        mutationRef,
        _mutationJson(
          mutationId: mutationId,
          ledgerId: ledgerId,
          participantIds: [userA, userB],
          delta: delta,
          updatedAt: updatedAt,
        ),
      );
    });
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

  Map<String, dynamic> _mutationJson({
    required String mutationId,
    required String ledgerId,
    required List<String> participantIds,
    required double delta,
    required DateTime updatedAt,
  }) {
    return {
      'id': mutationId,
      'ledgerId': ledgerId,
      'participantIds': participantIds,
      'delta': delta,
      'createdAt': updatedAt.toIso8601String(),
    };
  }

  DebtLedgerEntity _fromJson(Map<String, dynamic> json) {
    return DebtLedgerEntity(
      id: json['id'] as String,
      userA: json['userA'] as String,
      userB: json['userB'] as String,
      netBalance: (json['netBalance'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participantIds:
          (json['participantIds'] as List<dynamic>?)?.cast<String>() ??
          [json['userA'] as String, json['userB'] as String],
    );
  }
}
