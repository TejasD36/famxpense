import 'package:get_it/get_it.dart';

import '../../app/theme/theme_cubit.dart';
import '../../features/auth/domain/usecases/check_auth_status_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// CUBIT

  sl.registerFactory(() => ThemeCubit());

  /// DATA SOURCES
  // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  /// REPOSITORIES
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// AUTH USECASES
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  /// NOTES USECASES

  /// BLOCS
  sl.registerFactory(() => AuthBloc(checkAuthStatusUseCase: sl(), loginUseCase: sl(), logoutUseCase: sl()));
}
