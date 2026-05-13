import '../../core.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/expenses/data/datasources/expense_local_datasource.dart';
import '../../features/expenses/data/datasources/expense_local_datasource_impl.dart';
import '../../features/expenses/data/repositories/expense_repository_impl.dart';
import '../../features/expenses/domain/repositories/expense_repository.dart';
import '../../features/expenses/domain/usecases/add_expense_usecase.dart';
import '../../features/expenses/presentation/blocs/add_expense_bloc.dart';

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

  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(localDatasource: sl()));

  /// USECASES

  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));

  sl.registerLazySingleton(() => AddExpenseUsecase(sl()));

  /// BLOCS

  sl.registerFactory(
    () =>
        AuthBloc(registerUsecase: sl(), loginUsecase: sl(), logoutUsecase: sl(), forgotPasswordUsecase: sl(), getCurrentUserUsecase: sl()),
  );

  sl.registerFactory(() => AddExpenseBloc(addExpenseUsecase: sl()));
}
