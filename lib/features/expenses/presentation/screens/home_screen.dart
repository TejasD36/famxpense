import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../notification/presentation/blocs/notification_bloc.dart';
import '../../../settlement/domain/usecases/process_settlement_usecase.dart';
import '../../../settlement/domain/usecases/settle_debt_usecase.dart';
import '../../xcore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
    context.read<NotificationBloc>().add(
      const NotificationEvent.loadNotifications(),
    );

    final notifier = sl<RefreshNotifier>();
    if (notifier.hasData) {
      context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
      context.read<NotificationBloc>().add(
        const NotificationEvent.loadNotifications(),
      );
    }
    notifier.addListener(_onDataChanged);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) {
      context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
      context.read<NotificationBloc>().add(
        const NotificationEvent.loadNotifications(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: const Text('FamXpense'),
        ),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              final unread =
                  state.whenOrNull(
                    loaded: (n) => n.where((n) => !n.isRead).length,
                  ) ??
                  0;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    tooltip: 'Notifications',
                    onPressed: () =>
                        context.pushNamed(AppRoute.notifications.name),
                  ),
                  if (unread > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          unread > 99 ? '99+' : unread.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              empty: () {
                return RefreshIndicator(
                  onRefresh: () async {
                    final authState = context.read<AuthBloc>().state;
                    await authState.whenOrNull(
                      authenticated: (user) async {
                        await sl<SyncService>().syncAll(userId: user.id);
                        if (context.mounted) {
                          context.read<HomeBloc>().add(
                            const HomeEvent.loadDashboard(),
                          );
                        }
                      },
                    );
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight > 400
                            ? constraints.maxHeight * 0.7
                            : 400,
                        child: _EmptyView(),
                      ),
                    ),
                  ),
                );
              },
              error: (message) {
                return RefreshIndicator(
                  onRefresh: () async {
                    final authState = context.read<AuthBloc>().state;
                    await authState.whenOrNull(
                      authenticated: (user) async {
                        await sl<SyncService>().syncAll(userId: user.id);
                        if (context.mounted) {
                          context.read<HomeBloc>().add(
                            const HomeEvent.loadDashboard(),
                          );
                        }
                      },
                    );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 300,
                      child: Center(child: Text(message)),
                    ),
                  ),
                );
              },
              loaded:
                  (
                    totalSpend,
                    personalSpend,
                    sharedSpend,
                    pendingSyncCount,
                    _,
                    debts,
                    _,
                    incomingPendingSettlements,
                    outgoingPendingSettlements,
                  ) {
                    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
                    final userName = context.read<AuthBloc>().state.maybeWhen(
                      authenticated: (user) => user.nickname,
                      orElse: () => '',
                    );
                    String inr(double v) => formatIndianRupee(v);
                    return RefreshIndicator(
                      onRefresh: () async {
                        final authState = context.read<AuthBloc>().state;

                        await authState.whenOrNull(
                          authenticated: (user) async {
                            /// SYNC ALL
                            final syncResult = await sl<SyncService>().syncAll(
                              userId: user.id,
                            );

                            /// RELOAD DASHBOARD
                            if (context.mounted) {
                              if (!syncResult) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Sync failed. Check your connection.',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                          0.1,
                                    ),
                                  ),
                                );
                              }
                              context.read<HomeBloc>().add(
                                const HomeEvent.loadDashboard(),
                              );
                            }
                          },
                        );
                      },
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        children: [
                          _HomeInsightPanel(
                            userName: userName,
                            totalSpend: totalSpend,
                            personalSpend: personalSpend,
                            sharedSpend: sharedSpend,
                            debts: debts,
                            userId: userId,
                            pendingSyncCount: pendingSyncCount,
                          ),
                          const SizedBox(height: 20),

                          /// Pending Confirmations (incoming)
                          if (incomingPendingSettlements.isNotEmpty) ...[
                            _PendingConfirmations(
                              incoming: incomingPendingSettlements,
                              userId: userId,
                            ),
                            const SizedBox(height: 20),
                          ],

                          /// Pending Settlements (outgoing)
                          if (outgoingPendingSettlements.isNotEmpty) ...[
                            _PendingSettlements(
                              outgoing: outgoingPendingSettlements,
                              userId: userId,
                            ),
                            const SizedBox(height: 20),
                          ],

                          /// Debt Summary
                          _DebtSummaryCards(
                            debts: debts,
                            userId: sl<AuthLocalDatasource>().getUserId() ?? '',
                            outgoingPendingSettlements:
                                outgoingPendingSettlements,
                          ),
                          const SizedBox(height: 20),

                          /// Total Spend Card
                          _SummaryCard(
                            title: 'Total Spend',
                            value: inr(totalSpend),
                            icon: Icons.account_balance_wallet,
                          ),
                          const SizedBox(height: 16),

                          /// Split cards
                          Row(
                            children: [
                              Expanded(
                                child: _MiniCard(
                                  title: 'Personal',
                                  value: inr(personalSpend),
                                  icon: Icons.person_rounded,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MiniCard(
                                  title: 'Shared',
                                  value: inr(sharedSpend),
                                  icon: Icons.groups_rounded,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _PendingSyncStrip(count: pendingSyncCount),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
            );
          },
        ),
      ),
    );
  }
}

