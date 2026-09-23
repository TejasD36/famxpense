import 'package:famxpense/features/expenses/domain/services/expense_split_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseSplitCalculator.equal', () {
    test('keeps whole rupees and assigns the remainder to the payer', () {
      final result = ExpenseSplitCalculator.equal(
        totalAmount: 100,
        participantIds: ['payer', 'partner-a', 'partner-b'],
      );

      expect(result, {'payer': 34.0, 'partner-a': 33.0, 'partner-b': 33.0});
      expect(result.values.reduce((a, b) => a + b), closeTo(100, 0.0001));
    });

    test('rejects fractional rupee totals', () {
      expect(
        () => ExpenseSplitCalculator.equal(
          totalAmount: 0.05,
          participantIds: ['payer', 'partner'],
        ),
        throwsArgumentError,
      );
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
