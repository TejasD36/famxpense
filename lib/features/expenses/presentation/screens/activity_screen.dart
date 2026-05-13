import '../../xcore.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ActivityBloc>().add(const ActivityEvent.loadExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),

      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),

            loading: () => const Center(child: CircularProgressIndicator()),

            empty: () => const Center(child: Text('No expenses yet')),

            error: (message) => Center(child: Text(message)),

            loaded: (expenses) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),

                itemCount: expenses.length,

                separatorBuilder: (_, __) => const SizedBox(height: 12),

                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Card(
                    elevation: 0,

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,

                            decoration: BoxDecoration(
                              color: expense.expenseType == ExpenseType.shared
                                  ? Colors.orange.withValues(alpha: 0.15)
                                  : Colors.green.withValues(alpha: 0.15),

                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: Icon(expense.expenseType == ExpenseType.shared ? Icons.groups_rounded : Icons.person_rounded),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(expense.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                                const SizedBox(height: 4),

                                Text(
                                  DateFormat('dd MMM yyyy').format(expense.expenseDate),

                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Text(
                                '₹${expense.amount.toStringAsFixed(0)}',

                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 4),

                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                                decoration: BoxDecoration(
                                  color: expense.expenseType == ExpenseType.shared
                                      ? Colors.orange.withValues(alpha: 0.15)
                                      : Colors.green.withValues(alpha: 0.15),

                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Text(
                                  expense.expenseType.name.toUpperCase(),

                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
