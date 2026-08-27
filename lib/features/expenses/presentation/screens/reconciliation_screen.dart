import '../../../../core.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';

class ReconciliationScreen extends StatefulWidget {
  const ReconciliationScreen({super.key});

  @override
  State<ReconciliationScreen> createState() => _ReconciliationScreenState();
}

class _ReconciliationScreenState extends State<ReconciliationScreen> {
  late Future<ReconciliationSnapshot> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
    _future = sl<ReconciliationService>().load(userId: userId);
  }

  Future<void> _retry() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;
    await sl<SyncService>().syncAll(userId: userId);
    if (!mounted) return;
    setState(_reload);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sync health')),
      body: SafeArea(
        child: FutureBuilder<ReconciliationSnapshot>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final health = snapshot.data!;
            final counts = health.counts;
            final healthy = counts.isEmpty && health.lastResult != false;
            return RefreshIndicator(
              onRefresh: () async => setState(_reload),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Icon(
                            healthy
                                ? Icons.cloud_done_rounded
                                : Icons.sync_problem_rounded,
                            color: healthy
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                            size: 30,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  healthy
                                      ? 'Everything is up to date'
                                      : '${counts.total} operations need attention',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _resultDescription(health),
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Pending operations',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _OperationRow(label: 'Expenses', count: counts.expenses),
                  _OperationRow(label: 'Income', count: counts.income),
                  _OperationRow(label: 'Transfers', count: counts.transfers),
                  _OperationRow(
                    label: 'Settlements',
                    count: counts.settlements,
                  ),
                  _OperationRow(
                    label: 'Savings snapshots',
                    count: counts.savingsSnapshots,
                  ),
                  _OperationRow(
                    label: 'Account mutations',
                    count: counts.accountMutations,
                  ),
                  _OperationRow(
                    label: 'Debt mutations',
                    count: counts.debtMutations,
                  ),
                  _OperationRow(
                    label: 'Manual deposits',
                    count: counts.manualDeposits,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.sync_rounded),
                    label: const Text('Retry sync'),
                  ),
                  const SizedBox(height: 18),
                  Text(_timeLabel('Last attempt', health.lastAttempt)),
                  Text(_timeLabel('Last successful sync', health.lastSuccess)),
                  if (counts.total > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        'Pending records remain visible locally. Retry only uploads them; it does not change or repair financial records.',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _resultDescription(ReconciliationSnapshot health) {
    if (health.lastResult == false) {
      return 'The last sync finished with failures.';
    }
    if (health.counts.isEmpty) return 'No pending local operations.';
    return 'Local changes are waiting for a successful sync.';
  }

  String _timeLabel(String label, DateTime? value) =>
      '$label: ${value == null ? 'Not yet recorded' : DateFormat('d MMM yyyy, h:mm a').format(value.toLocal())}';
}

class _OperationRow extends StatelessWidget {
  final String label;
  final int count;
  const _OperationRow({required this.label, required this.count});

  @override
  Widget build(BuildContext context) => ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    leading: Icon(
      count == 0 ? Icons.check_circle_outline : Icons.schedule_rounded,
      size: 20,
      color: count == 0
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.error,
    ),
    title: Text(label),
    trailing: Text(
      '$count',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
