import 'package:flutter_test/flutter_test.dart';
import 'package:famxpense/core/utils/currency_formatter.dart';

void main() {
  group('formatIndianRupee', () {
    test('formats zero', () {
      expect(formatIndianRupee(0), '₹0');
    });

    test('formats positive whole number', () {
      expect(formatIndianRupee(100), '₹100');
    });

    test('formats positive thousands', () {
      expect(formatIndianRupee(1500), '₹1,500');
    });

    test('formats positive lakhs', () {
      expect(formatIndianRupee(100000), '₹1,00,000');
    });

    test('formats negative number', () {
      expect(formatIndianRupee(-500), '-₹500');
    });

    test('formats negative lakhs', () {
      expect(formatIndianRupee(-250000), '-₹2,50,000');
    });

    test('formats with paise rounded', () {
      expect(formatIndianRupee(99.9), '₹100');
    });

    test('formats large crores', () {
      expect(formatIndianRupee(12345678), '₹1,23,45,678');
    });
  });

  group('formatIndianRupeeSigned', () {
    test('adds plus for positive', () {
      expect(formatIndianRupeeSigned(500), '+₹500');
    });

    test('keeps minus for negative', () {
      expect(formatIndianRupeeSigned(-300), '-₹300');
    });

    test('zero shows +₹0', () {
      expect(formatIndianRupeeSigned(0), '+₹0');
    });
  });
}
