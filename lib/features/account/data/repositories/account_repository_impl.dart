import 'dart:async';

import '../../xcore.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountLocalDatasource _localDatasource;
  final AccountRemoteDatasource _remoteDatasource;
  Future<void> _localMutationQueue = Future<void>.value();

  AccountRepositoryImpl({
    required AccountLocalDatasource localDatasource,
    required AccountRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<List<AccountEntity>> getAccounts({required String userId}) async {
    final dtos = await _localDatasource.getAccounts();
    return dtos
        .where((a) => a.userId == userId && !a.isDeleted)
        .map((d) => d.toEntity())
        .toList();
  }

  @override
  Future<void> saveAccount(AccountEntity account) async {
    String? balanceMutationId;
    late bool isNewAccount;
    final pending = await _mutateLocal(() async {
      final accounts = await _localDatasource.getAccountsIncludingDeleted();
      final existing = accounts
          .where((item) => item.id == account.id)
          .firstOrNull;
      if (existing?.isDeleted ?? false) {
        throw StateError('Cannot update an account queued for deletion');
      }
      isNewAccount = existing == null;

      final mutations = Map<String, double>.of(
        existing?.pendingBalanceMutations ?? const {},
      );
      final balanceDelta = existing == null
          ? 0.0
          : account.currentBalance - existing.currentBalance;
      if (balanceDelta != 0) {
        balanceMutationId = const Uuid().v4();
        mutations[balanceMutationId!] = balanceDelta;
      }

      final metadataChanged =
          existing == null || _hasMetadataChanged(existing, account);
      final result = account.toDto().copyWith(
        pendingBalanceMutations: mutations,
        appliedBalanceMutationIds:
            existing?.appliedBalanceMutationIds ??
            account.appliedBalanceMutationIds,
        hasPendingMetadataChanges:
            (existing?.hasPendingMetadataChanges ?? false) || metadataChanged,
      );
      await _localDatasource.saveAccount(result);
      return result;
    });

    unawaited(
      _syncSavedAccount(
        accountId: account.id,
        pending: pending,
        isNewAccount: isNewAccount,
        balanceMutationId: balanceMutationId,
      ),
    );
  }

  Future<void> _syncSavedAccount({
    required String accountId,
    required AccountDto pending,
    required bool isNewAccount,
    required String? balanceMutationId,
  }) async {
    try {
      if (isNewAccount) {
        await _remoteDatasource.createAccount(pending.toEntity());
        await _markAllMutationsApplied(accountId);
        await _acknowledgeMetadata(accountId);
        return;
      }

      if (pending.hasPendingMetadataChanges) {
        await _remoteDatasource.updateAccount(pending.toEntity());
        await _acknowledgeMetadata(accountId);
      }
      if (balanceMutationId != null) {
        await _remoteDatasource.adjustBalance(
          accountId: accountId,
          delta: pending.pendingBalanceMutations[balanceMutationId]!,
          mutationId: balanceMutationId,
          updatedAt: pending.updatedAt,
        );
        await _markMutationApplied(accountId, balanceMutationId);
      }
    } catch (e, stackTrace) {
      AppLogger.warning('Account changes queued for sync');
      AppLogger.error('Account remote save error', e, stackTrace);
    }
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    final tombstone = await _mutateLocal(() async {
      final accounts = await _localDatasource.getAccountsIncludingDeleted();
      final account = accounts
          .where((item) => item.id == accountId)
          .firstOrNull;
      if (account == null) return null;
      if (account.pendingBalanceMutations.isNotEmpty) {
        throw StateError(
          'This account has unsynced balance changes. Sync before deleting it.',
        );
      }
      final deleted = account.copyWith(
        isDeleted: true,
        hasPendingMetadataChanges: false,
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDatasource.saveAccount(deleted);
      return deleted;
    });
    if (tombstone == null) return;

    try {
      await _remoteDatasource.deleteAccount(accountId);
      await _mutateLocal(() => _localDatasource.deleteAccount(accountId));
    } catch (e, stackTrace) {
      AppLogger.warning('Account deletion queued for sync');
      AppLogger.error('Account remote delete error', e, stackTrace);
    }
  }

  @override
  Future<void> updateBalance(String accountId, double newBalance) async {
    if (!newBalance.isFinite) {
      throw ArgumentError.value(
        newBalance,
        'newBalance',
        'Balance must be finite',
      );
    }
    _validateWholeRupees(newBalance, field: 'newBalance');
    final accounts = await _localDatasource.getAccounts();
    final account = accounts.firstWhere((item) => item.id == accountId);
    final delta = newBalance - account.currentBalance;
    if (delta != 0) await adjustBalance(accountId, delta);
  }

  @override
  Future<AccountEntity> recordManualBalanceChange(
    ManualDepositDto entry,
  ) async {
    if (entry.userId.isEmpty) {
      throw ArgumentError('A manual account entry requires an owner');
    }
    final accounts = await _localDatasource.getAccounts();
    final account = accounts
        .where(
          (item) => item.id == entry.accountId && item.userId == entry.userId,
        )
        .firstOrNull;
    if (account == null) throw StateError('Account entry owner mismatch');
    if (entry.previousBalance == null || entry.newBalance == null) {
      throw ArgumentError(
        'A manual account entry requires old and new balances',
      );
    }
    _validateWholeRupees(entry.previousBalance!, field: 'previousBalance');
    _validateWholeRupees(entry.newBalance!, field: 'newBalance');
    if (account.currentBalance != entry.previousBalance) {
      throw StateError('Account balance changed before the entry was applied');
    }
    final delta = entry.newBalance! - entry.previousBalance!;
    return _adjustBalance(
      entry.accountId,
      delta,
      mutationId: 'manual-entry-${entry.id}',
      accountEntry: entry,
    );
  }

  @override
  Future<AccountEntity> adjustBalance(
    String accountId,
    double delta, {
    String? mutationId,
  }) => _adjustBalance(accountId, delta, mutationId: mutationId);

  Future<AccountEntity> _adjustBalance(
    String accountId,
    double delta, {
    String? mutationId,
    ManualDepositDto? accountEntry,
  }) async {
    if (!delta.isFinite || delta == 0) {
      throw ArgumentError.value(
        delta,
        'delta',
        'Balance adjustment must be finite and non-zero',
      );
    }
    _validateWholeRupees(delta, field: 'delta');

    final resolvedMutationId = mutationId ?? const Uuid().v4();
    late bool requiresRemote;
    var updated = await _mutateLocal(() async {
      final dtos = await _localDatasource.getAccounts();
      final account = dtos.firstWhere((a) => a.id == accountId);
      if (account.isDeleted) {
        throw StateError('Cannot adjust an account queued for deletion');
      }
      if (account.appliedBalanceMutationIds.contains(resolvedMutationId)) {
        requiresRemote = false;
        return account;
      }
      final existingDelta = account.pendingBalanceMutations[resolvedMutationId];
      if (existingDelta != null) {
        if (existingDelta != delta) {
          throw StateError(
            'Balance mutation $resolvedMutationId has a different amount',
          );
        }
        requiresRemote = true;
        return account;
      }

      requiresRemote = true;
      final mutations = Map<String, double>.of(account.pendingBalanceMutations)
        ..[resolvedMutationId] = delta;
      final result = account.copyWith(
        currentBalance: account.currentBalance + delta,
        pendingBalanceMutations: mutations,
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDatasource.saveAccount(result);
      return result;
    });

    if (!requiresRemote) return updated.toEntity();

    try {
      if (accountEntry == null) {
        await _remoteDatasource.adjustBalance(
          accountId: accountId,
          delta: delta,
          mutationId: resolvedMutationId,
          updatedAt: updated.updatedAt,
        );
      } else {
        await _remoteDatasource.adjustBalance(
          accountId: accountId,
          delta: delta,
          mutationId: resolvedMutationId,
          updatedAt: updated.updatedAt,
          accountEntry: accountEntry,
        );
      }
      await _markMutationApplied(accountId, resolvedMutationId);
      updated = updated.copyWith(
        pendingBalanceMutations: Map<String, double>.of(
          updated.pendingBalanceMutations,
        )..remove(resolvedMutationId),
        appliedBalanceMutationIds: [
          ...updated.appliedBalanceMutationIds,
          if (!updated.appliedBalanceMutationIds.contains(resolvedMutationId))
            resolvedMutationId,
        ],
      );
    } catch (e, stackTrace) {
      AppLogger.warning('Account balance adjustment queued for sync');
      AppLogger.error('Account balance adjustment remote error', e, stackTrace);
    }

    return updated.toEntity();
  }

  @override
  Future<({AccountEntity fromAccount, AccountEntity toAccount})>
  transferBalance({
    required String userId,
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    String? mutationId,
  }) async {
    if (!amount.isFinite || amount <= 0) {
      throw ArgumentError.value(
        amount,
        'amount',
        'Transfer amount must be finite and greater than zero',
      );
    }
    _validateWholeRupees(amount, field: 'amount');
    if (fromAccountId == toAccountId) {
      throw ArgumentError('Source and destination accounts must be different');
    }

    final mutationBase = mutationId ?? const Uuid().v4();
    final fromMutationId = '$mutationBase:debit';
    final toMutationId = '$mutationBase:credit';
    late bool requiresRemote;
    var updated = await _mutateLocal(() async {
      final accounts = await _localDatasource.getAccounts();
      final from = accounts.firstWhere(
        (a) => a.id == fromAccountId && a.userId == userId,
      );
      final to = accounts.firstWhere(
        (a) => a.id == toAccountId && a.userId == userId,
      );
      if (from.isDeleted || to.isDeleted) {
        throw StateError(
          'Cannot transfer using an account queued for deletion',
        );
      }
      final fromKnown =
          from.pendingBalanceMutations.containsKey(fromMutationId) ||
          from.appliedBalanceMutationIds.contains(fromMutationId);
      final toKnown =
          to.pendingBalanceMutations.containsKey(toMutationId) ||
          to.appliedBalanceMutationIds.contains(toMutationId);
      if (fromKnown || toKnown) {
        if (!fromKnown || !toKnown) {
          throw StateError('Transfer balance journal is incomplete');
        }
        requiresRemote =
            !from.appliedBalanceMutationIds.contains(fromMutationId) ||
            !to.appliedBalanceMutationIds.contains(toMutationId);
        return (from: from, to: to);
      }

      if (from.currentBalance < amount) {
        throw StateError('Insufficient balance');
      }

      requiresRemote = true;
      final updatedAt = DateTime.now().toUtc();
      final updatedFrom = from.copyWith(
        currentBalance: from.currentBalance - amount,
        pendingBalanceMutations: Map<String, double>.of(
          from.pendingBalanceMutations,
        )..[fromMutationId] = -amount,
        updatedAt: updatedAt,
      );
      final updatedTo = to.copyWith(
        currentBalance: to.currentBalance + amount,
        pendingBalanceMutations: Map<String, double>.of(
          to.pendingBalanceMutations,
        )..[toMutationId] = amount,
        updatedAt: updatedAt,
      );
      await _localDatasource.saveAccounts([updatedFrom, updatedTo]);
      return (from: updatedFrom, to: updatedTo);
    });

    if (!requiresRemote) {
      return (
        fromAccount: updated.from.toEntity(),
        toAccount: updated.to.toEntity(),
      );
    }

    try {
      await _remoteDatasource.transferBalance(
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        fromMutationId: fromMutationId,
        toMutationId: toMutationId,
        updatedAt: updated.from.updatedAt,
      );
      await _markTransferMutationsApplied(
        fromAccountId: fromAccountId,
        fromMutationId: fromMutationId,
        toAccountId: toAccountId,
        toMutationId: toMutationId,
      );
      updated = (
        from: updated.from.copyWith(
          pendingBalanceMutations: Map<String, double>.of(
            updated.from.pendingBalanceMutations,
          )..remove(fromMutationId),
          appliedBalanceMutationIds: [
            ...updated.from.appliedBalanceMutationIds,
            if (!updated.from.appliedBalanceMutationIds.contains(
              fromMutationId,
            ))
              fromMutationId,
          ],
        ),
        to: updated.to.copyWith(
          pendingBalanceMutations: Map<String, double>.of(
            updated.to.pendingBalanceMutations,
          )..remove(toMutationId),
          appliedBalanceMutationIds: [
            ...updated.to.appliedBalanceMutationIds,
            if (!updated.to.appliedBalanceMutationIds.contains(toMutationId))
              toMutationId,
          ],
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.warning('Account transfer balances queued for sync');
      AppLogger.error('Account transfer remote error', e, stackTrace);
    }

    return (
      fromAccount: updated.from.toEntity(),
      toAccount: updated.to.toEntity(),
    );
  }

  Future<T> _mutateLocal<T>(Future<T> Function() operation) {
    final completer = Completer<T>();
    _localMutationQueue = _localMutationQueue.then((_) async {
      try {
        completer.complete(await operation());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  void _validateWholeRupees(double amount, {required String field}) {
    if ((amount - amount.round()).abs() > 0.000001) {
      throw ArgumentError.value(amount, field, 'Amount must be whole rupees');
    }
  }

  bool _hasMetadataChanged(AccountDto existing, AccountEntity updated) {
    return existing.userId != updated.userId ||
        existing.accountName != updated.accountName ||
        existing.accountType != updated.accountType ||
        existing.isArchived != updated.isArchived ||
        existing.isSavings != updated.isSavings ||
        existing.monthlySavingsGoal != updated.monthlySavingsGoal;
  }

  Future<void> _acknowledgeMetadata(String accountId) {
    return _mutateLocal(() async {
      final accounts = await _localDatasource.getAccounts();
      final current = accounts
          .where((item) => item.id == accountId)
          .firstOrNull;
      if (current == null || !current.hasPendingMetadataChanges) return;
      await _localDatasource.saveAccount(
        current.copyWith(hasPendingMetadataChanges: false),
      );
    });
  }

  Future<void> _markMutationApplied(String accountId, String mutationId) {
    return _mutateLocal(() async {
      final accounts = await _localDatasource.getAccounts();
      final current = accounts
          .where((item) => item.id == accountId)
          .firstOrNull;
      if (current == null ||
          !current.pendingBalanceMutations.containsKey(mutationId)) {
        return;
      }
      final mutations = Map<String, double>.of(current.pendingBalanceMutations)
        ..remove(mutationId);
      final applied = current.appliedBalanceMutationIds.contains(mutationId)
          ? current.appliedBalanceMutationIds
          : [...current.appliedBalanceMutationIds, mutationId];
      await _localDatasource.saveAccount(
        current.copyWith(
          pendingBalanceMutations: mutations,
          appliedBalanceMutationIds: applied,
        ),
      );
    });
  }

  Future<void> _markAllMutationsApplied(String accountId) {
    return _mutateLocal(() async {
      final accounts = await _localDatasource.getAccounts();
      final current = accounts
          .where((item) => item.id == accountId)
          .firstOrNull;
      if (current == null || current.pendingBalanceMutations.isEmpty) return;
      final applied = {
        ...current.appliedBalanceMutationIds,
        ...current.pendingBalanceMutations.keys,
      }.toList();
      await _localDatasource.saveAccount(
        current.copyWith(
          pendingBalanceMutations: const {},
          appliedBalanceMutationIds: applied,
        ),
      );
    });
  }

  Future<void> _markTransferMutationsApplied({
    required String fromAccountId,
    required String fromMutationId,
    required String toAccountId,
    required String toMutationId,
  }) {
    return _mutateLocal(() async {
      final accounts = await _localDatasource.getAccounts();
      final from = accounts
          .where((item) => item.id == fromAccountId)
          .firstOrNull;
      final to = accounts.where((item) => item.id == toAccountId).firstOrNull;
      if (from == null || to == null) return;
      if (!from.pendingBalanceMutations.containsKey(fromMutationId) &&
          !to.pendingBalanceMutations.containsKey(toMutationId)) {
        return;
      }

      final fromMutations = Map<String, double>.of(from.pendingBalanceMutations)
        ..remove(fromMutationId);
      final toMutations = Map<String, double>.of(to.pendingBalanceMutations)
        ..remove(toMutationId);
      await _localDatasource.saveAccounts([
        from.copyWith(
          pendingBalanceMutations: fromMutations,
          appliedBalanceMutationIds: {
            ...from.appliedBalanceMutationIds,
            fromMutationId,
          }.toList(),
        ),
        to.copyWith(
          pendingBalanceMutations: toMutations,
          appliedBalanceMutationIds: {
            ...to.appliedBalanceMutationIds,
            toMutationId,
          }.toList(),
        ),
      ]);
    });
  }
}
