import 'package:flutter/material.dart';
import '../../../../shared/enums/expense_category.dart';

Color categoryColor(String category, bool isDark) {
  return switch (ExpenseCategory.values.where((e) => e.name == category).firstOrNull) {
    ExpenseCategory.food => Colors.red.shade400,
    ExpenseCategory.grocery => Colors.green.shade400,
    ExpenseCategory.clothes => Colors.purple.shade400,
    ExpenseCategory.essentials => Colors.teal.shade400,
    ExpenseCategory.medical => Colors.pink.shade400,
    ExpenseCategory.snacks => Colors.orange.shade400,
    ExpenseCategory.lunch => Colors.amber.shade600,
    ExpenseCategory.dinner => Colors.deepOrange.shade400,
    ExpenseCategory.movie => Colors.indigo.shade400,
    ExpenseCategory.traveling => Colors.blue.shade400,
    ExpenseCategory.gifts => Colors.cyan.shade400,
    ExpenseCategory.insurance => Colors.brown.shade400,
    ExpenseCategory.emi => Colors.blueGrey.shade400,
    ExpenseCategory.recharge => Colors.lightGreen.shade600,
    ExpenseCategory.electricity => Colors.yellow.shade700,
    ExpenseCategory.mobileBill => Colors.lime.shade600,
    ExpenseCategory.subscription => Colors.deepPurple.shade400,
    ExpenseCategory.fruits => Colors.lime.shade400,
    ExpenseCategory.other => isDark ? Colors.grey.shade500 : Colors.grey.shade600,
    null => isDark ? Colors.grey.shade500 : Colors.grey.shade600,
  };
}

String categoryLabel(String category) {
  return switch (ExpenseCategory.values.where((e) => e.name == category).firstOrNull) {
    ExpenseCategory.food => 'Food',
    ExpenseCategory.grocery => 'Grocery',
    ExpenseCategory.clothes => 'Clothes',
    ExpenseCategory.essentials => 'Essentials',
    ExpenseCategory.medical => 'Medical',
    ExpenseCategory.snacks => 'Snacks',
    ExpenseCategory.lunch => 'Lunch',
    ExpenseCategory.dinner => 'Dinner',
    ExpenseCategory.movie => 'Movie',
    ExpenseCategory.traveling => 'Traveling',
    ExpenseCategory.gifts => 'Gifts',
    ExpenseCategory.insurance => 'Insurance',
    ExpenseCategory.emi => 'EMI',
    ExpenseCategory.recharge => 'Recharge',
    ExpenseCategory.electricity => 'Electricity',
    ExpenseCategory.mobileBill => 'Mobile Bill',
    ExpenseCategory.subscription => 'Subscription',
    ExpenseCategory.fruits => 'Fruits',
    ExpenseCategory.other => 'Other',
    null => category,
  };
}
