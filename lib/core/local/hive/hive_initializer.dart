import '../../../core.dart';

abstract final class HiveInitializer {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    _registerAdapters();

    await _openBoxes();
  }

  static void _registerAdapters() {
    Hive
      ..registerAdapter(UserDtoAdapter())
      ..registerAdapter(AccountDtoAdapter())
      ..registerAdapter(ExpenseParticipantDtoAdapter())
      ..registerAdapter(ExpenseDtoAdapter())
      ..registerAdapter(GroupDtoAdapter())
      ..registerAdapter(SettlementDtoAdapter())
      ..registerAdapter(PartnershipDtoAdapter())
      ..registerAdapter(DebtLedgerDtoAdapter())
      ..registerAdapter(NotificationDtoAdapter())
      ..registerAdapter(ExpenseTypeAdapter())
      ..registerAdapter(SplitTypeAdapter())
      ..registerAdapter(SyncStatusAdapter())
      ..registerAdapter(AccountTypeAdapter())
      ..registerAdapter(SettlementStatusAdapter())
      ..registerAdapter(PartnershipStatusAdapter())
      ..registerAdapter(NotificationTypeAdapter())
      ..registerAdapter(DraftExpenseDtoAdapter())
      ..registerAdapter(ManualDepositDtoAdapter())
      ..registerAdapter(ExpenseCategoryAdapter());
  }

  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox<UserDto>(HiveBoxes.users),

      Hive.openBox<ExpenseDto>(HiveBoxes.expenses),

      Hive.openBox<AccountDto>(HiveBoxes.accounts),

      Hive.openBox<GroupDto>(HiveBoxes.groups),

      Hive.openBox<SettlementDto>(HiveBoxes.settlements),

      Hive.openBox<PartnershipDto>(HiveBoxes.partnerships),

      Hive.openBox<DebtLedgerDto>(HiveBoxes.debtLedger),

      Hive.openBox<NotificationDto>(HiveBoxes.notifications),

      Hive.openBox(HiveBoxes.auth),

      Hive.openBox<DraftExpenseDto>(HiveBoxes.draftExpenses),

      Hive.openBox(HiveBoxes.settings),

      Hive.openBox<ManualDepositDto>(HiveBoxes.manualDeposits),
    ]);
  }
}
