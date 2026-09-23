import '../../core.dart';

part 'expense_category.g.dart';

@HiveType(typeId: HiveTypeIds.expenseCategory)
enum ExpenseCategory {
  @HiveField(0)
  food,

  @HiveField(1)
  groceries,

  @HiveField(2)
  transport,

  @HiveField(3)
  shopping,

  @HiveField(4)
  healthFitness,

  @HiveField(5)
  entertainment,

  @HiveField(6)
  bills,

  @HiveField(7)
  rentHousing,

  @HiveField(8)
  travel,

  @HiveField(9)
  education,

  @HiveField(10)
  gifts,

  @HiveField(11)
  personalCare,

  @HiveField(12)
  subscriptions,

  @HiveField(13)
  work,

  @HiveField(14)
  pets,

  @HiveField(15)
  investments,

  @HiveField(16)
  household,

  @HiveField(17)
  other;

  String get label {
    return switch (this) {
      ExpenseCategory.food => 'Food',
      ExpenseCategory.groceries => 'Groceries',
      ExpenseCategory.transport => 'Transport',
      ExpenseCategory.shopping => 'Shopping',
      ExpenseCategory.healthFitness => 'Health & Fitness',
      ExpenseCategory.entertainment => 'Entertainment',
      ExpenseCategory.bills => 'Bills',
      ExpenseCategory.rentHousing => 'Rent & Housing',
      ExpenseCategory.travel => 'Travel',
      ExpenseCategory.education => 'Education',
      ExpenseCategory.gifts => 'Gifts',
      ExpenseCategory.personalCare => 'Personal Care',
      ExpenseCategory.subscriptions => 'Subscriptions',
      ExpenseCategory.work => 'Work',
      ExpenseCategory.pets => 'Pets',
      ExpenseCategory.investments => 'Investments',
      ExpenseCategory.household => 'Household',
      ExpenseCategory.other => 'Other',
    };
  }

  IconData get icon {
    return switch (this) {
      ExpenseCategory.food => Icons.restaurant_rounded,
      ExpenseCategory.groceries => Icons.shopping_cart_rounded,
      ExpenseCategory.transport => Icons.directions_car_rounded,
      ExpenseCategory.shopping => Icons.shopping_bag_rounded,
      ExpenseCategory.healthFitness => Icons.favorite_rounded,
      ExpenseCategory.entertainment => Icons.movie_rounded,
      ExpenseCategory.bills => Icons.receipt_rounded,
      ExpenseCategory.rentHousing => Icons.home_rounded,
      ExpenseCategory.travel => Icons.flight_rounded,
      ExpenseCategory.education => Icons.school_rounded,
      ExpenseCategory.gifts => Icons.card_giftcard_rounded,
      ExpenseCategory.personalCare => Icons.face_rounded,
      ExpenseCategory.subscriptions => Icons.subscriptions_rounded,
      ExpenseCategory.work => Icons.work_rounded,
      ExpenseCategory.pets => Icons.pets_rounded,
      ExpenseCategory.investments => Icons.trending_up_rounded,
      ExpenseCategory.household => Icons.cleaning_services_rounded,
      ExpenseCategory.other => Icons.more_horiz_rounded,
    };
  }

  Color get color {
    return switch (this) {
      ExpenseCategory.food => Colors.red.shade400,
      ExpenseCategory.groceries => Colors.green.shade400,
      ExpenseCategory.transport => Colors.blue.shade400,
      ExpenseCategory.shopping => Colors.purple.shade400,
      ExpenseCategory.healthFitness => Colors.pink.shade400,
      ExpenseCategory.entertainment => Colors.indigo.shade400,
      ExpenseCategory.bills => Colors.orange.shade400,
      ExpenseCategory.rentHousing => Colors.brown.shade400,
      ExpenseCategory.travel => Colors.teal.shade400,
      ExpenseCategory.education => Colors.amber.shade700,
      ExpenseCategory.gifts => Colors.cyan.shade400,
      ExpenseCategory.personalCare => Colors.lightBlue.shade400,
      ExpenseCategory.subscriptions => Colors.deepPurple.shade400,
      ExpenseCategory.work => Colors.blueGrey.shade400,
      ExpenseCategory.pets => Colors.deepOrange.shade400,
      ExpenseCategory.investments => Colors.lightGreen.shade600,
      ExpenseCategory.household => Colors.yellow.shade700,
      ExpenseCategory.other => Colors.grey.shade400,
    };
  }
}