class _HomeInsightPanel extends StatelessWidget {
  final String userName;
  final double totalSpend;
  final double personalSpend;
  final double sharedSpend;
  final List<DebtLedgerEntity> debts;
  final String userId;
  final int pendingSyncCount;

  const _HomeInsightPanel({
    required this.userName,
    required this.totalSpend,
    required this.personalSpend,
    required this.sharedSpend,
    required this.debts,
    required this.userId,
    required this.pendingSyncCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totals = _debtTotals(debts, userId);
    final balanceLabel = totals.$1 > totals.$2
        ? 'You are owed ${formatIndianRupee(totals.$1 - totals.$2)}'
        : totals.$2 > totals.$1
        ? 'You owe ${formatIndianRupee(totals.$2 - totals.$1)}'
        : 'All settled up';

    return GradientPatternPanel(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isEmpty ? 'Welcome back' : 'Welcome, @$userName',
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'FamXpense',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat('MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InsightChip(
                      icon: Icons.payments_rounded,
                      label: formatIndianRupee(totalSpend),
                    ),
                    _InsightChip(
                      icon: Icons.groups_rounded,
                      label: '${formatIndianRupee(sharedSpend)} shared',
                    ),
                    _InsightChip(
                      icon: Icons.person_rounded,
                      label: '${formatIndianRupee(personalSpend)} personal',
                    ),
                    if (pendingSyncCount > 0)
                      _InsightChip(
                        icon: Icons.sync_problem_rounded,
                        label: '$pendingSyncCount pending',
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  balanceLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const FinanceLottieAccent(size: 92),
        ],
      ),
    );
  }

  (double owedToMe, double iOwe) _debtTotals(
    List<DebtLedgerEntity> debts,
    String userId,
  ) {
    var owedToMe = 0.0;
    var iOwe = 0.0;
    for (final debt in debts) {
      if (debt.userA == userId) {
        if (debt.netBalance < 0) {
          owedToMe += debt.netBalance.abs();
        } else {
          iOwe += debt.netBalance;
        }
      } else if (debt.userB == userId) {
        if (debt.netBalance > 0) {
          owedToMe += debt.netBalance;
        } else {
          iOwe += debt.netBalance.abs();
        }
      }
    }
    return (owedToMe, iOwe);
  }
}

class _InsightChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InsightChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _PendingSyncStrip extends StatelessWidget {
  final int count;

