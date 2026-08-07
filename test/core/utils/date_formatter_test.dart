import 'package:famxpense/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatRelativeCalendarDate', () {
    test('uses calendar days instead of elapsed 24-hour periods', () {
      final now = DateTime(2026, 8, 1, 9);
      final yesterdayEvening = DateTime(2026, 7, 31, 22);

      expect(
        formatRelativeCalendarDate(yesterdayEvening, now: now),
        'Yesterday',
      );
    });

    test('labels a date on the same local calendar day as today', () {
      final now = DateTime(2026, 8, 1, 23);
      final thisMorning = DateTime(2026, 8, 1, 1);

      expect(formatRelativeCalendarDate(thisMorning, now: now), 'Today');
    });
  });
}
