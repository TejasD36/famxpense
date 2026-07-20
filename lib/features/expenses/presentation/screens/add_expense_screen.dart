import 'dart:async';

import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/presentation/widgets/account_picker_sheet.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../../partners/data/transformers/mappers/partnership_remote_mapper.dart';
import '../../xcore.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  ExpenseType _expenseType = ExpenseType.personal;
  SplitType _splitType = SplitType.equal;
  String? _category = ExpenseCategory.other.name;

  AccountEntity? _selectedAccount;
  List<AccountEntity> _accounts = [];
  List<PartnershipEntity> _connectedPartners = [];
  List<PartnershipEntity> _selectedPartners = [];
  final Map<String, double> _manualAmounts = {};
  final Map<String, TextEditingController> _manualControllers = {};

  bool _amountExceedsBalance = false;
  bool _forceSubmit = false;

  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;

    final accountDtos = await sl<AccountLocalDatasource>().getAccounts();
    final userAccounts = accountDtos.where((a) => a.userId == userId && !a.isArchived).map((d) => d.toEntity()).toList();

    final partnershipDtos = await sl<PartnershipRemoteDatasource>().getPartnerships(userId: userId);
    final connected = partnershipDtos
        .where((p) => PartnershipStatus.values.any((e) => e.name == p.status && e == PartnershipStatus.accepted))
        .map((d) => d.toEntity())
        .toList();

    AccountEntity? selected;
    if (userAccounts.isNotEmpty) {
      final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
      selected = defaultId != null
          ? userAccounts.where((a) => a.id == defaultId).firstOrNull
          : userAccounts.first;
    }

    if (mounted) {
      setState(() {
        _accounts = userAccounts;
        _connectedPartners = connected;
        _selectedAccount = selected;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _noteController.dispose();
    for (final c in _manualControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _checkBalance() {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (_selectedAccount != null && amount > _selectedAccount!.currentBalance) {
      setState(() => _amountExceedsBalance = true);
    } else {
      setState(() => _amountExceedsBalance = false);
    }
  }

  Future<void> _getCurrentLocation() async {
    final locationService = sl<LocationService>();
    final position = await locationService.getCurrentPosition();
    if (!mounted) return;
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Could not get location. Check location permissions.'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      ));
    }
  }

  void _clearLocation() {
    setState(() {
      _latitude = null;
      _longitude = null;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please fill all required fields (Title and Amount)'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      ));
      return;
    }

    final authState = context.read<AuthBloc>().state;
    String? userId;
    authState.whenOrNull(
      authenticated: (user) {
        userId = user.id;
      },
    );

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('User not found'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      ));
      return;
    }

    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    final currentUserId = userId!;

    /// Shared expense with no partners
    if (_expenseType == ExpenseType.shared && _selectedPartners.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('No partner selected for shared expense. Switch to Personal or add a partner.'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      ));
      return;
    }

    /// Balance check
    if (_selectedAccount != null && amount > _selectedAccount!.currentBalance && !_forceSubmit) {
      setState(() => _amountExceedsBalance = true);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Insufficient balance. Tick "Add anyway" to proceed.'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      ));
      return;
    }

    /// Build participants
    if (_expenseType == ExpenseType.shared && _splitType == SplitType.manual) {
      final participantIds = <String>[currentUserId];
      for (final p in _selectedPartners) {
        participantIds.add(_partnerUserId(p, currentUserId));
      }
      final autoId = participantIds.length > 1 ? participantIds.last : null;
      if (autoId != null) {
        final sumOthers = _manualAmounts.entries
            .where((e) => e.key != autoId)
            .fold(0.0, (s, e) => s + e.value);
        _manualAmounts[autoId] = amount - sumOthers;
      }
      final manualTotal = _manualAmounts.values.fold(0.0, (a, b) => a + b);
      if ((manualTotal - amount).abs() > 0.01) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Total shares ${formatIndianRupee(manualTotal)} ≠ ${formatIndianRupee(amount)}'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        ));
        return;
      }
      for (final entry in _manualAmounts.entries) {
        if (entry.value < 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Shares cannot be negative'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          ));
          return;
        }
        if (entry.value > amount) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('A participant share cannot exceed the total amount'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
          ));
          return;
        }
      }
    }

    final participants = <ExpenseParticipantEntity>[
      ExpenseParticipantEntity(userId: currentUserId, amount: _computeShare(amount, currentUserId)),
      ..._selectedPartners.map((p) {
        final partnerId = p.senderId == currentUserId ? p.receiverId : p.senderId;
        return ExpenseParticipantEntity(userId: partnerId, amount: _computeShare(amount, partnerId));
      }),
    ];

    final expense = ExpenseEntity(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      amount: amount,
      paidByUserId: currentUserId,
      ownerUserId: currentUserId,
      expenseType: _expenseType,
      splitType: _splitType,
      participants: participants,
      accountId: _selectedAccount?.id,
      category: _category,
      expenseDate: _selectedDate,
      createdAt: DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      syncStatus: SyncStatus.pending,
      latitude: _latitude,
      longitude: _longitude,
    );
    context.read<AddExpenseBloc>().add(AddExpenseEvent.submit(expense));
  }

  double _computeShare(double total, String userId) {
    if (_expenseType != ExpenseType.shared) return total;
    if (_splitType == SplitType.equal) {
      final totalPeople = 1 + _selectedPartners.length;
      return (total / totalPeople).roundToDouble();
    }
    return _manualAmounts[userId] ?? 0;
  }

  String _categoryLabel(ExpenseCategory c) {
    return switch (c) {
      ExpenseCategory.food => 'Food',
      ExpenseCategory.grocery => 'Grocery',
      ExpenseCategory.clothes => 'Clothes',
      ExpenseCategory.essentials => 'Essentials',
      ExpenseCategory.medical => 'Medical',
      ExpenseCategory.snacks => 'Snacks',
      ExpenseCategory.lunch => 'Lunch',
      ExpenseCategory.dinner => 'Dinner',
      ExpenseCategory.movie => 'Movie',
      ExpenseCategory.traveling => 'Traveling',
      ExpenseCategory.gifts => 'Gifts',
      ExpenseCategory.insurance => 'Insurance',
      ExpenseCategory.emi => 'EMI',
      ExpenseCategory.recharge => 'Recharge',
      ExpenseCategory.electricity => 'Electricity',
      ExpenseCategory.mobileBill => 'Mobile Bill',
      ExpenseCategory.subscription => 'Subscription',
      ExpenseCategory.fruits => 'Fruits',
      ExpenseCategory.other => 'Other',
    };
  }

  void _initManualAmounts() {
    final total = double.tryParse(_amountController.text.trim()) ?? 0;
    final totalPeople = 1 + _selectedPartners.length;
    final perPerson = totalPeople > 0 ? (total / totalPeople).roundToDouble() : 0.0;
    final userId = sl<AuthLocalDatasource>().getUserId();
    _manualAmounts.clear();
    for (final c in _manualControllers.values) {
      c.dispose();
    }
    _manualControllers.clear();

    void setFor(String uid, double val) {
      _manualAmounts[uid] = val;
      _manualControllers[uid] = TextEditingController(text: val.toStringAsFixed(0));
    }

    if (userId != null) setFor(userId, perPerson);
    for (final p in _selectedPartners) {
      final partnerId = _partnerUserId(p, userId);
      setFor(partnerId, perPerson);
    }
  }

  String _partnerUserId(PartnershipEntity p, String? currentUserId) {
    return p.senderId == currentUserId ? p.receiverId : p.senderId;
  }

  double _manualTotal() {
    return _manualAmounts.values.fold(0.0, (a, b) => a + b);
  }

  void _showAccountPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AccountPickerSheet(
        accounts: _accounts,
        selectedAccountId: _selectedAccount?.id,
        onSelected: (account) {
          setState(() {
            _selectedAccount = account;
            _amountExceedsBalance = false;
            _forceSubmit = false;
          });
          _checkBalance();
        },
        onAddNew: () async {
          Navigator.pop(context);
          await context.pushNamed(AppRoute.addAccount.name);
          _loadData();
        },
      ),
    );
  }

  Future<void> _showPartnerPicker() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) {
          final pickerUserId = sl<AuthLocalDatasource>().getUserId();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Split With', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  if (_connectedPartners.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: Text('No connected partners yet')),
                    )
                  else
                    ..._connectedPartners.map((p) {
                      final isSelected = _selectedPartners.any((sp) => sp.id == p.id);
                      final nickname = pickerUserId == p.senderId ? p.receiverNickname : p.senderNickname;
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text('@$nickname'),
                      onChanged: (checked) {
                        setSheetState(() {
                          if (checked == true) {
                            if (!_selectedPartners.any((sp) => sp.id == p.id)) {
                              _selectedPartners.add(p);
                            }
                          } else {
                            _selectedPartners.removeWhere((sp) => sp.id == p.id);
                          }
                        });
                      },
                    );
                  }),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        );
      },
    ),
    );
    if (!mounted) return;
    setState(() {});
    if (_splitType == SplitType.manual) {
      _initManualAmounts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Expense added successfully'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            ));
            context.goNamed(AppRoute.home.name);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            ));
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Expense')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Amount
                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹ ', border: OutlineInputBorder()),
                        onChanged: (_) => _checkBalance(),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter amount';
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) return 'Enter a valid amount greater than 0';
                          if (amount > 999999999) return 'Amount too large';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Category
                      DropdownButtonFormField<String>(
                        initialValue: _category,
                        decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                        items: ExpenseCategory.values.map((c) {
                          return DropdownMenuItem(value: c.name, child: Text(_categoryLabel(c)));
                        }).toList(),
                        onChanged: (v) => setState(() => _category = v),
                      ),
                      const SizedBox(height: 20),

                      /// Account Picker
                      InkWell(
                        onTap: _showAccountPicker,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_rounded),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _selectedAccount == null
                                    ? Text('Select Account', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_selectedAccount!.accountName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                          Text(
                                            formatIndianRupee(_selectedAccount!.currentBalance),
                                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                          ),
                                        ],
                                      ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),

                      /// Balance Warning
                      if (_amountExceedsBalance) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.error),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Account balance is less than this expense amount',
                                  style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _forceSubmit,
                              onChanged: (v) => setState(() => _forceSubmit = v ?? false),
                            ),
                            const Text('Add anyway', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),

                      /// Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Expense Title',
                          hintText: 'Dinner, Petrol, Shopping...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter title';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Note
                      TextFormField(
                        controller: _noteController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(labelText: 'Note (Optional)', border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 24),

                      /// Location
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: _getCurrentLocation,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).dividerColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(_latitude != null ? Icons.location_on_rounded : Icons.add_location_alt_rounded),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _latitude != null ? 'Location captured' : 'Add location',
                                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (_latitude != null) ...[
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: _clearLocation,
                              tooltip: 'Remove location',
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Expense Type
                      const Text('Expense Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      SegmentedButton<ExpenseType>(
                        selected: {_expenseType},
                        onSelectionChanged: (value) {
                          setState(() {
                            _expenseType = value.first;
                            if (_expenseType != ExpenseType.shared) {
                              _selectedPartners = [];
                            }
                          });
                        },
                        segments: const [
                          ButtonSegment(value: ExpenseType.personal, label: Text('Personal')),
                          ButtonSegment(value: ExpenseType.shared, label: Text('Shared')),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Partners (Shared only)
                      if (_expenseType == ExpenseType.shared) ...[
                        const Text('Split With', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: _showPartnerPicker,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).dividerColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.people_rounded),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _selectedPartners.isEmpty
                                      ? Text('Select partners', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                                      : Text('${_selectedPartners.length} partner${_selectedPartners.length > 1 ? 's' : ''} selected'),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),
                        if (_selectedPartners.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: _selectedPartners.map((p) {
                              final chipUserId = sl<AuthLocalDatasource>().getUserId();
                              final nickname = chipUserId == p.senderId ? p.receiverNickname : p.senderNickname;
                              return Chip(
                                label: Text('@$nickname', style: const TextStyle(fontSize: 12)),
                                onDeleted: () {
                                  setState(() {
                                    _selectedPartners.removeWhere((sp) => sp.id == p.id);
                                    if (_splitType == SplitType.manual) {
                                      _initManualAmounts();
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                        const SizedBox(height: 24),

                        /// Split Type
                        const Text('Split Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        SegmentedButton<SplitType>(
                          selected: {_splitType},
                          onSelectionChanged: (value) {
                            setState(() {
                              _splitType = value.first;
                              if (_splitType == SplitType.manual) {
                                _initManualAmounts();
                              }
                            });
                          },
                          segments: const [
                            ButtonSegment(value: SplitType.equal, label: Text('Equal')),
                            ButtonSegment(value: SplitType.manual, label: Text('Manual')),
                          ],
                        ),
                        const SizedBox(height: 24),

                        /// Split Preview
                        if (_selectedPartners.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text('Split Preview', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 12),
                                ..._buildSplitPreview(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ],

                      /// Date
                      InkWell(
                        onTap: _selectDate,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month_rounded),
                              const SizedBox(width: 12),
                              Expanded(child: Text(DateFormat('dd MMM yyyy').format(_selectedDate))),
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      /// Submit
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
                          builder: (context, state) {
                            final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
                            return FilledButton(
                              onPressed: isLoading ? null : _submit,
                              child: isLoading
                                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 3))
                                  : const Text('Save Expense'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSplitPreview() {
    final total = double.tryParse(_amountController.text.trim()) ?? 0;
    final totalPeople = 1 + _selectedPartners.length;
    final perPerson = totalPeople > 0 ? (total / totalPeople).roundToDouble() : 0.0;
    final userId = sl<AuthLocalDatasource>().getUserId();
    final widgets = <Widget>[];

    // Build ordered participant list: [currentUser, partner1, partner2, ...]
    final participantIds = <String>[];
    if (userId != null) participantIds.add(userId);
    for (final p in _selectedPartners) {
      participantIds.add(_partnerUserId(p, userId));
    }

    // The last entry auto-completes
    final autoCompleteId = participantIds.length > 1 ? participantIds.last : null;

    for (int i = 0; i < participantIds.length; i++) {
      final pid = participantIds[i];
      final isAuto = pid == autoCompleteId;

      // For auto-complete entry, compute amount = total - sum of others
      final autoAmount = isAuto && total > 0
          ? total - _manualAmounts.entries
              .where((e) => e.key != pid)
              .fold(0.0, (s, e) => s + e.value)
          : 0.0;

      if (isAuto && autoAmount >= 0) {
        // Update manual amounts for auto-complete
        _manualAmounts[pid] = autoAmount;
        // Update controller text if stale
        final ctrl = _manualControllers[pid];
        if (ctrl != null && ctrl.text != autoAmount.toStringAsFixed(0)) {
          ctrl.text = autoAmount.toStringAsFixed(0);
        }
      }

      final isSelf = pid == userId;
      final partnerEntity = isSelf ? null : _selectedPartners.firstWhere(
        (p) => _partnerUserId(p, userId) == pid,
        orElse: () => _selectedPartners.first,
      );
      final label = isSelf ? 'You' : '@${partnerEntity?.senderNickname ?? pid}';

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(isSelf ? Icons.person_rounded : Icons.person_outline_rounded, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
              if (_splitType == SplitType.equal)
                Text(formatIndianRupee(perPerson), style: const TextStyle(fontWeight: FontWeight.w600))
              else if (isAuto)
                Text(formatIndianRupee(autoAmount), style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey))
              else
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      isDense: true,
                      prefixText: '₹ ',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    ),
                    controller: _manualControllers.putIfAbsent(pid, () {
                      final val = _manualAmounts[pid] ?? perPerson;
                      _manualAmounts[pid] = val;
                      return TextEditingController(text: val.toStringAsFixed(0));
                    }),
                    onChanged: (val) {
                      final parsed = double.tryParse(val.trim());
                      _manualAmounts[pid] = parsed ?? 0;
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    }

    /// Manual total mismatch warning (shouldn't appear due to auto-complete, but keep as safety)
    if (_splitType == SplitType.manual && total > 0) {
      final manualTotal = _manualTotal();
      if ((manualTotal - total).abs() > 0.01) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Total shares ${formatIndianRupee(manualTotal)} ≠ ${formatIndianRupee(total)}',
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}