  const _PendingSyncStrip({required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPending = count > 0;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => context.pushNamed(AppRoute.reconciliation.name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: hasPending
              ? theme.colorScheme.errorContainer.withValues(alpha: 0.50)
              : theme.colorScheme.primaryContainer.withValues(alpha: 0.30),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              hasPending
                  ? Icons.sync_problem_rounded
                  : Icons.cloud_done_rounded,
              size: 18,
              color: hasPending
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                hasPending
                    ? '$count item${count == 1 ? '' : 's'} waiting to sync'
                    : 'Everything is synced',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                color: hasPending
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _MiniCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingConfirmations extends StatefulWidget {
  final List<SettlementEntity> incoming;
  final String userId;
  const _PendingConfirmations({required this.incoming, required this.userId});

  @override
  State<_PendingConfirmations> createState() => _PendingConfirmationsState();
}

class _PendingConfirmationsState extends State<_PendingConfirmations> {
  final Set<String> _confirmingIds = {};
  final Set<String> _rejectingIds = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.hourglass_bottom_rounded,
              color: Colors.orange.shade700,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              'Pending Confirmations',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...widget.incoming.map((s) {
          final otherId = s.fromUserId == widget.userId
              ? s.toUserId
              : s.fromUserId;
          final other = sl<UserLocalDatasource>().getUser(otherId);
          final name = other?.nickname ?? 'Unknown';
          final isConfirming = _confirmingIds.contains(s.id);
          final isRejecting = _rejectingIds.contains(s.id);
          final isProcessing = isConfirming || isRejecting;
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.orange.withValues(alpha: 0.08),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.orange.withValues(alpha: 0.15),
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@$name wants to settle',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          formatIndianRupee(s.amount),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: isConfirming
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          ),
                    tooltip: 'Confirm',
                    onPressed: isProcessing
                        ? null
                        : () => _handleConfirm(context, s),
                  ),
                  IconButton(
                    icon: isRejecting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.cancel_rounded, color: Colors.red),
                    tooltip: 'Reject',
                    onPressed: isProcessing
                        ? null
                        : () => _handleReject(context, s),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Future<void> _handleConfirm(
    BuildContext context,
    SettlementEntity settlement,
  ) async {
    setState(() => _confirmingIds.add(settlement.id));
    try {
      await sl<ProcessSettlementUsecase>().confirm(
        settlementId: settlement.id,
        toAccountId: null,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settlement confirmed'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
      }
    } finally {
      if (mounted) setState(() => _confirmingIds.remove(settlement.id));
    }
  }

  Future<void> _handleReject(
    BuildContext context,
    SettlementEntity settlement,
  ) async {
    setState(() => _rejectingIds.add(settlement.id));
    try {
      await sl<ProcessSettlementUsecase>().reject(settlementId: settlement.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settlement rejected'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
      }
    } finally {
      if (mounted) setState(() => _rejectingIds.remove(settlement.id));
    }
  }
}

class _PendingSettlements extends StatelessWidget {
  final List<SettlementEntity> outgoing;
  final String userId;
  const _PendingSettlements({required this.outgoing, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              color: Colors.blue.shade700,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              'Pending Settlements',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...outgoing.map((s) {
          final otherId = s.fromUserId == userId ? s.toUserId : s.fromUserId;
          final other = sl<UserLocalDatasource>().getUser(otherId);
          final name = other?.nickname ?? 'Unknown';
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.blue.withValues(alpha: 0.08),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue.withValues(alpha: 0.15),
                    child: Icon(
                      Icons.access_time_rounded,
                      size: 20,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To @$name',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          formatIndianRupee(s.amount),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Awaiting\nconfirmation',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade300,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FinanceLottieAccent(size: 118),
            const SizedBox(height: 16),
            const Text(
              'No expenses yet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap the + button below to add your first expense.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebtSummaryCards extends StatelessWidget {
  final List<DebtLedgerEntity> debts;
  final String userId;
  final List<SettlementEntity> outgoingPendingSettlements;

  const _DebtSummaryCards({
    required this.debts,
    required this.userId,
    this.outgoingPendingSettlements = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (debts.isEmpty) return const SizedBox();

    final pendingFromUserIds = outgoingPendingSettlements
        .map((s) => s.toUserId)
        .toSet();

    final youAreOwed = <MapEntry<String, double>>[];
    final youOwe = <MapEntry<String, double>>[];

    for (final d in debts) {
      if (d.userA == userId) {
        if (d.netBalance > 0) {
          youOwe.add(MapEntry(d.userB, d.netBalance));
        } else {
          youAreOwed.add(MapEntry(d.userB, d.netBalance.abs()));
        }
      } else {
        if (d.netBalance > 0) {
          youAreOwed.add(MapEntry(d.userA, d.netBalance));
        } else {
          youOwe.add(MapEntry(d.userA, d.netBalance.abs()));
        }
      }
    }

    youAreOwed.removeWhere((e) => e.value <= 0);
    youOwe.removeWhere((e) => e.value <= 0);

    if (youAreOwed.isEmpty && youOwe.isEmpty) return const SizedBox();

    return Column(
      children: [
        if (youAreOwed.isNotEmpty) ...[
          _sectionHeader(
            context,
            Icons.arrow_downward_rounded,
            Colors.green,
            'You are owed',
          ),
          const SizedBox(height: 8),
          ...youAreOwed.map(
            (e) => _debtCard(
              context,
              e,
              Colors.green,
              settle: false,
              userId: userId,
              pendingFromUserIds: pendingFromUserIds,
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (youOwe.isNotEmpty) ...[
          _sectionHeader(
            context,
            Icons.arrow_upward_rounded,
            Colors.red,
            'You owe',
          ),
          const SizedBox(height: 8),
          ...youOwe.map(
            (e) => _debtCard(
              context,
              e,
              Colors.red,
              settle: true,
              userId: userId,
              pendingFromUserIds: pendingFromUserIds,
            ),
          ),
        ],
      ],
    );
  }

  Widget _sectionHeader(
    BuildContext context,
    IconData icon,
    MaterialColor color,
    String title,
  ) {
    return Row(
      children: [
        Icon(icon, color: color.shade700, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            color: color.shade700,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _debtCard(
    BuildContext context,
    MapEntry<String, double> entry,
    MaterialColor color, {
    required bool settle,
    required String userId,
    Set<String> pendingFromUserIds = const {},
  }) {
    final otherUser = sl<UserLocalDatasource>().getUser(entry.key);
    final name = otherUser?.nickname ?? otherUser?.name ?? 'Unknown';
    final amount = entry.value;
    final isPending = pendingFromUserIds.contains(entry.key);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: color.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: color.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@$name',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    formatIndianRupee(amount),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
            if (settle && isPending)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else if (settle)
              TextButton(
                onPressed: () => _showSettleDialog(
                  context,
                  userId: userId,
                  fromUserId: userId,
                  toUserId: entry.key,
                  amount: amount,
                ),
                child: const Text('Settle', style: TextStyle(fontSize: 13)),
              ),
          ],
        ),
      ),
    );
  }

  void _showSettleDialog(
    BuildContext context, {
    required String userId,
    required String fromUserId,
    required String toUserId,
    required double amount,
  }) {
    final controller = TextEditingController(text: amount.toStringAsFixed(0));
    final homeBloc = context.read<HomeBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final bottomInset = MediaQuery.of(context).size.height * 0.1;

    bool isSettling = false;
    showDialog(
      context: context,
      builder: (ctx) {
        return FutureBuilder<List<AccountDto>>(
          future: sl<AccountLocalDatasource>().getAccounts(),
          builder: (context, snapshot) {
            final userAccounts = (snapshot.data ?? [])
                .where((a) => a.userId == fromUserId)
                .toList();
            String? selectedAccountId;
            String? selectedAccountName;

            return StatefulBuilder(
              builder: (context, setDialogState) {
                if (selectedAccountId == null && userAccounts.isNotEmpty) {
                  selectedAccountId = userAccounts.first.id;
                  selectedAccountName = userAccounts.first.accountName;
                }
                final selectedAccountBalance = selectedAccountId != null
                    ? userAccounts
                              .where((a) => a.id == selectedAccountId)
                              .firstOrNull
                              ?.currentBalance ??
                          0
                    : 0.0;

                return AlertDialog(
                  title: const Text('Settle Up'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Enter amount to settle:'),
                      const SizedBox(height: 12),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount (₹)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (_) => setDialogState(() {}),
                      ),
                      if (selectedAccountBalance > 0) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Balance: ${formatIndianRupee(selectedAccountBalance)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const Text(
                        'Pay from account:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (snapshot.connectionState != ConnectionState.done)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      else if (userAccounts.isEmpty)
                        Text(
                          'No accounts available',
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        )
                      else
                        RadioGroup<String>(
                          groupValue: selectedAccountId,
                          onChanged: (v) {
                            setDialogState(() {
                              selectedAccountId = v;
                              selectedAccountName = userAccounts
                                  .firstWhere((a) => a.id == v)
                                  .accountName;
                            });
                          },
                          child: Column(
                            children: userAccounts
                                .map(
                                  (a) => ListTile(
                                    leading: Radio<String>(value: a.id),
                                    title: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            a.accountName,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        if (a.isSavings) ...[
                                          const SizedBox(width: 6),
                                          Icon(
                                            Icons.savings_rounded,
                                            size: 16,
                                            color: Colors.amber.shade700,
                                          ),
                                        ],
                                      ],
                                    ),
                                    subtitle: Text(
                                      formatIndianRupee(a.currentBalance),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: a.isSavings
                                            ? Colors.amber.shade700
                                            : null,
                                      ),
                                    ),
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      setDialogState(() {
                                        selectedAccountId = a.id;
                                        selectedAccountName = a.accountName;
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: isSettling ? null : () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: isSettling
                          ? null
                          : () async {
                              setDialogState(() => isSettling = true);
                              final settleAmount =
                                  double.tryParse(controller.text.trim()) ?? 0;
                              if (settleAmount <= 0) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Enter a valid amount greater than 0',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setDialogState(() => isSettling = false);
                                return;
                              }
                              if (settleAmount > 999999999) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: const Text('Amount too large'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setDialogState(() => isSettling = false);
                                return;
                              }
                              if (settleAmount > amount) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Amount cannot exceed ${formatIndianRupee(amount)}',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setDialogState(() => isSettling = false);
                                return;
                              }
                              if (selectedAccountId == null) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Select an account to pay from',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setDialogState(() => isSettling = false);
                                return;
                              }
                              if (settleAmount > selectedAccountBalance) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Insufficient balance in $selectedAccountName (${formatIndianRupee(selectedAccountBalance)})',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setDialogState(() => isSettling = false);
                                return;
                              }

                              final selectedAccount = userAccounts
                                  .where((a) => a.id == selectedAccountId)
                                  .firstOrNull;
                              if (selectedAccount?.isSavings == true) {
                                final confirmed = await showDialog<bool>(
                                  context: ctx,
                                  builder: (c) => AlertDialog(
                                    title: const Text('Savings Account'),
                                    content: const Text(
                                      'Settling from savings will reduce your monthly savings progress. Are you sure?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(c, false),
                                        child: const Text('Cancel'),
                                      ),
                                      FilledButton(
                                        onPressed: () => Navigator.pop(c, true),
                                        child: const Text('Use anyway'),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed != true) {
                                  setDialogState(() => isSettling = false);
                                  return;
                                }
                              }

                              final settleError = await sl<SettleDebtUsecase>()(
                                fromUserId: fromUserId,
                                toUserId: toUserId,
                                amount: settleAmount,
                                fromAccountId: selectedAccountId,
                              );

                              if (!ctx.mounted) return;
                              Navigator.pop(ctx);
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    settleError ??
                                        'Settled successfully from $selectedAccountName',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: bottomInset),
                                ),
                              );
                              homeBloc.add(const HomeEvent.loadDashboard());
                            },
                      child: isSettling
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Settle'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
