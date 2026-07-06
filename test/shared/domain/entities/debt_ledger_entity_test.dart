import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/debt_ledger/debt_ledger_entity.dart';

void main() {
  final now = DateTime(2026, 7, 1, 12, 0, 0).toUtc();

  group('DebtLedgerEntity', () {
    test('creates with all fields', () {
      final entity = DebtLedgerEntity(
        id: 'ledger-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );

      expect(entity.id, 'ledger-1');
      expect(entity.userA, 'user-a');
      expect(entity.userB, 'user-b');
      expect(entity.netBalance, 100.0);
      expect(entity.updatedAt, now);
    });

    test('toJson / fromJson roundtrip', () {
      final entity = DebtLedgerEntity(
        id: 'ledger-2',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: -50.0,
        updatedAt: now,
      );

      final json = entity.toJson();
      final restored = DebtLedgerEntity.fromJson(json);

      expect(restored.id, entity.id);
      expect(restored.userA, entity.userA);
      expect(restored.userB, entity.userB);
      expect(restored.netBalance, entity.netBalance);
      expect(restored.updatedAt, entity.updatedAt);
    });

    test('copyWith updates fields', () {
      final entity = DebtLedgerEntity(
        id: 'ledger-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );

      final updated = entity.copyWith(netBalance: 200.0);
      expect(updated.netBalance, 200.0);
      expect(updated.id, 'ledger-1');
    });

    test('equality works', () {
      final a = DebtLedgerEntity(
        id: 'ledger-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );
      final b = DebtLedgerEntity(
        id: 'ledger-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );

      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = DebtLedgerEntity(
        id: 'ledger-1',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );
      final b = DebtLedgerEntity(
        id: 'ledger-2',
        userA: 'user-a',
        userB: 'user-b',
        netBalance: 100.0,
        updatedAt: now,
      );

      expect(a, isNot(equals(b)));
    });
  });
}
