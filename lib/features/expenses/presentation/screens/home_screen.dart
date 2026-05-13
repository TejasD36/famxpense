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
                    context.read<HomeBloc>().add(const HomeEvent.loadDashboard());
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
