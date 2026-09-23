import 'package:intl/intl.dart';

String formatRelativeCalendarDate(DateTime date, {DateTime? now}) {
  final localDate = date.toLocal();
  final localNow = (now ?? DateTime.now()).toLocal();
  final dateOnly = DateTime(localDate.year, localDate.month, localDate.day);
  final today = DateTime(localNow.year, localNow.month, localNow.day);
  final dayDifference = today.difference(dateOnly).inDays;

  if (dayDifference == 0) return 'Today';
  if (dayDifference == 1) return 'Yesterday';
  return DateFormat('d MMM').format(localDate);
}
