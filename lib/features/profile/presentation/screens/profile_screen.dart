import '../../../../core.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,

      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Text('Choose Theme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.phone_android_rounded),

                  title: const Text('System'),

                  onTap: () {
                    context.read<ThemeCubit>().setTheme(ThemeMode.system);

                    context.pop();
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.light_mode_rounded),

                  title: const Text('Light'),

                  onTap: () {
                    context.read<ThemeCubit>().setTheme(ThemeMode.light);

                    context.pop();
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),

                  title: const Text('Dark'),

                  onTap: () {
                    context.read<ThemeCubit>().setTheme(ThemeMode.dark);

                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showResetPasswordDialog(BuildContext context, String email) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text('Reset Password'),

          content: Text('Send password reset email to $email?'),

          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },

              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthEvent.forgotPassword(email: email));

                context.pop();

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset email sent')));
              },

              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text('Logout'),

          content: const Text('Are you sure you want to logout?'),

          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },

              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.logout());

                context.pop();
              },

              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            context.go(AppRoute.login.path);
          },
        );
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),

        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),

                loading: () => const Center(child: CircularProgressIndicator()),

                unauthenticated: () => const SizedBox(),

                error: (message) {
                  return Center(child: Text(message));
                },

                authenticated: (user) {
                  return ListView(
                    padding: const EdgeInsets.all(20),

                    children: [
                      /// User Card
                      Card(
                        elevation: 0,

                        child: Padding(
                          padding: const EdgeInsets.all(20),

                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 42,

                                child: Text(
                                  user.name.substring(0, 1).toUpperCase(),

                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),

                              const SizedBox(height: 16),

                              Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                              if (user.nickname != null) ...[
                                const SizedBox(height: 4),

                                Text('@${user.nickname}', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                              ],

                              const SizedBox(height: 12),

                              Text(user.email, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// Settings Header
                      const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 14),

                      /// Theme
                      _SettingTile(
                        icon: Icons.palette_rounded,

                        title: 'Theme',

                        subtitle: 'Light, Dark or System',

                        onTap: () {
                          _showThemeBottomSheet(context);
                        },
                      ),

                      /// Reset Password
                      _SettingTile(
                        icon: Icons.lock_reset_rounded,

                        title: 'Reset Password',

                        subtitle: 'Send password reset email',

                        onTap: () {
                          _showResetPasswordDialog(context, user.email);
                        },
                      ),

                      /// Logout
                      _SettingTile(
                        icon: Icons.logout_rounded,

                        title: 'Logout',

                        subtitle: 'Logout from account',

                        isDestructive: true,

                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),

                      const SizedBox(height: 28),

                      /// About
                      Center(
                        child: Column(
                          children: [
                            Text('FamXpense', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),

                            const SizedBox(height: 4),

                            Text('Version 1.0.0', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingTile({required this.icon, required this.title, required this.subtitle, required this.onTap, this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final destructiveColor = Theme.of(context).colorScheme.error;

    return Card(
      elevation: 0,

      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: isDestructive
              ? destructiveColor.withValues(alpha: 0.12)
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),

          child: Icon(icon, color: isDestructive ? destructiveColor : Theme.of(context).colorScheme.primary),
        ),

        title: Text(
          title,

          style: TextStyle(color: isDestructive ? destructiveColor : null, fontWeight: FontWeight.w600),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
