import 'dart:async';

import '../../../../core.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/presentation/blocs/account_bloc.dart';
import '../../../account/presentation/widgets/account_tile.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../notification/presentation/blocs/notification_bloc.dart';
import '../../../savings/domain/repositories/savings_repository.dart';
import '../../../settlement/data/datasources/settlement_local_datasource.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_onRefresh);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onRefresh);
    super.dispose();
  }

  void _onRefresh() {
    if (mounted) {
      if (context.mounted) {
        context.read<NotificationBloc>().add(const NotificationEvent.loadNotifications());
      }
    }
  }

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
                  return RefreshIndicator(
                    onRefresh: () async {
                      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
                      if (userId.isNotEmpty) {
                        await sl<SyncService>().syncAll(userId: userId);
                        if (context.mounted) context.read<NotificationBloc>().add(const NotificationEvent.loadNotifications());
                      }
                    },
                    child: ListView(
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

                      /// Notifications
                      BlocBuilder<NotificationBloc, NotificationState>(
                        builder: (context, state) {
                          final unread = state.whenOrNull(loaded: (n) => n.where((n) => !n.isRead).length) ?? 0;
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                                child: const Icon(Icons.notifications_outlined),
                              ),
                              title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                              trailing: unread > 0
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.error,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        unread > 99 ? '99+' : unread.toString(),
                                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : const Icon(Icons.chevron_right_rounded),
                              onTap: () => context.pushNamed(AppRoute.notifications.name),
                            ),
                          );
                        },
                      ),

                      /// Settlements Summary
                      _SettlementsTile(),
                      const SizedBox(height: 12),

                      /// Activity
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                            child: const Icon(Icons.receipt_long_rounded),
                          ),
                          title: const Text('Activity', style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.pushNamed(AppRoute.activity.name),
                        ),
                      ),

                      /// Income
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                            child: const Icon(Icons.account_balance_rounded),
                          ),
                          title: const Text('Income', style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => context.pushNamed(AppRoute.income.name),
                        ),
                      ),

                      /// Savings
                      _SavingsTile(),
                      const SizedBox(height: 8),

                      /// Settings Header
                      const SizedBox(height: 8),
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
                  ),
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
  late final AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    _accountBloc = sl<AccountBloc>()..add(const AccountEvent.loadAccounts());
    sl<RefreshNotifier>().addListener(_refresh);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_refresh);
    _accountBloc.close();
    super.dispose();
  }

  void _refresh() => _accountBloc.add(const AccountEvent.loadAccounts());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
      value: _accountBloc,
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
    sl<RefreshNotifier>().addListener(_load);
    _accountBoxSub = Hive.box<AccountDto>(HiveBoxes.accounts).watch().listen((_) => _load());
    _load();
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_load);
    _accountBoxSub?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;
    String? id = await AppSettings.getDefaultAccountId(userId: userId);
    if (id == null) {
      final dtos = await sl<AccountLocalDatasource>().getAccounts();
      final first = dtos.where((d) => d.userId == userId && !d.isSavings).firstOrNull;
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
    final accounts = dtos.where((d) => d.userId == userId && !d.isSavings).map((d) => d.toEntity()).toList();

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
                  subtitle: Text(formatIndianRupee(a.currentBalance)),
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

class _SettlementsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
    return FutureBuilder<Map<String, dynamic>>(
      future: Future.wait([
        sl<SettlementLocalDatasource>().getSettlements(),
        sl<DebtLedgerLocalDatasource>().getLedgers(),
      ]).then((results) => <String, dynamic>{
        'settlements': (results[0] as List<SettlementDto>)
            .where((d) => d.fromUserId == userId || d.toUserId == userId)
            .map((d) => d.toEntity())
            .toList(),
        'debts': results[1] as List<DebtLedgerDto>,
      }),
      builder: (context, snapshot) {
        final settlements = (snapshot.data?['settlements'] as List<SettlementEntity>?) ?? <SettlementEntity>[];
        final debtDtos = (snapshot.data?['debts'] as List<DebtLedgerDto>?) ?? <DebtLedgerDto>[];

        final pendingIncoming = settlements.where((s) => s.toUserId == userId && s.status == SettlementStatus.pending).length;
        final pendingOutgoing = settlements.where((s) => s.fromUserId == userId && s.status == SettlementStatus.pending).length;
        /// Compute debt summary from debt ledger
        double iAmOwed = 0;
        double iOwe = 0;
        for (final d in debtDtos) {
          if (d.userA == userId) {
            if (d.netBalance < 0) {
              iAmOwed += d.netBalance.abs();
            } else {
              iOwe += d.netBalance;
            }
          } else if (d.userB == userId) {
            if (d.netBalance > 0) {
              iAmOwed += d.netBalance;
            } else {
              iOwe += d.netBalance.abs();
            }
          }
        }

        final subtitleParts = <String>[];
        if (pendingIncoming > 0) subtitleParts.add('$pendingIncoming pending confirmation${pendingIncoming > 1 ? 's' : ''}');
        if (pendingOutgoing > 0) subtitleParts.add('$pendingOutgoing awaiting response${pendingOutgoing > 1 ? 's' : ''}');
        if (iAmOwed > 0) subtitleParts.add('${formatIndianRupee(iAmOwed)} owed to you');
        if (iOwe > 0) subtitleParts.add('You owe ${formatIndianRupee(iOwe)}');
        if (subtitleParts.isEmpty) subtitleParts.add('All settled up');

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.12),
              child: const Icon(Icons.account_balance_rounded, color: Colors.green),
            ),
            title: const Text('Settlements & Balance', style: TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              subtitleParts.join(' • '),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.pushNamed(AppRoute.settlements.name),
          ),
        );
      },
    );
  }
}

class _SavingsTile extends StatefulWidget {
  @override
  State<_SavingsTile> createState() => _SavingsTileState();
}

class _SavingsTileState extends State<_SavingsTile> {
  double _ytdTotal = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_load);
    _load();
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
      final total = await sl<SavingsRepository>().getTotalSavedYearToDate(userId);
      if (mounted) setState(() { _ytdTotal = total; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber.withValues(alpha: 0.12),
          child: const Icon(Icons.savings_rounded, color: Colors.amber),
        ),
        title: const Text('Savings', style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: _loading
            ? const Text('Loading...')
            : Text('YTD: ${formatIndianRupee(_ytdTotal)}'),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => context.pushNamed(AppRoute.savings.name),
      ),
    );
  }
}
