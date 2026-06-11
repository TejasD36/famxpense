import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final Set<String> _expandedIds = {};

  @override
  void initState() {
    super.initState();
    context.read<ActivityBloc>().add(const ActivityEvent.loadExpenses());
    sl<RefreshNotifier>().addListener(_onDataChanged);
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_onDataChanged);
    super.dispose();
  }

  void _onDataChanged() {
    if (mounted) {
      context.read<ActivityBloc>().add(const ActivityEvent.loadExpenses());
    }
  }

  String? _nickname(String userId) {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname;
  }

  double _userShare(String currentUserId, ExpenseEntity expense) {
    if (expense.expenseType == ExpenseType.personal) return expense.amount;
    final participant = expense.participants.where((p) => p.userId == currentUserId).firstOrNull;
    return participant?.amount ?? 0;
  }

  Widget _buildExpenseCard(ExpenseEntity expense, String? userId) {
    final isExpanded = _expandedIds.contains(expense.id);
    final shareAmount = userId != null ? _userShare(userId, expense) : expense.amount;
    final isPayer = userId != null && expense.paidByUserId == userId;
    final paidByNickname = _nickname(expense.paidByUserId) ?? expense.paidByUserId;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(expense.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: expense.expenseType == ExpenseType.shared ? Icons.groups_rounded : Icons.person_rounded,
                iconColor: expense.expenseType == ExpenseType.shared ? Colors.orange : Colors.green,
                title: expense.title,
                date: expense.expenseDate,
                amount: shareAmount,
                badge: expense.expenseType.name.toUpperCase(),
                badgeColor: expense.expenseType == ExpenseType.shared ? Colors.orange : Colors.green,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.paypal_rounded, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Text(
                            isPayer ? 'Paid by You' : 'Paid by @$paidByNickname',
                            style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                      if (expense.expenseType == ExpenseType.shared) ...[
                        const SizedBox(height: 8),
                        Text('Split', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 6),
                        ...expense.participants.map((p) {
                          final pNickname = _nickname(p.userId) ?? p.userId;
                          final isMe = p.userId == userId;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Icon(isMe ? Icons.person_rounded : Icons.person_outline_rounded, size: 16),
                                const SizedBox(width: 6),
                                Expanded(child: Text(isMe ? 'You' : '@$pNickname', style: const TextStyle(fontSize: 13))),
                                Text('₹${p.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          );
                        }),
                      ],
                      const SizedBox(height: 6),
                      Text('Total: ₹${expense.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettlementCard(SettlementItem item, String? userId) {
    final s = item.settlement;
    final isExpanded = _expandedIds.contains(s.id);
    final isPayer = s.fromUserId == userId;
    final otherId = isPayer ? s.toUserId : s.fromUserId;
    final otherNickname = _nickname(otherId) ?? otherId;
    final title = isPayer ? 'Settlement to @$otherNickname' : 'Settlement from @$otherNickname';

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(s.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                icon: Icons.swap_horiz_rounded,
                iconColor: Colors.blue,
                title: title,
                date: s.createdAt,
                amount: s.amount,
                badge: 'SETTLEMENT',
                badgeColor: Colors.blue,
                isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Theme.of(context).dividerColor),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_rounded, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Text(
                            isPayer ? 'Paid to @$otherNickname' : 'Received from @$otherNickname',
                            style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                      if (item.depositAccountName != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.account_balance_wallet_rounded, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Text(
                              'Deposited to ${item.depositAccountName}',
                              style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardHeader({
    required IconData icon,
    required MaterialColor iconColor,
    required String title,
    required DateTime date,
    required double amount,
    required String badge,
    required MaterialColor badgeColor,
    required bool isExpanded,
  }) {
    return Row(
      children: [
        Container(
          height: 48, width: 48,
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(
                DateFormat('dd MMM yyyy').format(date),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('₹${amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(badge, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(width: 4),
        AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(padding: const EdgeInsets.symmetric(horizontal: 13.0), child: const Text('Activity')),
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(child: CircularProgressIndicator()),
            empty: () => const Center(child: Text('No expenses yet')),
            error: (message) => Center(child: Text(message)),
            loaded: (items) {
              final userId = sl<AuthLocalDatasource>().getUserId();
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  if (item is ExpenseItem) {
                    return _buildExpenseCard(item.expense, userId);
                  } else if (item is SettlementItem) {
                    return _buildSettlementCard(item, userId);
                  }
                  return const SizedBox();
                },
              );
            },
          );
        },
      ),
    );
  }
}

extension on Set<String> {
  void toggle(String id) {
    if (contains(id)) {
      remove(id);
    } else {
      add(id);
    }
  }
}
