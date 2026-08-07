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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Account Name',
              hintText: 'e.g. HDFC Savings, Cash Wallet',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<AccountType>(
            initialValue: _selectedType,
            decoration: InputDecoration(
              labelText: 'Account Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            items: AccountType.values.map((type) {
              return DropdownMenuItem(value: type, child: Text(type.name));
            }).toList(),
            onChanged: (v) {
              if (v != null) setState(() => _selectedType = v);
            },
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Current Balance (₹)',
              hintText: '0',
              prefixText: '₹ ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mark as savings account'),
            subtitle: const Text('Savings accounts track monthly goals'),
            value: _isSavings,
            onChanged: (v) => setState(() => _isSavings = v),
          ),
          if (_isSavings) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Savings Goal (₹)',
                hintText: '0',
                prefixText: '₹ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _saving ? null : _submit,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(_saving ? 'Saving…' : 'Save Account'),
          ),
        ],
      ),
    );
  }
}
