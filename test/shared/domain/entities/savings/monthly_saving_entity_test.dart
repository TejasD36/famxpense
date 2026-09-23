import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/domain/entities/savings/monthly_saving_entity.dart';

void main() {
  final baseEntity = MonthlySavingEntity(
    id: 'ms-1',
    accountId: 'acct-savings-1',
    year: 2026,
    month: 7,
    goalAmount: 10000.0,
    savedAmount: 7000.0,
    openingBalance: 0.0,
    closingBalance: 7000.0,
    achievementPercent: 70.0,
    userId: 'user-a',
  );

  group('MonthlySavingEntity', () {
    test('creates with required fields', () {
      expect(baseEntity.id, 'ms-1');
      expect(baseEntity.accountId, 'acct-savings-1');
      expect(baseEntity.year, 2026);
      expect(baseEntity.month, 7);
      expect(baseEntity.goalAmount, 10000.0);
      expect(baseEntity.savedAmount, 7000.0);
      expect(baseEntity.openingBalance, 0.0);
      expect(baseEntity.closingBalance, 7000.0);
      expect(baseEntity.achievementPercent, 70.0);
    });

    test('isCompleted defaults to false', () {
      expect(baseEntity.isCompleted, false);
    });

    test('copyWith updates fields', () {
      final updated = baseEntity.copyWith(savedAmount: 2000.0, achievementPercent: 20.0);
      expect(updated.savedAmount, 2000.0);
      expect(updated.achievementPercent, 20.0);
      expect(updated.id, 'ms-1');
    });

    test('equality works', () {
      final a = baseEntity.copyWith();
      final b = baseEntity.copyWith();
      expect(a, equals(b));
    });

    test('inequality on different fields', () {
      final a = baseEntity;
      final b = baseEntity.copyWith(savedAmount: 5000.0);
      expect(a, isNot(equals(b)));
    });

    test('toJson serializes all fields', () {
      final json = baseEntity.toJson();
      expect(json['id'], 'ms-1');
      expect(json['accountId'], 'acct-savings-1');
      expect(json['year'], 2026);
      expect(json['month'], 7);
      expect(json['goalAmount'], 10000.0);
      expect(json['savedAmount'], 7000.0);
      expect(json['openingBalance'], 0.0);
      expect(json['closingBalance'], 7000.0);
      expect(json['achievementPercent'], 70.0);
      expect(json['isCompleted'], false);
    });

    test('fromJson deserializes correctly', () {
      final json = baseEntity.toJson();
      final restored = MonthlySavingEntity.fromJson(json);
      expect(restored, baseEntity);
    });
  });
}
