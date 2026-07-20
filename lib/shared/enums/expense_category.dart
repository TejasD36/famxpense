import '../../core.dart';

part 'expense_category.g.dart';

@HiveType(typeId: HiveTypeIds.expenseCategory)
enum ExpenseCategory {
  @HiveField(0)
  food,

  @HiveField(1)
  grocery,

  @HiveField(2)
  clothes,

  @HiveField(3)
  essentials,

  @HiveField(4)
  medical,

  @HiveField(5)
  snacks,

  @HiveField(6)
  lunch,

  @HiveField(7)
  dinner,

  @HiveField(8)
  movie,

  @HiveField(9)
  traveling,

  @HiveField(10)
  gifts,

  @HiveField(11)
  insurance,

  @HiveField(12)
  emi,

  @HiveField(13)
  recharge,

  @HiveField(14)
  electricity,

  @HiveField(15)
  mobileBill,

  @HiveField(16)
  subscription,

  @HiveField(17)
  other,

  @HiveField(18)
  fruits,
}
