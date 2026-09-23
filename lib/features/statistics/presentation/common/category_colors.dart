import 'package:flutter/material.dart';
import '../../../../shared/enums/expense_category.dart';

Color categoryColor(String category, bool isDark) {
  final cat = ExpenseCategory.values
      .where((e) => e.name == category)
      .firstOrNull;
  return cat?.color ?? (isDark ? Colors.grey.shade500 : Colors.grey.shade600);
}

String categoryLabel(String category) {
  final cat = ExpenseCategory.values
      .where((e) => e.name == category)
      .firstOrNull;
  return cat?.label ?? category;
}
