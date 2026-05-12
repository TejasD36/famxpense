import '../core.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = AppRouter.createRouter();
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
            title: 'FamXpense',

            debugShowCheckedModeBanner: false,

            theme: AppTheme.light,

            darkTheme: AppTheme.dark,

            themeMode: state.themeMode,

            routerConfig: _router,
          );
        },
      ),
    );
  }
}
