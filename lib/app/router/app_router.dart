import '../../core.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoute.splash.path,

      debugLogDiagnostics: kDebugMode,

      routes: [
        GoRoute(path: AppRoute.splash.path, name: AppRoute.splash.name, builder: (_, _) => const SplashScreen()),

        GoRoute(path: AppRoute.login.path, name: AppRoute.login.name, builder: (_, _) => const LoginScreen()),

        GoRoute(path: AppRoute.register.path, name: AppRoute.register.name, builder: (_, _) => const RegisterScreen()),

        GoRoute(path: AppRoute.dashboard.path, name: AppRoute.dashboard.name, builder: (_, _) => const DashboardScreen()),
      ],
    );
  }
}
