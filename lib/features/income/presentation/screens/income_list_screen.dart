import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class IncomeListScreen extends StatefulWidget {
  const IncomeListScreen({super.key});

  @override
  State<IncomeListScreen> createState() => _IncomeListScreenState();
}

class _IncomeListScreenState extends State<IncomeListScreen> {
  List<IncomeEntity> _incomes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    sl<RefreshNotifier>().addListener(_refresh);
    _load();
  }

  @override
  void dispose() {
    sl<RefreshNotifier>().removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => _load();

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final userId = sl<AuthLocalDatasource>().getUserId();
      if (userId == null) {
        if (!mounted) return;
        setState(() { _loading = false; });
        return;
      }
      final all = await sl<IncomeRepository>().getAllIncomes();
      if (!mounted) return;
      setState(() {
        _incomes = all.where((i) => i.userId == userId).toList();
        _loading = false;
      });
    } catch (e) {
      AppLogger.error('Income load failed', e);
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load incomes. Pull down to retry.';
        _loading = false;
      });
    }
  }

  void _addIncome(IncomeEntity income) async {
    await sl<IncomeRepository>().addIncome(income);
    sl<RefreshNotifier>().notifyDataChanged();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(_error!, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ),
                )
              : _incomes.isEmpty
                  ? const Center(child: Text('No income recorded yet'))
                  : _buildList(),
    );
  }

  Widget _buildList() {
    final grouped = <String, List<IncomeEntity>>{};
    for (final income in _incomes) {
      final key = DateFormat('MMMM yyyy').format(income.createdAt);
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(income);
    }
    final sortedKeys = grouped.keys.toList()..sort((a, b) {
      final da = DateFormat('MMMM yyyy').parse(a);
      final db = DateFormat('MMMM yyyy').parse(b);
      return db.compareTo(da);
    });

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sortedKeys.length,
        itemBuilder: (context, i) {
          final key = sortedKeys[i];
          final items = grouped[key]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              ...items.map((income) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                    child: Icon(income.source.icon, color: Theme.of(context).colorScheme.primary),
                  ),
                  title: Text(income.description, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${income.source.label} · ${_formatDate(income.createdAt)}'),
                  trailing: Text(formatIndianRupee(income.amount), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return DateFormat('d MMM').format(d.toLocal());
  }

  void _showAddSheet(BuildContext context) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;

    final amountCtl = TextEditingController();
    final descCtl = TextEditingController();
    var selectedSource = IncomeSource.salary;
    String? selectedAccountId;
    var selectedDate = DateTime.now();
    var accountsLoaded = false;
    var accountLoadError = false;
    var accountList = <AccountEntity>[];

    sl<AccountRepository>().getAccounts(userId: userId).then((list) async {
      accountList = list.where((a) => !a.isArchived).toList();
      if (accountList.isNotEmpty) {
        final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
        selectedAccountId = defaultId != null && accountList.any((a) => a.id == defaultId)
            ? defaultId
            : accountList.first.id;
      }
      accountsLoaded = true;
    }).catchError((_) {
      accountsLoaded = true;
      accountLoadError = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          void setVal(VoidCallback fn) => setSheetState(fn);

          return Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(ctx).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Add Income', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                TextField(
                  controller: amountCtl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount (₹)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<IncomeSource>(
                  initialValue: selectedSource,
                  decoration: InputDecoration(
                    labelText: 'Source',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: IncomeSource.values.map((s) => DropdownMenuItem(
                    value: s,
                    child: Row(
                      children: [
                        Icon(s.icon, size: 20),
                        const SizedBox(width: 8),
                        Text(s.label),
                      ],
                    ),
                  )).toList(),
                  onChanged: (v) => setVal(() => selectedSource = v ?? IncomeSource.other),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: descCtl,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),

                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setVal(() => selectedDate = picked);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      suffixIcon: const Icon(Icons.calendar_month_rounded),
                    ),
                    child: Text(DateFormat('d MMM yyyy').format(selectedDate)),
                  ),
                ),
                const SizedBox(height: 12),

                if (!accountsLoaded)
                  const LinearProgressIndicator()
                else if (accountLoadError)
                  Text('Failed to load accounts', style: TextStyle(color: Theme.of(ctx).colorScheme.error))
                else if (accountList.isEmpty)
                  const Text('No accounts found. Create one first.', style: TextStyle(color: Colors.grey))
                else
                  DropdownButtonFormField<String>(
                    key: ValueKey(selectedAccountId),
                    initialValue: selectedAccountId,
                    decoration: InputDecoration(
                      labelText: 'Deposit to Account',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: accountList.map((a) => DropdownMenuItem(
                      value: a.id,
                      child: Text(a.accountName),
                    )).toList(),
                    onChanged: (v) => setVal(() => selectedAccountId = v),
                  ),
                const SizedBox(height: 20),

                FilledButton(
                  onPressed: () async {
                    final raw = amountCtl.text.trim();
                    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
                    final amount = double.tryParse(cleaned);
                    if (amount == null || amount <= 0 || amount > 999999999) {
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Enter a valid amount')));
                      }
                      return;
                    }
                    if (selectedAccountId == null) {
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Select an account')));
                      }
                      return;
                    }
                    final desc = descCtl.text.trim().isEmpty ? 'Income: ${selectedSource.label}' : descCtl.text.trim();

                    final now = DateTime.now().toUtc();
                    final income = IncomeEntity(
                      id: const Uuid().v4(),
                      userId: userId,
                      accountId: selectedAccountId!,
                      amount: amount,
                      source: selectedSource,
                      description: desc,
                      createdAt: selectedDate.toUtc(),
                      updatedAt: now,
                    );

                    if (ctx.mounted) Navigator.pop(ctx);
                    _addIncome(income);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
