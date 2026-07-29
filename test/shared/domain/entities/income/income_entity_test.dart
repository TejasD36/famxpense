import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/income/income_entity.dart';
import 'package:famxpense/shared/enums/income_source.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

void main() {
  final now = DateTime(2026, 7, 27, 12, 0, 0).toUtc();

  final baseEntity = IncomeEntity(
    id: 'inc-1',
    userId: 'user-a',
    accountId: 'acct-1',
    amount: 5000.0,
    source: IncomeSource.salary,
    description: 'July salary',
    createdAt: now,
    updatedAt: now,
  );

  group('IncomeEntity', () {
    test('creates with required fields', () {
      expect(baseEntity.id, 'inc-1');
      expect(baseEntity.userId, 'user-a');
      expect(baseEntity.accountId, 'acct-1');
      expect(baseEntity.amount, 5000.0);
      expect(baseEntity.source, IncomeSource.salary);
    });

    test('syncStatus defaults to pending', () {
      expect(baseEntity.syncStatus, SyncStatus.pending);
    });

    test('copyWith updates fields', () {
      final updated = baseEntity.copyWith(amount: 6000.0, description: 'Bonus');
      expect(updated.amount, 6000.0);
      expect(updated.description, 'Bonus');
      expect(updated.id, 'inc-1');
    });

    test('equality works', () {
      final a = baseEntity.copyWith();
      final b = baseEntity.copyWith();
      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = baseEntity;
      final b = baseEntity.copyWith(amount: 2000.0);
      expect(a, isNot(equals(b)));
    });

    test('toJson serializes all fields', () {
      final json = baseEntity.toJson();
      expect(json['id'], 'inc-1');
      expect(json['userId'], 'user-a');
      expect(json['accountId'], 'acct-1');
      expect(json['amount'], 5000.0);
      expect(json['source'], 'salary');
      expect(json['description'], 'July salary');
      expect(json['syncStatus'], 'pending');
    });

    test('fromJson deserializes correctly', () {
      final json = baseEntity.toJson();
      final restored = IncomeEntity.fromJson(json);
      expect(restored, baseEntity);
    });
  });
}
