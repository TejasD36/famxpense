import '../../core.dart';

part 'expense_type.g.dart';

@HiveType(typeId: HiveTypeIds.expenseType)
enum ExpenseType {
  @HiveField(0)
  personal,

  @HiveField(1)
  shared,

  @HiveField(2)
  group,
}
