import 'dart:async';

import '../../../../core.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
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
                onTap: () { context.read<ThemeCubit>().setTheme(ThemeMode.system); context.pop(); },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode_rounded),
                title: const Text('Light'),
                onTap: () { context.read<ThemeCubit>().setTheme(ThemeMode.light); context.pop(); },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_rounded),
                title: const Text('Dark'),
                onTap: () { context.read<ThemeCubit>().setTheme(ThemeMode.dark); context.pop(); },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                context.pop(); // Close dialog
                context.pop(); // Close drawer
                context.read<AuthBloc>().add(const AuthEvent.logout());
              },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = sl<AuthLocalDatasource>().getUserId() != null ? sl<UserLocalDatasource>().getCurrentUser() : null;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// User Header
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
              accountName: Text(user?.name ?? 'User', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
              accountEmail: Text(user?.email ?? '', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  (user?.name ?? 'U')[0].toUpperCase(),
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),

            /// Accounts
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text('Accounts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_rounded, size: 20),
                    tooltip: 'Add Account',
                    onPressed: () => context.pushNamed(AppRoute.addAccount.name),
                  ),
                ],
              ),
            ),
            _AccountsList(),
            const Divider(),

            /// Settings
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ),

            /// Default Account
            _DefaultAccountDrawerTile(),

            /// Theme
            ListTile(
              leading: const Icon(Icons.palette_rounded),
              title: const Text('Theme'),
              subtitle: const Text('Light, Dark or System'),
              onTap: () => _showThemeBottomSheet(context),
            ),

            /// Reset Password
            ListTile(
              leading: const Icon(Icons.lock_reset_rounded),
              title: const Text('Reset Password'),
              subtitle: const Text('Send password reset email'),
              onTap: () {
                if (user != null) {
                  context.read<AuthBloc>().add(AuthEvent.forgotPassword(email: user.email));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset email sent')));
                }
              },
            ),

            const Divider(),

            /// Logout
            ListTile(
              leading: Icon(Icons.logout_rounded, color: Theme.of(context).colorScheme.error),
              title: Text('Logout', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => _showLogoutDialog(context),
            ),

            /// About
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text('FamXpense', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('Version 1.0.0', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultAccountDrawerTile extends StatefulWidget {
  @override
  State<_DefaultAccountDrawerTile> createState() => _DefaultAccountDrawerTileState();
}

class _DefaultAccountDrawerTileState extends State<_DefaultAccountDrawerTile> {
  String? _defaultAccountId;
  String? _defaultAccountName;

  @override
  void initState() {
    super.initState();
    _load();
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
    return ListTile(
      leading: const Icon(Icons.account_balance_wallet_rounded),
      title: const Text('Default Account'),
      subtitle: Text(_defaultAccountName ?? 'None'),
      onTap: _pickAccount,
    );
  }
}

class _AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
    if (userId.isEmpty) return const SizedBox();
    return FutureBuilder<List<AccountDto>>(
      future: sl<AccountLocalDatasource>().getAccounts(),
      builder: (context, snap) {
        final accounts = snap.data?.where((a) => a.userId == userId && !a.isArchived).toList() ?? [];
        if (accounts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('No accounts yet', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 13)),
          );
        }
        return Column(
          children: accounts.take(3).map((a) => ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 16,
              child: Text(a.accountName[0].toUpperCase(), style: const TextStyle(fontSize: 12)),
            ),
            title: Text(a.accountName, style: const TextStyle(fontSize: 14)),
            trailing: Text('₹${a.currentBalance.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            onTap: () => context.pushNamed(AppRoute.accountDetail.name, extra: a.toEntity()),
          )).toList(),
        );
      },
    );
  }
}
