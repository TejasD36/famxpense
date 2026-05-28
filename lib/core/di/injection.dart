import 'package:famxpense/shared/data/datasources/remote/user_remote_datasource.dart';

import '../../core.dart';
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
import '../../features/partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../features/partners/data/datasources/remote/partnership_remote_datasource_impl.dart';
import '../../features/partners/data/repositories/partnership_repository_impl.dart';
import '../../features/partners/domain/repositories/partnership_repository.dart';
import '../../features/partners/domain/usecases/get_partnerships_usecase.dart';
import '../../features/partners/domain/usecases/search_user_usecase.dart';
import '../../features/partners/domain/usecases/send_partnership_request_usecase.dart';
import '../../features/partners/presentation/blocs/partner_bloc.dart';
import '../../shared/data/datasources/local/user_local_datasource.dart';
import '../../shared/data/datasources/local/user_local_datasource_impl.dart';
import '../../shared/data/datasources/remote/user_remote_datasource_impl.dart';
import '../../shared/data/repositories/user_repository_impl.dart';
import '../../shared/domain/repositories/user_repository.dart';
import '../services/sync/sync_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// EXTERNAL

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  /// CUBITS

  sl.registerFactory(() => ThemeCubit());

  /// DATASOURCES

  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl());
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(firebaseAuth: sl(), firestore: sl()));

  sl.registerLazySingleton<ExpenseLocalDatasource>(() => ExpenseLocalDatasourceImpl());

  /// REPOSITORIES

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDatasource: sl(), localDatasource: sl()));
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(localDatasource: sl(), authLocalDatasource: sl(), remoteDatasource: sl()),
  );
  sl.registerLazySingleton<PartnershipRepository>(() => PartnershipRepositoryImpl(remoteDatasource: sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDatasource: sl()));

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

  sl.registerFactory(
    () =>
        AuthBloc(registerUsecase: sl(), loginUsecase: sl(), logoutUsecase: sl(), forgotPasswordUsecase: sl(), getCurrentUserUsecase: sl()),
  );

  sl.registerFactory(() => AddExpenseBloc(addExpenseUsecase: sl()));
  sl.registerFactory(() => ActivityBloc(getExpensesUsecase: sl()));
  sl.registerFactory(() => HomeBloc(getExpensesUsecase: sl()));
  sl.registerFactory(
    () => PartnerBloc(
      searchUserUsecase: sl(),
      sendRequestUsecase: sl(),
      getPartnershipsUsecase: sl(),
      authLocalDatasource: sl(),
      userLocalDatasource: sl(),
    ),
  );

  /// LOCAL DATASOURCE

  sl.registerLazySingleton<UserLocalDatasource>(() => UserLocalDatasourceImpl());

  /// REMOTE DATASOURCE

  sl.registerLazySingleton<ExpenseRemoteDatasource>(() => ExpenseRemoteDatasourceImpl(firestore: sl()));
  sl.registerLazySingleton<PartnershipRemoteDatasource>(() => PartnershipRemoteDatasourceImpl(firestore: sl()));
  sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasourceImpl(firestore: sl()));

  /// Services
  sl.registerLazySingleton(() => SyncService(localDatasource: sl(), remoteDatasource: sl()));
}
