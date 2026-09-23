import '../../core.dart';

part 'income_source.g.dart';

@HiveType(typeId: HiveTypeIds.incomeSource)
enum IncomeSource {
  @HiveField(0)
  salary,

  @HiveField(1)
  freelance,

  @HiveField(2)
  investment,

  @HiveField(3)
  business,

  @HiveField(4)
  rental,

  @HiveField(5)
  gift,

  @HiveField(6)
  refund,

  @HiveField(7)
  other;

  String get label {
    return switch (this) {
      IncomeSource.salary => 'Salary',
      IncomeSource.freelance => 'Freelance',
      IncomeSource.investment => 'Investment',
      IncomeSource.business => 'Business',
      IncomeSource.rental => 'Rental',
      IncomeSource.gift => 'Gift',
      IncomeSource.refund => 'Refund',
      IncomeSource.other => 'Other',
    };
  }

  IconData get icon {
    return switch (this) {
      IncomeSource.salary => Icons.badge_rounded,
      IncomeSource.freelance => Icons.laptop_rounded,
      IncomeSource.investment => Icons.trending_up_rounded,
      IncomeSource.business => Icons.business_rounded,
      IncomeSource.rental => Icons.home_work_rounded,
      IncomeSource.gift => Icons.card_giftcard_rounded,
      IncomeSource.refund => Icons.keyboard_return_rounded,
      IncomeSource.other => Icons.more_horiz_rounded,
    };
  }
}
