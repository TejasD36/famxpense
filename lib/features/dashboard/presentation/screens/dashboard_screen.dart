import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../xcore.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamXpense'),

        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logout());
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: const Center(child: Text('Dashboard')),
    );
  }
}
