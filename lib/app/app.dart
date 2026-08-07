import 'dart:async';

import '../core.dart';
import '../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../flavors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;
  bool _initialized = false;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<ThemeCubit>().loadTheme();
      _initApp();
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initApp() async {
    if (_initialized) return;
    _initialized = true;

    final authBloc = sl<AuthBloc>();
    authBloc.add(const AuthEvent.checkAuthStatus());

    await authBloc.stream
        .firstWhere(
          (state) => state.maybeWhen(
            authenticated: (_) => true,
            unauthenticated: () => true,
            orElse: () => false,
          ),
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            /// Attempt local session recovery as fallback
            return const AuthState.unauthenticated();
          },
        );

    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId != null) {
      await sl<SyncService>().syncAll(userId: userId);
      sl<RealtimeNotificationService>().startListening(userId);
    }

    /// Listen for auth changes to manage realtime listener
    _authSubscription = authBloc.stream.listen((state) {
      state.maybeWhen(
        authenticated: (user) {
          sl<RealtimeNotificationService>().startListening(user.id);
        },
        unauthenticated: () {
          sl<RealtimeNotificationService>().stopListening();
        },
        orElse: () {},
      );
    });

    /// Notify all active screens to reload after sync
    sl<RefreshNotifier>().notifyDataChanged();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ThemeCubit>()),
      ],

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: F.title,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            routerConfig: _router,
            builder: (context, child) {
              if (kDebugMode) {
                return Banner(
                  location: BannerLocation.topStart,
                  message:
                      '${F.name}${F.appFlavor == Flavor.dev ? ' DEV' : ''}',
                  color: F.appFlavor == Flavor.dev
                      ? Colors.deepOrange.withAlpha(150)
                      : Colors.green.withAlpha(150),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                    letterSpacing: 1.0,
                  ),
                  textDirection: TextDirection.ltr,
                  child: child!,
                );
              }
              return child!;
            },
          );
        },
      ),
    );
  }
}
