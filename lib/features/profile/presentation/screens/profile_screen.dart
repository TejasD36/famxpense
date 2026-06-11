import 'dart:async';

import '../../../../core.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/presentation/blocs/account_bloc.dart';
import '../../../account/presentation/widgets/account_tile.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
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
        appBar: AppBar(
          title: Padding(padding: const EdgeInsets.symmetric(horizontal: 13.0), child: const Text('Profile')),
        ),
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),

                loading: () => const Center(child: CircularProgressIndicator()),

                unauthenticated: () => const SizedBox(),

                passwordResetSent: () => const SizedBox(),

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

                              const SizedBox(height: 4),

                              Text('@${user.nickname}', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),

                              const SizedBox(height: 12),

                              Text(user.email, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// Accounts
                      _AccountsSection(),

                      const SizedBox(height: 28),

                      /// Settings Header
                      const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 14),

                      /// Default Account
                      _DefaultAccountTile(),

                      const SizedBox(height: 12),

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

class _AccountsSection extends StatefulWidget {
  const _AccountsSection();

  @override
  State<_AccountsSection> createState() => _AccountsSectionState();
}

class _AccountsSectionState extends State<_AccountsSection> {
  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_refresh);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => context.read<AccountBloc>().add(const AccountEvent.loadAccounts());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (_) => sl<AccountBloc>()..add(const AccountEvent.loadAccounts()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          final accounts = state.maybeWhen(loaded: (a) => a, orElse: () => <AccountEntity>[]);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Accounts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => context.pushNamed(AppRoute.addAccount.name),
                    icon: const Icon(Icons.add_rounded, size: 20),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (state.maybeWhen(loading: () => true, orElse: () => false))
                const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
              else if (accounts.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text('No accounts yet', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ),
                )
              else
                ...accounts.map((account) => AccountTile(
                  account: account,
                  onTap: () => context.pushNamed(AppRoute.accountDetail.name, extra: account),
                )),
            ],
          );
        },
      ),
    );
  }
}

class _DefaultAccountTile extends StatefulWidget {
  @override
  State<_DefaultAccountTile> createState() => _DefaultAccountTileState();
}

class _DefaultAccountTileState extends State<_DefaultAccountTile> {
  String? _defaultAccountId;
  String? _defaultAccountName;
  StreamSubscription? _accountBoxSub;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _accountBoxSub?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;
    String? id = await AppSettings.getDefaultAccountId(userId: userId);
    if (id == null) {
      final dtos = await sl<AccountLocalDatasource>().getAccounts();
      final first = dtos.where((d) => d.userId == userId).firstOrNull;
      if (first != null) {
        id = first.id;
        await AppSettings.setDefaultAccountId(userId: userId, accountId: id);
      }
    }
    final name = id != null ? await _accountName(id) : null;
    if (mounted) setState(() { _defaultAccountId = id; _defaultAccountName = name; });
  }

  Future<String?> _accountName(String id) async {
    final dtos = await sl<AccountLocalDatasource>().getAccounts();
    return dtos.where((a) => a.id == id).firstOrNull?.accountName;
  }

  Future<void> _pickAccount() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;
    final dtos = await sl<AccountLocalDatasource>().getAccounts();
    final accounts = dtos.where((d) => d.userId == userId).map((d) => d.toEntity()).toList();

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Default Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Settlement amounts will be deposited here'),
              const SizedBox(height: 16),
              if (accounts.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No accounts yet. Create one first.')),
                )
              else
                ...accounts.map((a) => ListTile(
                  leading: CircleAvatar(child: Icon(a.accountType == AccountType.cash ? Icons.money_rounded : Icons.account_balance_rounded)),
                  title: Text(a.accountName),
                  subtitle: Text('₹${a.currentBalance.toStringAsFixed(0)}'),
                  trailing: _defaultAccountId == a.id ? const Icon(Icons.check_circle, color: Colors.green) : null,
                  onTap: () async {
                    await AppSettings.setDefaultAccountId(userId: userId, accountId: a.id);
                    if (!mounted) return;
                    Navigator.pop(context);
                    _load();
                  },
                )),
              const Divider(),
              if (_defaultAccountId != null)
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.remove_circle_outline_rounded)),
                  title: const Text('None'),
                  onTap: () async {
                    await AppSettings.setDefaultAccountId(userId: userId, accountId: null);
                    if (!mounted) return;
                    Navigator.pop(context);
                    _load();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SettingTile(
      icon: Icons.account_balance_wallet_rounded,
      title: 'Default Account',
      subtitle: _defaultAccountName != null ? _defaultAccountName! : 'None',
      onTap: _pickAccount,
    );
  }
}
