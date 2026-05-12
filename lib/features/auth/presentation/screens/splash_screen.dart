import '../../xcore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (_) {
            context.go(AppRoute.home.path);
          },

          unauthenticated: () {
            context.go(AppRoute.login.path);
          },
        );
      },

      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.account_balance_wallet_rounded, size: 80),

              SizedBox(height: 16),

              Text('FamXpense', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

              SizedBox(height: 24),

              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
