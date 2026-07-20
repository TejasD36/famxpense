import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/settlement/settlement_entity.dart';
import 'package:famxpense/shared/enums/settlement_status.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('SettlementEntity', () {
    test('creates with all fields', () {
      final entity = SettlementEntity(
        id: 's-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
        participantIds: ['user-a', 'user-b'],
      );

      expect(entity.id, 's-1');
      expect(entity.fromUserId, 'user-a');
      expect(entity.toUserId, 'user-b');
      expect(entity.amount, 100.0);
      expect(entity.status, SettlementStatus.pending);
      expect(entity.participantIds, ['user-a', 'user-b']);
    });

    test('participantIds defaults to empty list', () {
      final entity = SettlementEntity(
        id: 's-2',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 50.0,
        status: SettlementStatus.pending,
        createdAt: now,
      );

      expect(entity.participantIds, []);
    });

    test('toJson / fromJson roundtrip with participantIds', () {
      final entity = SettlementEntity(
        id: 's-3',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 75.0,
        status: SettlementStatus.confirmed,
        createdAt: now,
        confirmedAt: now,
        relatedExpenseIds: ['exp-1'],
        accountId: 'acc-1',
        participantIds: ['user-a', 'user-b'],
      );

      final json = entity.toJson();
      final restored = SettlementEntity.fromJson(json);

      expect(restored.id, entity.id);
      expect(restored.fromUserId, entity.fromUserId);
      expect(restored.toUserId, entity.toUserId);
      expect(restored.amount, entity.amount);
      expect(restored.status, entity.status);
      expect(restored.createdAt, entity.createdAt);
      expect(restored.confirmedAt, entity.confirmedAt);
      expect(restored.relatedExpenseIds, entity.relatedExpenseIds);
      expect(restored.accountId, entity.accountId);
      expect(restored.participantIds, entity.participantIds);
    });

    test('fromJson defaults participantIds to empty list when missing (DDL @Default)', () {
      final json = {
        'id': 's-4',
        'fromUserId': 'user-a',
        'toUserId': 'user-b',
        'amount': 25.0,
        'status': 'pending',
        'createdAt': now.toIso8601String(),
      };

      final entity = SettlementEntity.fromJson(json);

      expect(entity.participantIds, []);
    });

    test('copyWith updates fields', () {
      final entity = SettlementEntity(
        id: 's-5',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
      );

      final updated = entity.copyWith(amount: 200.0, status: SettlementStatus.confirmed);
      expect(updated.amount, 200.0);
      expect(updated.status, SettlementStatus.confirmed);
      expect(updated.id, 's-5');
    });

    test('equality works', () {
      final a = SettlementEntity(
        id: 's-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
        participantIds: ['user-a', 'user-b'],
      );
      final b = SettlementEntity(
        id: 's-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
        participantIds: ['user-a', 'user-b'],
      );

      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = SettlementEntity(
        id: 's-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 100.0,
        status: SettlementStatus.pending,
        createdAt: now,
      );
      final b = SettlementEntity(
        id: 's-1',
        fromUserId: 'user-a',
        toUserId: 'user-b',
        amount: 200.0,
        status: SettlementStatus.pending,
        createdAt: now,
      );

      expect(a, isNot(equals(b)));
    });
  });
}
