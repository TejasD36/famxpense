import 'package:famxpense/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('matches a month using the local calendar date', () {
    final month = DateTime(2025, 2, 1);
    expect(isInLocalMonth(DateTime.utc(2025, 2, 28, 10, 00), month), isTrue);
    expect(isInLocalMonth(DateTime(2025, 3, 1), month), isFalse);
  });

  test('inclusive ranges include both local boundary days', () {
    final start = DateTime(2025, 12, 31);
    final end = DateTime(2026, 1, 1);
    expect(
      isInInclusiveRange(DateTime.utc(2025, 12, 31, 17, 59), start, end),
      isTrue,
    );
    expect(
      isInInclusiveRange(DateTime.utc(2026, 1, 1, 17, 59), start, end),
      isTrue,
    );
    expect(isInInclusiveRange(DateTime(2026, 1, 2), start, end), isFalse);
  });

  test('period end is the next local midnight', () {
    expect(periodEndExclusive(DateTime(2025, 2, 28)), DateTime(2025, 3, 1));
  });
}
