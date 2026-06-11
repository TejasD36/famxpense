import '../../../../core/services/sync/sync_service.dart';
import '../../../account/data/datasources/account_local_datasource.dart';
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

class _ExpenseTile extends StatefulWidget {
  final ExpenseEntity expense;
  const _ExpenseTile({required this.expense});

  @override
  State<_ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<_ExpenseTile> {
  String? _accountName;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final id = widget.expense.accountId;
    if (id == null) return;
    final dtos = await sl<AccountLocalDatasource>().getAccounts();
    final name = dtos.where((a) => a.id == id).firstOrNull?.accountName;
    if (mounted) setState(() => _accountName = name);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(child: Icon(widget.expense.expenseType == ExpenseType.shared ? Icons.groups_rounded : Icons.person_rounded)),
        title: Text(widget.expense.title),
        subtitle: Text([
          DateFormat('dd MMM yyyy').format(widget.expense.expenseDate),
          ?_accountName,
        ].join(' • ')),
        trailing: Text('₹${widget.expense.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

        youAreOwed.removeWhere((e) => e.value <= 0);
        youOwe.removeWhere((e) => e.value <= 0);

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
    final homeBloc = context.read<HomeBloc>();
    final messenger = ScaffoldMessenger.of(context);
    final bottomInset = MediaQuery.of(context).size.height * 0.1;

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
                    ? userAccounts.where((a) => a.id == selectedAccountId).firstOrNull?.currentBalance ?? 0
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onChanged: (_) => setDialogState(() {}),
                      ),
                      if (selectedAccountBalance > 0) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Balance: ₹${selectedAccountBalance.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const Text('Pay from account:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      if (snapshot.connectionState != ConnectionState.done)
                        const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2)))
                      else if (userAccounts.isEmpty)
                        Text('No accounts available', style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant))
                      else
                        RadioGroup<String>(
                          groupValue: selectedAccountId,
                          onChanged: (v) {
                            setDialogState(() {
                              selectedAccountId = v;
                              selectedAccountName = userAccounts.firstWhere((a) => a.id == v).accountName;
                            });
                          },
                          child: Column(
                            children: userAccounts.map((a) => ListTile(
                              leading: Radio<String>(value: a.id),
                              title: Text(a.accountName, style: const TextStyle(fontSize: 14)),
                              subtitle: Text('₹${a.currentBalance.toStringAsFixed(0)}', style: const TextStyle(fontSize: 12)),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                setDialogState(() {
                                  selectedAccountId = a.id;
                                  selectedAccountName = a.accountName;
                                });
                              },
                            )).toList(),
                          ),
                        ),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    FilledButton(
                      onPressed: () async {
                        final settleAmount = double.tryParse(controller.text.trim()) ?? 0;
                        if (settleAmount <= 0) {
                          messenger.showSnackBar(SnackBar(
                            content: const Text('Enter a valid amount'),
                            behavior: SnackBarBehavior.floating,
                          ));
                          return;
                        }
                        if (settleAmount > amount) {
                          messenger.showSnackBar(SnackBar(
                            content: Text('Amount cannot exceed ₹${amount.toStringAsFixed(0)}'),
                            behavior: SnackBarBehavior.floating,
                          ));
                          return;
                        }
                        if (selectedAccountId == null) {
                          messenger.showSnackBar(SnackBar(
                            content: const Text('Select an account to pay from'),
                            behavior: SnackBarBehavior.floating,
                          ));
                          return;
                        }
                        if (settleAmount > selectedAccountBalance) {
                          messenger.showSnackBar(SnackBar(
                            content: Text('Insufficient balance in $selectedAccountName (₹${selectedAccountBalance.toStringAsFixed(0)})'),
                            behavior: SnackBarBehavior.floating,
                          ));
                          return;
                        }

                        await sl<SettleDebtUsecase>()(
                          fromUserId: fromUserId,
                          toUserId: toUserId,
                          amount: settleAmount,
                          fromAccountId: selectedAccountId,
                        );

                        if (!ctx.mounted) return;
                        Navigator.pop(ctx);
                        messenger.showSnackBar(SnackBar(
                          content: Text('Settled successfully from $selectedAccountName'),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: bottomInset),
                        ));
                        homeBloc.add(const HomeEvent.loadDashboard());
                      },
                      child: const Text('Settle'),
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
