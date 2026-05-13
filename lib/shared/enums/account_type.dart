import '../../core.dart';

part 'account_type.g.dart';

@HiveType(typeId: HiveTypeIds.accountType)
enum AccountType {
  @HiveField(0)
  bank,
  @HiveField(1)
  cash,
  @HiveField(2)
  creditCard,
  @HiveField(3)
  wallet,
}
