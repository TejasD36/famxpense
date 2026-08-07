import '../../../xcore.dart';

class AccountRemoteDatasourceImpl implements AccountRemoteDatasource {
  final FirebaseFirestore _firestore;

  AccountRemoteDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _collection = 'accounts';
  static const _balanceMutationCollection = 'account_balance_mutations';
  static const _accountEntryCollection = 'account_entries';

  @override
  Future<void> createAccount(AccountEntity account) async {
    await _firestore
        .collection(_collection)
        .doc(account.id)
        .set(_toJson(account));
  }

  @override
  Future<void> updateAccount(AccountEntity account) async {
    await _firestore
        .collection(_collection)
        .doc(account.id)
        .update(_metadataJson(account));
  }

  @override
  Future<void> adjustBalance({
    required String accountId,
    required double delta,
    required String mutationId,
    required DateTime updatedAt,
    ManualDepositDto? accountEntry,
  }) async {
    final accountRef = _firestore.collection(_collection).doc(accountId);
    final mutationRef = _firestore
        .collection(_balanceMutationCollection)
        .doc(mutationId);
    final entryRef = accountEntry == null
        ? null
        : _firestore.collection(_accountEntryCollection).doc(accountEntry.id);

    await _firestore.runTransaction((transaction) async {
      final mutation = await transaction.get(mutationRef);
      final account = await transaction.get(accountRef);
      if (mutation.exists) return;
      if (!account.exists) {
        throw StateError('Account $accountId does not exist');
      }

      final userId = account.data()?['userId'] as String?;
      if (userId == null || userId.isEmpty) {
        throw StateError('Account $accountId has no owner');
      }
      final remoteBalance =
          (account.data()?['currentBalance'] as num?)?.toDouble() ?? 0;
      final targetBalance = accountEntry?.isBalanceEdit == true
          ? accountEntry!.newBalance!
          : remoteBalance + delta;
      final effectiveDelta = targetBalance - remoteBalance;

      transaction.update(accountRef, {
        'currentBalance': accountEntry?.isBalanceEdit == true
            ? targetBalance
            : FieldValue.increment(delta),
        'updatedAt': updatedAt.toIso8601String(),
      });
      transaction.set(
        mutationRef,
        _mutationJson(
          mutationId: mutationId,
          accountId: accountId,
          userId: userId,
          delta: effectiveDelta,
          updatedAt: updatedAt,
        ),
      );
      if (entryRef != null) {
        transaction.set(entryRef, {
          ...accountEntry!.toJson(),
          'amount': effectiveDelta,
          'previousBalance': remoteBalance,
          'newBalance': targetBalance,
          'synced': true,
        });
      }
    });
  }

  @override
  Future<void> transferBalance({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String fromMutationId,
    required String toMutationId,
    required DateTime updatedAt,
  }) async {
    final accounts = _firestore.collection(_collection);
    final mutations = _firestore.collection(_balanceMutationCollection);
    final timestamp = updatedAt.toIso8601String();
    final fromAccountRef = accounts.doc(fromAccountId);
    final toAccountRef = accounts.doc(toAccountId);
    final fromMutationRef = mutations.doc(fromMutationId);
    final toMutationRef = mutations.doc(toMutationId);

    await _firestore.runTransaction((transaction) async {
      final fromMutation = await transaction.get(fromMutationRef);
      final toMutation = await transaction.get(toMutationRef);
      final fromAccount = await transaction.get(fromAccountRef);
      final toAccount = await transaction.get(toAccountRef);
      if (!fromAccount.exists || !toAccount.exists) {
        throw StateError('Both transfer accounts must exist');
      }

      final fromUserId = fromAccount.data()?['userId'] as String?;
      final toUserId = toAccount.data()?['userId'] as String?;
      if (fromUserId == null || fromUserId != toUserId) {
        throw StateError('Transfer accounts must have the same owner');
      }

      if (!fromMutation.exists) {
        transaction.update(fromAccountRef, {
          'currentBalance': FieldValue.increment(-amount),
          'updatedAt': timestamp,
        });
        transaction.set(
          fromMutationRef,
          _mutationJson(
            mutationId: fromMutationId,
            accountId: fromAccountId,
            userId: fromUserId,
            delta: -amount,
            updatedAt: updatedAt,
          ),
        );
      }
      if (!toMutation.exists) {
        transaction.update(toAccountRef, {
          'currentBalance': FieldValue.increment(amount),
          'updatedAt': timestamp,
        });
        transaction.set(
          toMutationRef,
          _mutationJson(
            mutationId: toMutationId,
            accountId: toAccountId,
            userId: fromUserId,
            delta: amount,
            updatedAt: updatedAt,
          ),
        );
      }
    });
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await _firestore.collection(_collection).doc(accountId).delete();
  }

  @override
  Future<List<AccountEntity>> fetchAccounts({required String userId}) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .get(const GetOptions(source: Source.server));
    return snapshot.docs.map((doc) => _fromJson(doc.data())).toList();
  }

  @override
  Future<List<ManualDepositDto>> fetchAccountEntries({
    required String userId,
  }) async {
    final snapshot = await _firestore
        .collection(_accountEntryCollection)
        .where('userId', isEqualTo: userId)
        .get(const GetOptions(source: Source.server));
    return snapshot.docs
        .map((doc) => ManualDepositDto.fromJson(doc.data()))
        .toList();
  }

  Map<String, dynamic> _metadataJson(AccountEntity account) {
    return {
      'accountName': account.accountName,
      'accountType': account.accountType.name,
      'updatedAt': account.updatedAt.toIso8601String(),
      'isArchived': account.isArchived,
      'isSavings': account.isSavings,
      'monthlySavingsGoal': account.monthlySavingsGoal,
    };
  }

  Map<String, dynamic> _mutationJson({
    required String mutationId,
    required String accountId,
    required String userId,
    required double delta,
    required DateTime updatedAt,
  }) {
    return {
      'id': mutationId,
      'accountId': accountId,
      'userId': userId,
      'delta': delta,
      'createdAt': updatedAt.toIso8601String(),
    };
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
      accountType: AccountType.values.firstWhere(
        (t) => t.name == json['accountType'],
      ),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isArchived: json['isArchived'] as bool? ?? false,
      isSavings: json['isSavings'] as bool? ?? false,
      monthlySavingsGoal: (json['monthlySavingsGoal'] as num?)?.toDouble() ?? 0,
    );
  }
}
