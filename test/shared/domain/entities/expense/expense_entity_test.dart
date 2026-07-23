import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_entity.dart';
import 'package:famxpense/shared/domain/entities/expense/expense_participant_entity.dart';
import 'package:famxpense/shared/enums/expense_type.dart';
import 'package:famxpense/shared/enums/split_type.dart';
import 'package:famxpense/shared/enums/sync_status.dart';

void main() {
  final now = DateTime(2026, 7, 21, 12, 0, 0).toUtc();

  final participant = ExpenseParticipantEntity(
    userId: 'user-b',
    amount: 50.0,
  );

  final baseEntity = ExpenseEntity(
    id: 'exp-1',
    title: 'Lunch',
    note: 'At cafe',
    amount: 100.0,
    paidByUserId: 'user-a',
    ownerUserId: 'user-a',
    expenseType: ExpenseType.shared,
    splitType: SplitType.equal,
    participants: [participant],
    expenseDate: now,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.synced,
    category: 'food',
  );

  group('ExpenseEntity', () {
    test('creates with required fields', () {
      expect(baseEntity.id, 'exp-1');
      expect(baseEntity.title, 'Lunch');
      expect(baseEntity.amount, 100.0);
    });

    test('latitude and longitude are null by default', () {
      expect(baseEntity.latitude, isNull);
      expect(baseEntity.longitude, isNull);
    });

    test('stores lat/lng when provided', () {
      final entity = baseEntity.copyWith(latitude: 12.9716, longitude: 77.5946);
      expect(entity.latitude, 12.9716);
      expect(entity.longitude, 77.5946);
    });

    test('copyWith updates fields', () {
      final updated = baseEntity.copyWith(amount: 200.0, title: 'Dinner');
      expect(updated.amount, 200.0);
      expect(updated.title, 'Dinner');
      expect(updated.id, 'exp-1');
    });

    test('equality works', () {
      final a = baseEntity.copyWith();
      final b = baseEntity.copyWith();
      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = baseEntity;
      final b = baseEntity.copyWith(amount: 200.0);
      expect(a, isNot(equals(b)));
    });

    test('toJson serializes all top-level fields', () {
      final entity = baseEntity.copyWith(latitude: 12.9716, longitude: 77.5946);
      final json = entity.toJson();

      expect(json['id'], 'exp-1');
      expect(json['title'], 'Lunch');
      expect(json['amount'], 100.0);
      expect(json['latitude'], 12.9716);
      expect(json['longitude'], 77.5946);
      expect(json['category'], 'food');
      expect(json['syncStatus'], 'synced');
    });

    test('toJson includes participants list', () {
      final json = baseEntity.toJson();
      expect(json['participants'], isA<List>());
      expect((json['participants'] as List).length, 1);
    });
  });
}
