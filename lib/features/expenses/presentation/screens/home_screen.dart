import '../../../../core/services/sync/sync_service.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../debt_ledger/domain/usecases/get_debts_usecase.dart';
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

    sl<RefreshNotifier>().addListener(_onDataChanged);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) {
      context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              empty: () {
                return _EmptyView();
              },
              error: (message) {
                return Center(child: Text(message));
              },
              loaded: (totalSpend, personalSpend, sharedSpend, pendingSyncCount, recentExpenses) {
                return RefreshIndicator(
                  onRefresh: () async {
                    final authState = context.read<AuthBloc>().state;

                      await authState.whenOrNull(
                        authenticated: (user) async {
                          /// SYNC ALL
                          final syncResult = await sl<SyncService>().syncAll(userId: user.id);

                        /// RELOAD DASHBOARD
                        if (context.mounted) {
                          if (!syncResult) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Sync failed. Check your connection.'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
                            ));
                          }
                          context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
                        }
                      },
                    );
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      /// Header
                      Text('Welcome Back 👋', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      const Text('FamXpense', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMMM yyyy').format(DateTime.now()),
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 28),

                      /// Debt Summary
                      _DebtSummaryCards(),
                      const SizedBox(height: 20),

                      /// Total Spend Card
                      _SummaryCard(title: 'Total Spend', value: '₹${totalSpend.toStringAsFixed(0)}', icon: Icons.account_balance_wallet),
                      const SizedBox(height: 16),

                      /// Split cards
                      Row(
                        children: [
                          Expanded(
                            child: _MiniCard(title: 'Personal', value: '₹${personalSpend.toStringAsFixed(0)}', icon: Icons.person_rounded),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MiniCard(title: 'Shared', value: '₹${sharedSpend.toStringAsFixed(0)}', icon: Icons.groups_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _MiniCard(title: 'Pending Sync', value: pendingSyncCount.toString(), icon: Icons.sync_problem_rounded),
                      const SizedBox(height: 32),

                      /// Recent Expenses
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Recent Expenses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          TextButton(onPressed: () => context.go(AppRoute.activity.path), child: const Text('View All')),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...recentExpenses.map((expense) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),

                          child: _ExpenseTile(expense: expense),
                        );
                      }),
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _SummaryCard({required this.title, required this.value, required this.icon});
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
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
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
  const _MiniCard({required this.title, required this.value, required this.icon});

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
            Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final ExpenseEntity expense;
  const _ExpenseTile({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(child: Icon(expense.expenseType == ExpenseType.shared ? Icons.groups_rounded : Icons.person_rounded)),
        title: Text(expense.title),
        subtitle: Text(DateFormat('dd MMM yyyy').format(expense.expenseDate)),
        trailing: Text('₹${expense.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
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
            const Icon(Icons.receipt_long_rounded, size: 80),
            const SizedBox(height: 24),
            const Text('No expenses yet', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              'Tap the + button below to add your first expense.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebtSummaryCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return const SizedBox();

    return FutureBuilder<List<DebtLedgerEntity>>(
      future: sl<GetDebtsUsecase>()(userId: userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return _shimmerLoading();

        if (snapshot.data!.isEmpty) return const SizedBox();

        final debts = snapshot.data!;

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

        if (youAreOwed.isEmpty && youOwe.isEmpty) return const SizedBox();

        return Column(
          children: [
            if (youAreOwed.isNotEmpty) ...[
              _sectionHeader(context, Icons.arrow_downward_rounded, Colors.green, 'You are owed'),
              const SizedBox(height: 8),
              ...youAreOwed.map((e) => _debtCard(context, e, Colors.green, settle: false, userId: userId)),
              const SizedBox(height: 16),
            ],
            if (youOwe.isNotEmpty) ...[
              _sectionHeader(context, Icons.arrow_upward_rounded, Colors.red, 'You owe'),
              const SizedBox(height: 8),
              ...youOwe.map((e) => _debtCard(context, e, Colors.red, settle: true, userId: userId)),
            ],
          ],
        );
      },
    );
  }

  Widget _sectionHeader(BuildContext context, IconData icon, MaterialColor color, String title) {
    return Row(
      children: [
        Icon(icon, color: color.shade700, size: 20),
        const SizedBox(width: 6),
        Text(title, style: TextStyle(color: color.shade700, fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _debtCard(BuildContext context, MapEntry<String, double> entry, MaterialColor color, {required bool settle, required String userId}) {
    final otherUser = sl<UserLocalDatasource>().getUser(entry.key);
    final name = otherUser?.nickname ?? otherUser?.name ?? 'Unknown';
    final amount = entry.value;

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
                style: TextStyle(color: color.shade700, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@$name', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text('₹${amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color.shade700)),
                ],
              ),
            ),
            if (settle)
              TextButton(
                onPressed: () => _showSettleDialog(context, userId: userId, fromUserId: userId, toUserId: entry.key, amount: amount),
                child: const Text('Settle', style: TextStyle(fontSize: 13)),
              ),
          ],
        ),
      ),
    );
  }

  void _showSettleDialog(BuildContext context, {required String userId, required String fromUserId, required String toUserId, required double amount}) {
    final controller = TextEditingController(text: amount.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Settle Up'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter amount to settle:'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final settleAmount = double.tryParse(controller.text.trim()) ?? 0;
              if (settleAmount <= 0) return;

              final messenger = ScaffoldMessenger.of(context);
              final homeBloc = context.read<HomeBloc>();
              final navCtx = ctx;

              await sl<SettleDebtUsecase>()(
                fromUserId: fromUserId,
                toUserId: toUserId,
                amount: settleAmount,
              );

              Navigator.pop(navCtx);
              messenger.showSnackBar(SnackBar(
                content: const Text('Settled successfully'),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
              ));
              homeBloc.add(const HomeEvent.loadDashboard());
            },
            child: const Text('Settle'),
          ),
        ],
      ),
    );
  }

  Widget _shimmerLoading() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 0.7),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, _) {
        return Column(
          children: [
            _shimmerCard(value),
            const SizedBox(height: 8),
            _shimmerCard(value),
          ],
        );
      },
    );
  }

  Widget _shimmerCard(double opacity) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey.withValues(alpha: opacity * 0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(radius: 18, backgroundColor: Colors.grey.withValues(alpha: opacity * 0.2)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 12, width: 80, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: opacity * 0.2), borderRadius: BorderRadius.circular(4))),
                  const SizedBox(height: 6),
                  Container(height: 16, width: 60, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: opacity * 0.2), borderRadius: BorderRadius.circular(4))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
