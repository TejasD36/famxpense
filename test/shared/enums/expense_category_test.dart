import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/shared/enums/expense_category.dart';

void main() {
  group('ExpenseCategory', () {
    test('has 18 values', () {
      expect(ExpenseCategory.values.length, 18);
    });

    test('every value has non-empty label', () {
      for (final category in ExpenseCategory.values) {
        expect(category.label.isNotEmpty, isTrue,
            reason: '${category.name} should have a non-empty label');
      }
    });

    test('food label is Food', () {
      expect(ExpenseCategory.food.label, 'Food');
    });

    test('healthFitness label is Health & Fitness', () {
      expect(ExpenseCategory.healthFitness.label, 'Health & Fitness');
    });

    test('rentHousing label is Rent & Housing', () {
      expect(ExpenseCategory.rentHousing.label, 'Rent & Housing');
    });

    test('personalCare label is Personal Care', () {
      expect(ExpenseCategory.personalCare.label, 'Personal Care');
    });

    test('other label is Other', () {
      expect(ExpenseCategory.other.label, 'Other');
    });

    test('every value has non-empty icon', () {
      for (final category in ExpenseCategory.values) {
        expect(category.icon, isNotNull,
            reason: '${category.name} should have an icon');
      }
    });

    test('every value has non-null color', () {
      for (final category in ExpenseCategory.values) {
        expect(category.color, isNotNull,
            reason: '${category.name} should have a color');
      }
    });

    test('other.name matches hardcoded usage', () {
      expect(ExpenseCategory.other.name, 'other');
    });

    test('no duplicate labels', () {
      final labels = ExpenseCategory.values.map((c) => c.label).toList();
      expect(labels.toSet().length, labels.length,
          reason: 'All labels must be unique');
    });
  });
}
