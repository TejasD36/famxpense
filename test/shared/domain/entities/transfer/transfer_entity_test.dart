import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/transfer/transfer_entity.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

void main() {
  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();

  final baseEntity = TransferEntity(
    id: 'tr-1',
    fromAccountId: 'acct-checking',
    toAccountId: 'acct-savings',
    fromUserId: 'user-a',
    toUserId: 'user-a',
    amount: 3000.0,
    description: 'Savings allocation',
    createdAt: now,
    updatedAt: now,
  );

  group('TransferEntity', () {
    test('creates with required fields', () {
      expect(baseEntity.id, 'tr-1');
      expect(baseEntity.fromAccountId, 'acct-checking');
      expect(baseEntity.toAccountId, 'acct-savings');
      expect(baseEntity.fromUserId, 'user-a');
      expect(baseEntity.toUserId, 'user-a');
      expect(baseEntity.amount, 3000.0);
      expect(baseEntity.description, 'Savings allocation');
    });

    test('syncStatus defaults to synced', () {
      expect(baseEntity.syncStatus, SyncStatus.synced);
    });

    test('copyWith updates fields', () {
      final updated = baseEntity.copyWith(amount: 5000.0, description: 'Bonus savings');
      expect(updated.amount, 5000.0);
      expect(updated.description, 'Bonus savings');
    });

    test('equality works', () {
      final a = baseEntity.copyWith();
      final b = baseEntity.copyWith();
      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = baseEntity;
      final b = baseEntity.copyWith(amount: 1000.0);
      expect(a, isNot(equals(b)));
    });

    test('toJson serializes all fields', () {
      final json = baseEntity.toJson();
      expect(json['id'], 'tr-1');
      expect(json['fromAccountId'], 'acct-checking');
      expect(json['toAccountId'], 'acct-savings');
      expect(json['fromUserId'], 'user-a');
      expect(json['toUserId'], 'user-a');
      expect(json['amount'], 3000.0);
      expect(json['description'], 'Savings allocation');
      expect(json['syncStatus'], 'synced');
    });

    test('fromJson deserializes correctly', () {
      final json = baseEntity.toJson();
      final restored = TransferEntity.fromJson(json);
      expect(restored, baseEntity);
    });
  });
}
