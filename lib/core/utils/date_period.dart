DateTime localDateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

bool isInInclusiveRange(DateTime value, DateTime start, DateTime end) {
  final date = localDateOnly(value);
  return !date.isBefore(localDateOnly(start)) &&
      !date.isAfter(localDateOnly(end));
}

bool isInLocalMonth(DateTime value, DateTime month) {
  final local = value.toLocal();
  final target = month.toLocal();
  return local.year == target.year && local.month == target.month;
}

DateTime periodEndExclusive(DateTime end) =>
    DateTime(end.toLocal().year, end.toLocal().month, end.toLocal().day + 1);
