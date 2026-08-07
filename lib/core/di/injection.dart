import '../../core.dart';
import '../../features/account/data/datasources/account_local_datasource.dart';
import '../../features/account/data/datasources/account_local_datasource_impl.dart';
import '../../features/account/data/datasources/manual_deposit_local_datasource.dart';
import '../../features/account/data/datasources/manual_deposit_local_datasource_impl.dart';
import '../../features/account/data/datasources/remote/account_remote_datasource.dart';
import '../../features/account/data/datasources/remote/account_remote_datasource_impl.dart';
import '../../features/account/data/repositories/account_repository_impl.dart';
import '../../features/account/domain/repositories/account_repository.dart';
import '../../features/account/domain/usecases/delete_account_usecase.dart';
import '../../features/account/domain/usecases/get_accounts_usecase.dart';
import '../../features/account/domain/usecases/save_account_usecase.dart';
import '../../features/account/presentation/blocs/account_bloc.dart';
import '../../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../../features/auth/data/datasources/local/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../features/debt_ledger/data/datasources/debt_ledger_local_datasource_impl.dart';
import '../../features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource.dart';
import '../../features/debt_ledger/data/datasources/remote/debt_ledger_remote_datasource_impl.dart';
import '../../features/debt_ledger/data/repositories/debt_ledger_repository_impl.dart';
import '../../features/debt_ledger/domain/repositories/debt_ledger_repository.dart';
import '../../features/debt_ledger/domain/usecases/compute_debt_usecase.dart';
import '../../features/debt_ledger/domain/usecases/get_debts_usecase.dart';
import '../../features/settlement/data/datasources/remote/settlement_remote_datasource.dart';
import '../../features/settlement/data/datasources/remote/settlement_remote_datasource_impl.dart';
import '../../features/settlement/data/datasources/settlement_local_datasource.dart';
import '../../features/settlement/data/datasources/settlement_local_datasource_impl.dart';
import '../../features/settlement/data/repositories/settlement_repository_impl.dart';
import '../../features/settlement/domain/repositories/settlement_repository.dart';
import '../../features/settlement/domain/usecases/process_settlement_usecase.dart';
import '../../features/settlement/domain/usecases/settle_debt_usecase.dart';
import '../../features/expenses/data/datasources/local/expense_local_datasource.dart';
import '../../features/expenses/data/datasources/local/expense_local_datasource_impl.dart';
import '../../features/expenses/data/datasources/remote/expense_remote_datasource.dart';
import '../../features/expenses/data/datasources/remote/expense_remote_datasource_impl.dart';
import '../../features/expenses/data/repositories/expense_repository_impl.dart';
import '../../features/expenses/domain/repositories/expense_repository.dart';
import '../../features/expenses/domain/usecases/add_expense_usecase.dart';
import '../../features/expenses/domain/usecases/get_current_month_expenses_usecase.dart';
import '../../features/expenses/presentation/blocs/activity/activity_bloc.dart';
import '../../features/expenses/presentation/blocs/add_expense/add_expense_bloc.dart';
import '../../features/expenses/presentation/blocs/home/home_bloc.dart';
import '../../features/notification/data/datasources/notification_local_datasource.dart';
import '../../features/notification/data/datasources/notification_local_datasource_impl.dart';
import '../../features/notification/data/datasources/remote/notification_remote_datasource.dart';
import '../../features/notification/data/datasources/remote/notification_remote_datasource_impl.dart';
import '../../features/notification/presentation/blocs/notification_bloc.dart';
import '../../features/partners/data/datasources/local/partnership_local_datasource.dart';
import '../../features/partners/data/datasources/local/partnership_local_datasource_impl.dart';
import '../../features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../features/partners/data/datasources/remote/partnership_remote_datasource_impl.dart';
import '../../features/partners/data/repositories/partnership_repository_impl.dart';
import '../../features/partners/domain/repositories/partnership_repository.dart';
import '../../features/partners/domain/usecases/get_partnerships_usecase.dart';
import '../../features/partners/domain/usecases/search_user_usecase.dart';
import '../../features/partners/domain/usecases/send_partnership_request_usecase.dart';
import '../../features/partners/presentation/blocs/partner_bloc.dart';
import '../../features/statistics/presentation/blocs/statistics_bloc.dart';
import '../../features/income/data/datasources/income_local_datasource.dart';
import '../../features/income/data/datasources/income_local_datasource_impl.dart';
import '../../features/income/data/datasources/remote/income_remote_datasource.dart';
import '../../features/income/data/datasources/remote/income_remote_datasource_impl.dart';
import '../../features/income/data/repositories/income_repository_impl.dart';
import '../../features/income/domain/repositories/income_repository.dart';
import '../../features/savings/data/datasources/savings_local_datasource.dart';
import '../../features/savings/data/datasources/savings_local_datasource_impl.dart';
import '../../features/savings/data/datasources/transfer_local_datasource.dart';
import '../../features/savings/data/datasources/transfer_local_datasource_impl.dart';
import '../../features/savings/data/datasources/remote/monthly_saving_remote_datasource.dart';
import '../../features/savings/data/datasources/remote/monthly_saving_remote_datasource_impl.dart';
import '../../features/savings/data/datasources/remote/transfer_remote_datasource.dart';
import '../../features/savings/data/datasources/remote/transfer_remote_datasource_impl.dart';
import '../../features/savings/data/repositories/savings_repository_impl.dart';
import '../../features/savings/data/repositories/transfer_repository_impl.dart';
import '../../features/savings/domain/repositories/savings_repository.dart';
import '../../features/savings/domain/repositories/transfer_repository.dart';
import '../../shared/data/datasources/local/user_local_datasource_impl.dart';
import '../../shared/data/datasources/remote/user_remote_datasource_impl.dart';
import '../../shared/data/repositories/user_repository_impl.dart';
import '../../shared/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// EXTERNAL

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  /// CUBITS

  sl.registerFactory(() => ThemeCubit());

  /// DATASOURCES

  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  sl.registerLazySingleton<ExpenseLocalDatasource>(
    () => ExpenseLocalDatasourceImpl(),
  );

  /// REPOSITORIES

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
      userLocalDatasource: sl(),
      syncService: sl(),
    ),
  );
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(
      localDatasource: sl(),
      authLocalDatasource: sl(),
      remoteDatasource: sl(),
      computeDebtUsecase: sl(),
      accountRepository: sl(),
    ),
  );
  sl.registerLazySingleton<PartnershipLocalDatasource>(
    () => PartnershipLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<PartnershipRepository>(
    () => PartnershipRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDatasource: sl()),
  );

  /// USECASES

  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));

  sl.registerLazySingleton(() => AddExpenseUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentMonthExpensesUsecase(sl()));
  sl.registerLazySingleton(() => SendPartnershipRequestUsecase(sl()));

  sl.registerLazySingleton(() => GetPartnershipsUsecase(sl()));

  sl.registerLazySingleton(() => SearchUserUsecase(sl()));

  /// BLOCS

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      registerUsecase: sl(),
      loginUsecase: sl(),
      logoutUsecase: sl(),
      forgotPasswordUsecase: sl(),
      getCurrentUserUsecase: sl(),
    ),
  );

  sl.registerFactory(() => AddExpenseBloc(addExpenseUsecase: sl()));
  sl.registerFactory(
    () => ActivityBloc(expenseRepository: sl(), settlementLocal: sl()),
  );
  sl.registerFactory(
    () => HomeBloc(
      getExpensesUsecase: sl(),
      getDebtsUsecase: sl(),
      settlementLocal: sl(),
    ),
  );
  sl.registerFactory(
    () => PartnerBloc(
      searchUserUsecase: sl(),
      sendRequestUsecase: sl(),
      getPartnershipsUsecase: sl(),
      partnershipRepository: sl(),
      authLocalDatasource: sl(),
      userLocalDatasource: sl(),
    ),
  );

  sl.registerFactory(() => StatisticsBloc());

  /// LOCAL DATASOURCE

  sl.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasourceImpl(),
  );

  /// REMOTE DATASOURCE

  sl.registerLazySingleton<ExpenseRemoteDatasource>(
    () => ExpenseRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<PartnershipRemoteDatasource>(
    () => PartnershipRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<AccountRemoteDatasource>(
    () => AccountRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<DebtLedgerRemoteDatasource>(
    () => DebtLedgerRemoteDatasourceImpl(firestore: sl()),
  );

  /// Services
  sl.registerLazySingleton(
    () => SyncService(
      expenseLocal: sl(),
      expenseRemote: sl(),
      accountLocal: sl(),
      accountRemote: sl(),
      manualDepositLocal: sl(),
      debtLedgerLocal: sl(),
      debtLedgerRemote: sl(),
      settlementLocal: sl(),
      settlementRemote: sl(),
      userLocal: sl(),
      userRemote: sl(),
      partnershipRemote: sl(),
      incomeLocal: sl(),
      incomeRemote: sl(),
      notificationLocal: sl(),
      notificationRemote: sl(),
      transferLocal: sl(),
      transferRemote: sl(),
      monthlySavingLocal: sl(),
      monthlySavingRemote: sl(),
      savingsRepository: sl(),
    ),
  );
  sl.registerLazySingleton(() => RefreshNotifier());
  sl.registerLazySingleton(() => ConnectivityService());
  sl.registerLazySingleton(() => LocationService());

  /// ACCOUNT
  sl.registerLazySingleton<AccountLocalDatasource>(
    () => AccountLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<ManualDepositLocalDatasource>(
    () => ManualDepositLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(localDatasource: sl(), remoteDatasource: sl()),
  );
  sl.registerLazySingleton(() => GetAccountsUsecase(repository: sl()));
  sl.registerLazySingleton(() => SaveAccountUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUsecase(repository: sl()));
  sl.registerFactory(
    () => AccountBloc(
      getAccountsUsecase: sl(),
      saveAccountUsecase: sl(),
      deleteAccountUsecase: sl(),
      authLocalDatasource: sl(),
    ),
  );

  /// DEBT LEDGER
  sl.registerLazySingleton<DebtLedgerLocalDatasource>(
    () => DebtLedgerLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<DebtLedgerRepository>(
    () =>
        DebtLedgerRepositoryImpl(localDatasource: sl(), remoteDatasource: sl()),
  );
  sl.registerLazySingleton(() => ComputeDebtUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetDebtsUsecase(repository: sl()));

  /// SETTLEMENT
  sl.registerLazySingleton<SettlementLocalDatasource>(
    () => SettlementLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<SettlementRemoteDatasource>(
    () => SettlementRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<SettlementRepository>(
    () =>
        SettlementRepositoryImpl(localDatasource: sl(), remoteDatasource: sl()),
  );
  sl.registerLazySingleton(
    () =>
        SettleDebtUsecase(settlementRepository: sl(), accountRepository: sl()),
  );
  sl.registerLazySingleton(
    () => ProcessSettlementUsecase(
      settlementRepository: sl(),
      debtLedgerRepository: sl(),
      accountRepository: sl(),
    ),
  );

  /// NOTIFICATIONS
  sl.registerLazySingleton<NotificationLocalDatasource>(
    () => NotificationLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton(() => NotificationService(sl(), sl()));
  sl.registerLazySingleton(() => RealtimeNotificationService(sl(), sl()));
  sl.registerFactory(() => NotificationBloc(datasource: sl()));

  /// INCOME
  sl.registerLazySingleton<IncomeLocalDatasource>(
    () => IncomeLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<IncomeRemoteDatasource>(
    () => IncomeRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<IncomeRepository>(
    () => IncomeRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
      accountRepository: sl(),
      authLocalDatasource: sl(),
      savingsRepository: sl(),
      refreshNotifier: sl(),
    ),
  );

  /// SAVINGS
  sl.registerLazySingleton<TransferLocalDatasource>(
    () => TransferLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<TransferRemoteDatasource>(
    () => TransferRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(
      local: sl(),
      remote: sl(),
      accountRepository: sl(),
      savingsRepository: sl(),
      refreshNotifier: sl(),
    ),
  );
  sl.registerLazySingleton<SavingsLocalDatasource>(
    () => SavingsLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<MonthlySavingRemoteDatasource>(
    () => MonthlySavingRemoteDatasourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<SavingsRepository>(
    () => SavingsRepositoryImpl(
      local: sl(),
      accountLocal: sl(),
      remote: sl(),
      refreshNotifier: sl(),
    ),
  );
}
