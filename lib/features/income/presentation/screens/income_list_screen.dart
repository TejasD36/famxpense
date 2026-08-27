import '../../../account/domain/repositories/account_repository.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../savings/domain/repositories/transfer_repository.dart';
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
        setState(() {
          _loading = false;
        });
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

  Future<void> _addIncome(IncomeEntity income) async {
    await sl<IncomeRepository>().addIncome(income);
    sl<RefreshNotifier>().notifyDataChanged();
    await _load();
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
                child: FinanceEmptyState(
                  icon: Icons.error_outline_rounded,
                  title: 'Could not load income',
                  subtitle: _error!,
                  action: OutlinedButton.icon(
                    onPressed: _load,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                  ),
                ),
              ),
            )
          : _incomes.isEmpty
          ? FinanceEmptyState(
              icon: Icons.account_balance_rounded,
              title: 'No income recorded yet',
              subtitle:
                  'Add salary, business income, deposits, or other money coming in.',
              showLottie: true,
              action: FilledButton.icon(
                onPressed: () => _showAddSheet(context),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Income'),
              ),
            )
          : _buildList(),
    );
  }

  Widget _buildList() {
    final grouped = <String, List<IncomeEntity>>{};
    for (final income in _incomes) {
      final key = DateFormat('MMMM yyyy').format(income.createdAt.toLocal());
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(income);
    }
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final da = DateFormat('MMMM yyyy').parse(a);
        final db = DateFormat('MMMM yyyy').parse(b);
        return db.compareTo(da);
      });

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _IncomeSummaryPanel(incomes: _incomes),
          const SizedBox(height: 14),
          for (final key in sortedKeys) ...[
            CompactSectionHeader(title: key),
            ...grouped[key]!.map(
              (income) => CompactInfoTile(
                icon: income.source.icon,
                title: income.description,
                subtitle:
                    '${income.source.label} · ${formatRelativeCalendarDate(income.createdAt)}',
                color: Colors.green,
                trailing: Text(
                  formatIndianRupee(income.amount),
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;

    final amountCtl = TextEditingController();
    final descCtl = TextEditingController();
    final savingsAmountCtl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var selectedSource = IncomeSource.salary;
    String? selectedAccountId;
    var selectedDate = DateTime.now();
    var accountsLoaded = false;
    var accountLoadError = false;
    var accountList = <AccountEntity>[];
    var savingsAccounts = <AccountEntity>[];
    var transferToSavings = false;
    var selectedSavingsId = <String>{};
    var accountsLoadStarted = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          void setVal(VoidCallback fn) => setSheetState(fn);

          if (!accountsLoadStarted) {
            accountsLoadStarted = true;
            sl<AccountRepository>()
                .getAccounts(userId: userId)
                .then((list) async {
                  accountList = list
                      .where((a) => !a.isArchived && !a.isSavings)
                      .toList();
                  savingsAccounts = list.where((a) => a.isSavings).toList();
                  if (savingsAccounts.length == 1 &&
                      selectedSavingsId.isEmpty) {
                    selectedSavingsId = {savingsAccounts.first.id};
                  }
                  if (accountList.isNotEmpty && selectedAccountId == null) {
                    final defaultId = await AppSettings.getDefaultAccountId(
                      userId: userId,
                    );
                    selectedAccountId =
                        defaultId != null &&
                            accountList.any((a) => a.id == defaultId)
                        ? defaultId
                        : accountList.first.id;
                  }
                  accountsLoaded = true;
                  setVal(() {});
                })
                .catchError((_) {
                  accountsLoaded = true;
                  accountLoadError = true;
                  setVal(() {});
                });
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              10,
              16,
              MediaQuery.of(ctx).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SheetGrabber(),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Add Income',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          selectedSource.icon,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    TextFormField(
                      controller: amountCtl,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Amount (₹)',
                      ),
                      validator: (v) {
                        final cleaned = (v ?? '').replaceAll(
                          RegExp(r'[^0-9.]'),
                          '',
                        );
                        final amt = double.tryParse(cleaned);
                        if (amt == null || amt <= 0) {
                          return 'Enter a valid amount';
                        }
                        if (amt > 999999999) return 'Amount too large';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<IncomeSource>(
                      initialValue: selectedSource,
                      decoration: const InputDecoration(labelText: 'Source'),
                      items: IncomeSource.values
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Row(
                                children: [
                                  Icon(s.icon, size: 20),
                                  const SizedBox(width: 8),
                                  Text(s.label),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setVal(
                        () => selectedSource = v ?? IncomeSource.other,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: descCtl,
                      decoration: const InputDecoration(
                        labelText: 'Description',
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
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          suffixIcon: Icon(Icons.calendar_month_rounded),
                        ),
                        child: Text(
                          DateFormat('d MMM yyyy').format(selectedDate),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    if (!accountsLoaded)
                      const LinearProgressIndicator()
                    else if (accountLoadError)
                      Text(
                        'Failed to load accounts',
                        style: TextStyle(
                          color: Theme.of(ctx).colorScheme.error,
                        ),
                      )
                    else if (accountList.isEmpty)
                      Text(
                        'No accounts found. Create one first.',
                        style: TextStyle(
                          color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                        ),
                      )
                    else
                      DropdownButtonFormField<String>(
                        key: ValueKey(selectedAccountId),
                        initialValue: selectedAccountId,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Deposit to Account',
                        ),
                        validator: (v) =>
                            v == null ? 'Select an account' : null,
                        items: accountList
                            .map(
                              (a) => DropdownMenuItem(
                                value: a.id,
                                child: Text(a.accountName),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setVal(() => selectedAccountId = v),
                      ),
                    if (accountsLoaded && savingsAccounts.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 0,
                          ),
                          title: const Text(
                            'Transfer to savings',
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: const Text(
                            'Allocate part of this income',
                            style: TextStyle(fontSize: 12),
                          ),
                          value: transferToSavings,
                          onChanged: (v) => setVal(() {
                            transferToSavings = v ?? false;
                            if (!transferToSavings) {
                              selectedSavingsId = {};
                              savingsAmountCtl.clear();
                            }
                          }),
                        ),
                      ),
                      if (transferToSavings) ...[
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          key: ValueKey(
                            selectedSavingsId.isNotEmpty
                                ? selectedSavingsId.first
                                : null,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'To Savings Account',
                            errorStyle: TextStyle(fontSize: 12),
                          ),
                          validator: (v) =>
                              v == null ? 'Select a savings account' : null,
                          items: savingsAccounts
                              .map(
                                (a) => DropdownMenuItem(
                                  value: a.id,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.savings_rounded,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(a.accountName),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          initialValue: selectedSavingsId.isNotEmpty
                              ? selectedSavingsId.first
                              : null,
                          onChanged: (v) => setVal(() {
                            if (v != null) selectedSavingsId = {v};
                          }),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: savingsAmountCtl,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Amount to transfer (₹)',
                            hintText: 'Enter amount to allocate to savings',
                            errorStyle: TextStyle(fontSize: 12),
                          ),
                          validator: (v) {
                            if (!transferToSavings) return null;
                            final cleaned = (v ?? '').replaceAll(
                              RegExp(r'[^0-9.]'),
                              '',
                            );
                            final amt = double.tryParse(cleaned);
                            if (amt == null || amt <= 0) {
                              return 'Enter a valid transfer amount';
                            }
                            final raw = amountCtl.text.trim();
                            final incomeAmt = double.tryParse(
                              raw.replaceAll(RegExp(r'[^0-9.]'), ''),
                            );
                            if (incomeAmt != null && amt > incomeAmt) {
                              return 'Transfer amount cannot exceed income amount';
                            }
                            return null;
                          },
                        ),
                      ],
                    ],
                    const SizedBox(height: 16),

                    FilledButton.icon(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        if (selectedAccountId == null) return;

                        final raw = amountCtl.text.trim();
                        final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
                        final amount = double.tryParse(cleaned)!;

                        final desc = descCtl.text.trim().isEmpty
                            ? 'Income: ${selectedSource.label}'
                            : descCtl.text.trim();

                        final now = DateTime.now().toUtc();
                        final incomeId = const Uuid().v4();
                        final income = IncomeEntity(
                          id: incomeId,
                          userId: userId,
                          accountId: selectedAccountId!,
                          amount: amount,
                          source: selectedSource,
                          description: desc,
                          createdAt: selectedDate.toUtc(),
                          updatedAt: now,
                        );

                        final transferAmount =
                            transferToSavings && selectedSavingsId.isNotEmpty
                            ? (double.tryParse(
                                        savingsAmountCtl.text.replaceAll(
                                          RegExp(r'[^0-9.]'),
                                          '',
                                        ),
                                      ) ??
                                      0)
                                  .clamp(0.0, amount)
                            : 0.0;

                        await _addIncome(income);

                        if (transferAmount > 0) {
                          final toSavingsId = selectedSavingsId.first;
                          await sl<TransferRepository>().saveTransfer(
                            TransferDto(
                              id: const Uuid().v4(),
                              fromAccountId: selectedAccountId!,
                              toAccountId: toSavingsId,
                              fromUserId: userId,
                              toUserId: userId,
                              amount: transferAmount,
                              description:
                                  'Savings allocation from ${desc.isNotEmpty ? desc : selectedSource.label}',
                              createdAt: now,
                              updatedAt: now,
                            ),
                          );
                          sl<RefreshNotifier>().notifyDataChanged();
                        }

                        if (ctx.mounted) Navigator.pop(ctx);
                      },
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add Income'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _IncomeSummaryPanel extends StatelessWidget {
  final List<IncomeEntity> incomes;

  const _IncomeSummaryPanel({required this.incomes});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final thisMonth = incomes.where(
      (income) =>
          income.createdAt.year == now.year &&
          income.createdAt.month == now.month,
    );
    final monthTotal = thisMonth.fold<double>(
      0,
      (total, i) => total + i.amount,
    );
    final total = incomes.fold<double>(0, (total, i) => total + i.amount);

    return GradientPatternPanel(
      padding: const EdgeInsets.all(14),
      child: MoneyMetricStrip(
        metrics: [
          MoneyMetric(
            label: 'This month',
            value: formatIndianRupee(monthTotal),
            color: Colors.green,
            icon: Icons.trending_up_rounded,
          ),
          MoneyMetric(
            label: 'All income',
            value: formatIndianRupee(total),
            color: Theme.of(context).colorScheme.primary,
            icon: Icons.account_balance_wallet_rounded,
          ),
        ],
      ),
    );
  }
}
