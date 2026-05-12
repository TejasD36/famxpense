import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../app/theme/theme_cubit.dart';
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

  /// REPOSITORIES

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDatasource: sl(), localDatasource: sl()));

  /// USECASES

  sl.registerLazySingleton(() => RegisterUsecase(sl()));

  sl.registerLazySingleton(() => LoginUsecase(sl()));

  sl.registerLazySingleton(() => LogoutUsecase(sl()));

  sl.registerLazySingleton(() => ForgotPasswordUsecase(sl()));

  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));

  /// BLOCS

  sl.registerFactory(
    () =>
        AuthBloc(registerUsecase: sl(), loginUsecase: sl(), logoutUsecase: sl(), forgotPasswordUsecase: sl(), getCurrentUserUsecase: sl()),
  );
}
