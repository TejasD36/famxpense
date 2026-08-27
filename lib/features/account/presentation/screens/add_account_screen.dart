import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _goalController = TextEditingController();
  AccountType _selectedType = AccountType.bank;
  bool _isSavings = false;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final name = _nameController.text.trim();
    final balance = double.tryParse(_balanceController.text.trim()) ?? 0;

    if (name.isEmpty) return;

    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;

    setState(() => _saving = true);
    try {
      final repository = sl<AccountRepository>();
      final hadAccounts = (await repository.getAccounts(
        userId: userId,
      )).isNotEmpty;
      final now = DateTime.now().toUtc();
      final account = AccountEntity(
        id: const Uuid().v4(),
        userId: userId,
        accountName: name,
        accountType: _selectedType,
        currentBalance: balance,
        createdAt: now,
        updatedAt: now,
        isSavings: _isSavings,
        monthlySavingsGoal: _isSavings
            ? double.tryParse(_goalController.text.trim()) ?? 0
            : 0,
      );

      await repository.saveAccount(account);
      if (!hadAccounts) {
        await AppSettings.setDefaultAccountId(
          userId: userId,
          accountId: account.id,
        );
      }
      sl<RefreshNotifier>().notifyDataChanged();

      if (!mounted) return;
      Navigator.of(context).pop(account);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save account: $error')));
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Account')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 560;
          return ListView(
            padding: EdgeInsets.fromLTRB(
              wide ? 32 : 16,
              12,
              wide ? 32 : 16,
              24,
            ),
            children: [
              GradientPatternPanel(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        _isSavings
                            ? Icons.savings_rounded
                            : Icons.account_balance_wallet_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isSavings ? 'Savings account' : 'Money account',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isSavings
                                ? 'Track monthly savings progress from this account.'
                                : 'Track balance, spends, income, and transfers.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  hintText: 'e.g. HDFC Savings, Cash Wallet',
                ),
              ),
              const SizedBox(height: 12),
              _ResponsiveFieldRow(
                wide: wide,
                children: [
                  DropdownButtonFormField<AccountType>(
                    initialValue: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Account Type',
                    ),
                    items: AccountType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name),
                      );
                    }).toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedType = v);
                    },
                  ),
                  TextField(
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Current Balance (₹)',
                      hintText: '0',
                      prefixText: '₹ ',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 2,
                  ),
                  secondary: const Icon(Icons.savings_rounded),
                  title: const Text('Savings account'),
                  subtitle: const Text('Enable monthly goal tracking'),
                  value: _isSavings,
                  onChanged: (v) => setState(() => _isSavings = v),
                ),
              ),
              if (_isSavings) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _goalController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Monthly Savings Goal (₹)',
                    hintText: '0',
                    prefixText: '₹ ',
                  ),
                ),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _saving ? null : _submit,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(_saving ? 'Saving' : 'Save Account'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ResponsiveFieldRow extends StatelessWidget {
  final bool wide;
  final List<Widget> children;

  const _ResponsiveFieldRow({required this.wide, required this.children});

  @override
  Widget build(BuildContext context) {
    if (!wide) {
      return Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            children[i],
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
