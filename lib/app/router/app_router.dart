import '../../core.dart';
import '../../features/account/presentation/blocs/account_bloc.dart';
import '../../features/account/presentation/screens/add_account_screen.dart';
import '../../features/account/presentation/screens/account_detail_screen.dart';
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
import '../../features/expenses/presentation/screens/search_activity_screen.dart';
import '../../features/notification/presentation/blocs/notification_bloc.dart';
import '../../features/notification/presentation/screens/notification_screen.dart';
import '../../features/partners/presentation/blocs/partner_bloc.dart';
import '../../features/partners/presentation/screens/add_partner_screen.dart';
import '../../features/partners/presentation/screens/partners_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/statistics/presentation/blocs/statistics_bloc.dart';
import '../../features/statistics/presentation/screens/statistics_screen.dart';
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
            return BlocProvider(
              create: (_) => sl<NotificationBloc>(),
              child: MainNavigation(shell: shell),
            );
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

            /// PARTNERS
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.partners.path,
                  name: AppRoute.partners.name,
                  builder: (_, _) {
                    return BlocProvider(create: (_) => sl<PartnerBloc>(), child: const PartnersScreen());
                  },
                  routes: [
                    GoRoute(
                      path: 'add',
                      name: AppRoute.addPartner.name,
                      builder: (_, _) {
                        return BlocProvider(create: (_) => sl<PartnerBloc>(), child: const AddPartnerScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),

            /// STATISTICS
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.statistics.path,
                  name: AppRoute.statistics.name,
                  builder: (_, _) {
                    return BlocProvider(create: (_) => sl<StatisticsBloc>(), child: const StatisticsScreen());
                  },
                ),
              ],
            ),

            /// PROFILE
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoute.profile.path,
                  name: AppRoute.profile.name,
                  builder: (_, _) => const ProfileScreen(),
                ),
              ],
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
        GoRoute(
          path: AppRoute.activity.path,
          name: AppRoute.activity.name,
          builder: (_, _) {
            return BlocProvider(create: (_) => sl<ActivityBloc>(), child: const ActivityScreen());
          },
        ),
        GoRoute(
          path: AppRoute.addAccount.path,
          name: AppRoute.addAccount.name,
          builder: (_, _) {
            return BlocProvider(create: (_) => sl<AccountBloc>(), child: const AddAccountScreen());
          },
        ),
        GoRoute(
          path: AppRoute.accountDetail.path,
          name: AppRoute.accountDetail.name,
          builder: (_, _) {
            return BlocProvider(create: (_) => sl<AccountBloc>(), child: const AccountDetailScreen());
          },
        ),
        GoRoute(
          path: AppRoute.searchActivity.path,
          name: AppRoute.searchActivity.name,
          builder: (_, _) => const SearchActivityScreen(),
        ),
        GoRoute(
          path: AppRoute.notifications.path,
          name: AppRoute.notifications.name,
          builder: (_, _) => BlocProvider(create: (_) => sl<NotificationBloc>(), child: const NotificationScreen()),
        ),
      ],
    );
  }
}
