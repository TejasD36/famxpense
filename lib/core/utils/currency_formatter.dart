import 'package:intl/intl.dart';

String formatIndianRupee(double amount) {
  final absAmount = amount.abs();
  final formatter = NumberFormat('#,##,##0', 'en_IN');
  final formatted = formatter.format(absAmount);
  if (amount < 0) return '-₹$formatted';
  return '₹$formatted';
}

String formatIndianRupeeSigned(double amount) {
  if (amount >= 0) return '+${formatIndianRupee(amount)}';
  return formatIndianRupee(amount);
}
