import 'package:famxpense/features/expenses/domain/services/expense_split_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseSplitCalculator.equal', () {
    test('preserves every paise when the amount is not evenly divisible', () {
      final result = ExpenseSplitCalculator.equal(
        totalAmount: 100,
        participantIds: ['payer', 'partner-a', 'partner-b'],
      );

      expect(result, {'payer': 33.34, 'partner-a': 33.33, 'partner-b': 33.33});
      expect(result.values.reduce((a, b) => a + b), closeTo(100, 0.0001));
    });

    test('supports sub-rupee totals without losing value', () {
      final result = ExpenseSplitCalculator.equal(
        totalAmount: 0.05,
        participantIds: ['payer', 'partner'],
      );

      expect(result, {'payer': 0.03, 'partner': 0.02});
    });

    test('rejects duplicate participants', () {
      expect(
        () => ExpenseSplitCalculator.equal(
          totalAmount: 10,
          participantIds: ['user-a', 'user-a'],
        ),
        throwsArgumentError,
      );
    });
  });
}
