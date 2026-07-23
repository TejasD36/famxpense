import '../../../core.dart';
import '../../../hive_registrar.g.dart';

abstract final class HiveInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    _registerAdapters();

    await _openBoxes();
  }

  static void _registerAdapters() {
    Hive.registerAdapters();
  }

  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox<UserDto>(HiveBoxes.users),

      Hive.openBox<ExpenseDto>(HiveBoxes.expenses),

      Hive.openBox<AccountDto>(HiveBoxes.accounts),

      Hive.openBox<SettlementDto>(HiveBoxes.settlements),

      Hive.openBox<PartnershipDto>(HiveBoxes.partnerships),

      Hive.openBox<DebtLedgerDto>(HiveBoxes.debtLedger),

      Hive.openBox<NotificationDto>(HiveBoxes.notifications),

      Hive.openBox(HiveBoxes.auth),

      Hive.openBox(HiveBoxes.settings),

      Hive.openBox<ManualDepositDto>(HiveBoxes.manualDeposits),

      Hive.openBox<IncomeDto>(HiveBoxes.incomes),
    ]);
  }
}
