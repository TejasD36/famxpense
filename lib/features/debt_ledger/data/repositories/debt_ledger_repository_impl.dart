import 'dart:async';

import '../../xcore.dart';

class DebtLedgerRepositoryImpl implements DebtLedgerRepository {
  final DebtLedgerLocalDatasource _localDatasource;
  final DebtLedgerRemoteDatasource _remoteDatasource;
  Future<void> _localMutationQueue = Future<void>.value();

  DebtLedgerRepositoryImpl({
    required DebtLedgerLocalDatasource localDatasource,
    required DebtLedgerRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<List<DebtLedgerEntity>> getLedgers({required String userId}) async {
    final dtos = await _localDatasource.getLedgers();
    return dtos
        .where((l) => l.userA == userId || l.userB == userId)
        .map((d) => d.toEntity())
        .toList();
  }

  @override
  Future<void> saveLedger(DebtLedgerEntity ledger) async {
    await _localDatasource.saveLedger(ledger.toDto());
    try {
      await _remoteDatasource.saveLedger(ledger);
    } catch (e, stackTrace) {
      AppLogger.warning('Debt ledger remote sync failed');
      AppLogger.error('Debt ledger remote sync error', e, stackTrace);
    }
  }

  @override
  Future<void> updateDebt(
    String userA,
    String userB,
    double delta, {
    String? mutationId,
  }) async {
    if (!delta.isFinite || delta == 0) {
      throw ArgumentError.value(
        delta,
        'delta',
        'Debt adjustment must be finite and non-zero',
      );
    }
    final sorted = [userA, userB]..sort();
    final canonicalA = sorted[0];
    final canonicalB = sorted[1];
    final id = '${canonicalA}_$canonicalB';
    final resolvedMutationId = mutationId ?? const Uuid().v4();

    if (canonicalA == userB && canonicalB == userA) {
      delta = -delta;
    }

    late bool requiresRemote;
    final dto = await _mutateLocal(() async {
      final all = await _localDatasource.getLedgers();
      final existing = all
          .where(
            (ledger) =>
                ledger.id == id ||
                (ledger.userA == canonicalA && ledger.userB == canonicalB),
          )
          .firstOrNull;
      if (existing?.appliedMutationIds.contains(resolvedMutationId) ?? false) {
        requiresRemote = false;
        return existing!;
      }
      final existingDelta = existing?.pendingMutations[resolvedMutationId];
      if (existingDelta != null) {
        if (existingDelta != delta) {
          throw StateError(
            'Debt mutation $resolvedMutationId has a different amount',
          );
        }
        requiresRemote = true;
        return existing!;
      }

      requiresRemote = true;
      final now = DateTime.now().toUtc();
      final pendingMutations = Map<String, double>.of(
        existing?.pendingMutations ?? const {},
      )..[resolvedMutationId] = delta;
      final result = existing == null
          ? DebtLedgerDto(
              id: id,
              userA: canonicalA,
              userB: canonicalB,
              netBalance: delta,
              updatedAt: now,
              pendingMutations: pendingMutations,
            )
          : existing.copyWith(
              id: id,
              userA: canonicalA,
              userB: canonicalB,
              netBalance: existing.netBalance + delta,
              updatedAt: now,
              pendingMutations: pendingMutations,
            );
      await _localDatasource.saveLedger(result);
      return result;
    });

    if (!requiresRemote) return;

    try {
      await _remoteDatasource.adjustDebt(
        userA: canonicalA,
        userB: canonicalB,
        delta: delta,
        mutationId: resolvedMutationId,
        updatedAt: dto.updatedAt,
      );
      await _markMutationApplied(id, resolvedMutationId);
    } catch (e, stackTrace) {
      AppLogger.warning('Debt ledger mutation queued for sync');
      AppLogger.error('Debt ledger mutation remote error', e, stackTrace);
    }
  }

  Future<void> _markMutationApplied(String ledgerId, String mutationId) {
    return _mutateLocal(() async {
      final ledgers = await _localDatasource.getLedgers();
      final current = ledgers.where((item) => item.id == ledgerId).firstOrNull;
      if (current == null ||
          !current.pendingMutations.containsKey(mutationId)) {
        return;
      }

      final pending = Map<String, double>.of(current.pendingMutations)
        ..remove(mutationId);
      await _localDatasource.saveLedger(
        current.copyWith(
          pendingMutations: pending,
          appliedMutationIds: {
            ...current.appliedMutationIds,
            mutationId,
          }.toList(),
        ),
      );
    });
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
}
