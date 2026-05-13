import '../../core.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/expenses/presentation/blocs/activity/activity_bloc.dart';
import '../../features/expenses/presentation/blocs/add_expense/add_expense_bloc.dart';
import '../../features/expenses/presentation/blocs/home/home_bloc.dart';
import '../../features/expenses/presentation/screens/activity_screen.dart';
import '../../features/expenses/presentation/screens/add_expense_screen.dart';
import '../../features/expenses/presentation/screens/home_screen.dart';
import '../../features/groups/presentation/screens/groups_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../navigation/main_navigation.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoute.splash.path,

      debugLogDiagnostics: kDebugMode,

      routes: [
        /// AUTH
        GoRoute(path: AppRoute.splash.path, name: AppRoute.splash.name, builder: (_, _) => const SplashScreen()),

        GoRoute(path: AppRoute.login.path, name: AppRoute.login.name, builder: (_, _) => const LoginScreen()),

        GoRoute(path: AppRoute.register.path, name: AppRoute.register.name, builder: (_, _) => const RegisterScreen()),

        GoRoute(path: AppRoute.forgotPassword.path, name: AppRoute.forgotPassword.name, builder: (_, _) => const ForgotPasswordScreen()),

        /// MAIN SHELL
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) {
            return MainNavigation(shell: shell);
          },

          branches: [
            /// HOME
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.home.path,

                  name: AppRoute.home.name,

                  builder: (_, _) {
                    return BlocProvider(create: (_) => sl<HomeBloc>(), child: const HomeScreen());
                  },
                ),
              ],
            ),

            /// GROUPS
            StatefulShellBranch(
              routes: [GoRoute(path: AppRoute.groups.path, name: AppRoute.groups.name, builder: (_, _) => const GroupsScreen())],
            ),

            /// ACTIVITY
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.activity.path,

                  name: AppRoute.activity.name,

                  builder: (_, _) {
                    return BlocProvider(create: (_) => sl<ActivityBloc>(), child: const ActivityScreen());
                  },
                ),
              ],
            ),

            /// PROFILE
            StatefulShellBranch(
              routes: [GoRoute(path: AppRoute.profile.path, name: AppRoute.profile.name, builder: (_, _) => const ProfileScreen())],
            ),
          ],
        ),

        /// STANDALONE
        GoRoute(
          path: AppRoute.addExpense.path,

          name: AppRoute.addExpense.name,

          builder: (_, _) {
            return BlocProvider(create: (_) => sl<AddExpenseBloc>(), child: const AddExpenseScreen());
          },
        ),
      ],
    );
  }
}
