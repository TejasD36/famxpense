import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../account/data/datasources/account_local_datasource.dart';
import '../../../account/presentation/widgets/account_picker_sheet.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../partners/data/datasources/remote/partnership_remote_datasource.dart';
import '../../../partners/data/transformers/mappers/partnership_remote_mapper.dart';
import '../../xcore.dart';

class AddExpenseScreen extends StatefulWidget {
  final ExpenseEntity? editExpense;

  const AddExpenseScreen({super.key, this.editExpense});

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

  bool get _isEditMode => widget.editExpense != null;

  ExpenseEditPolicyResult? get _editPolicy {
    final expense = widget.editExpense;
    if (expense == null) return null;
    return sl<ExpenseRepository>().canEditExpense(expense);
  }

  bool get _canEditFinancialFields =>
      !_isEditMode || (_editPolicy?.canFullEdit ?? false);

  @override
  void initState() {
    super.initState();
    _prefillEditExpense();
    _loadData();
  }

  void _prefillEditExpense() {
    final expense = widget.editExpense;
    if (expense == null) return;

    _amountController.text = expense.amount.toStringAsFixed(0);
    _titleController.text = expense.title;
    _noteController.text = expense.note ?? '';
    _selectedDate = expense.expenseDate;
    _expenseType = expense.expenseType;
    _splitType = expense.splitType;
    _category = expense.category ?? ExpenseCategory.other.name;
    _latitude = expense.latitude;
    _longitude = expense.longitude;
    for (final participant in expense.participants) {
      _manualAmounts[participant.userId] = participant.amount;
      _manualControllers[participant.userId] = TextEditingController(
        text: participant.amount.toStringAsFixed(0),
      );
    }
  }

  Future<void> _loadData() async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;

    final accountDtos = await sl<AccountLocalDatasource>().getAccounts();
    final userAccounts = accountDtos
        .where((a) => a.userId == userId && !a.isArchived)
        .map((d) => d.toEntity())
        .toList();

    final partnershipDtos = await sl<PartnershipRemoteDatasource>()
        .getPartnerships(userId: userId);
    final connected = partnershipDtos
        .where(
          (p) => PartnershipStatus.values.any(
            (e) => e.name == p.status && e == PartnershipStatus.accepted,
          ),
        )
        .map((d) => d.toEntity())
        .toList();

    AccountEntity? selected;
    if (widget.editExpense?.accountId != null) {
      selected = userAccounts
          .where((account) => account.id == widget.editExpense!.accountId)
          .firstOrNull;
    }
    if (selected == null && userAccounts.isNotEmpty) {
      final defaultId = await AppSettings.getDefaultAccountId(userId: userId);
      selected = defaultId != null
          ? userAccounts.where((a) => a.id == defaultId).firstOrNull ??
                userAccounts.first
          : userAccounts.first;
    }

    final editParticipantIds =
        widget.editExpense?.participants
            .map((participant) => participant.userId)
            .where((participantId) => participantId != userId)
            .toSet() ??
        const <String>{};
    final selectedPartners = connected.where((partner) {
      return editParticipantIds.contains(_partnerUserId(partner, userId));
    }).toList();

    if (mounted) {
      setState(() {
        _accounts = userAccounts;
        _connectedPartners = connected;
        _selectedAccount = selected;
        if (_isEditMode) {
          _selectedPartners = selectedPartners;
        }
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
    if (!_canEditFinancialFields) return;
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

  Future<void> _openMapPicker() async {
    if (!_canEditFinancialFields) return;
    final position = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialLatitude: _latitude,
          initialLongitude: _longitude,
        ),
      ),
    );
    if (!mounted) return;
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }
  }

  void _clearLocation() {
    if (!_canEditFinancialFields) return;
    setState(() {
      _latitude = null;
      _longitude = null;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please fill all required fields (Title and Amount)',
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User not found'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      );
      return;
    }

    final original = widget.editExpense;
    if (original != null && !_canEditFinancialFields) {
      final edited = original.copyWith(
        title: _titleController.text.trim(),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        updatedAt: DateTime.now().toUtc(),
        syncStatus: SyncStatus.pending,
      );
      context.read<AddExpenseBloc>().add(
        AddExpenseEvent.update(original: original, edited: edited),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    final currentUserId = userId!;

    /// Shared expense with no partners
    if (_expenseType == ExpenseType.shared && _selectedPartners.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'No partner selected for shared expense. Switch to Personal or add a partner.',
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      );
      return;
    }

    /// Balance check
    if (_selectedAccount != null &&
        amount > _selectedAccount!.currentBalance &&
        !_forceSubmit) {
      setState(() => _amountExceedsBalance = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Insufficient balance. Tick "Add anyway" to proceed.',
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Total shares ${formatIndianRupee(manualTotal)} ≠ ${formatIndianRupee(amount)}',
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
        );
        return;
      }
      for (final entry in _manualAmounts.entries) {
        if (entry.value < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Shares cannot be negative'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          );
          return;
        }
        if (entry.value > amount) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'A participant share cannot exceed the total amount',
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          );
          return;
        }
      }
    }

    final participantIds = <String>[
      currentUserId,
      ..._selectedPartners.map(
        (partner) => _partnerUserId(partner, currentUserId),
      ),
    ];
    final equalShares =
        _expenseType != ExpenseType.personal && _splitType == SplitType.equal
        ? ExpenseSplitCalculator.equal(
            totalAmount: amount,
            participantIds: participantIds,
          )
        : const <String, double>{};
    final participants = participantIds.map((participantId) {
      final share = switch ((_expenseType, _splitType)) {
        (ExpenseType.personal, _) => amount,
        (ExpenseType.shared, SplitType.equal) => equalShares[participantId]!,
        (ExpenseType.shared, SplitType.manual) =>
          _manualAmounts[participantId] ?? 0,
        (ExpenseType.group, SplitType.equal) => equalShares[participantId]!,
        (ExpenseType.group, SplitType.manual) =>
          _manualAmounts[participantId] ?? 0,
      };
      return ExpenseParticipantEntity(userId: participantId, amount: share);
    }).toList();

    final expense = ExpenseEntity(
      id: original?.id ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      amount: amount,
      paidByUserId: currentUserId,
      ownerUserId: currentUserId,
      expenseType: _expenseType,
      splitType: _splitType,
      participants: participants,
      accountId: _selectedAccount?.id,
      category: _category,
      expenseDate: _selectedDate,
      createdAt: original?.createdAt ?? DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
      syncStatus: SyncStatus.pending,
      latitude: _latitude,
      longitude: _longitude,
    );
    if (original == null) {
      context.read<AddExpenseBloc>().add(AddExpenseEvent.submit(expense));
    } else {
      context.read<AddExpenseBloc>().add(
        AddExpenseEvent.update(original: original, edited: expense),
      );
    }
  }

  void _initManualAmounts() {
    final total = double.tryParse(_amountController.text.trim()) ?? 0;
    final userId = sl<AuthLocalDatasource>().getUserId();
    final participantIds = <String>[
      ?userId,
      ..._selectedPartners.map((partner) => _partnerUserId(partner, userId)),
    ];
    final shares = participantIds.isEmpty
        ? const <String, double>{}
        : ExpenseSplitCalculator.equal(
            totalAmount: total,
            participantIds: participantIds,
          );
    _manualAmounts.clear();
    for (final c in _manualControllers.values) {
      c.dispose();
    }
    _manualControllers.clear();

    void setFor(String uid, double val) {
      _manualAmounts[uid] = val;
      _manualControllers[uid] = TextEditingController(
        text: val.toStringAsFixed(0),
      );
    }

    if (userId != null) setFor(userId, shares[userId] ?? 0);
    for (final p in _selectedPartners) {
      final partnerId = _partnerUserId(p, userId);
      setFor(partnerId, shares[partnerId] ?? 0);
    }
  }

  String _partnerUserId(PartnershipEntity p, String? currentUserId) {
    return p.senderId == currentUserId ? p.receiverId : p.senderId;
  }

  String _partnerNickname(PartnershipEntity p) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    return userId == p.senderId ? p.receiverNickname : p.senderNickname;
  }

  double _manualTotal() {
    return _manualAmounts.values.fold(0.0, (a, b) => a + b);
  }

  void _showAccountPicker() {
    if (!_canEditFinancialFields) return;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => AccountPickerSheet(
        accounts: _accounts,
        selectedAccountId: _selectedAccount?.id,
        onSelected: (account) {
          Navigator.of(ctx).pop();
          if (account.isSavings) {
            showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: const Text('Savings Account'),
                content: const Text(
                  'Spending from savings will reduce your monthly savings progress. Are you sure?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(c, false),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(c, true),
                    child: const Text('Use anyway'),
                  ),
                ],
              ),
            ).then((confirmed) {
              if (confirmed == true && context.mounted) {
                setState(() {
                  _selectedAccount = account;
                  _amountExceedsBalance = false;
                  _forceSubmit = false;
                });
                _checkBalance();
              }
            });
          } else {
            setState(() {
              _selectedAccount = account;
              _amountExceedsBalance = false;
              _forceSubmit = false;
            });
            _checkBalance();
          }
        },
        onAddNew: () {
          Navigator.of(ctx).pop();
          context.pushNamed(AppRoute.addAccount.name);
          _loadData();
        },
      ),
    );
  }

  Future<void> _showPartnerPicker() async {
    if (!_canEditFinancialFields) return;
    FocusManager.instance.primaryFocus?.unfocus();
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setSheetState) {
          final pickerUserId = sl<AuthLocalDatasource>().getUserId();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SheetGrabber(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Split With',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        '${_selectedPartners.length} selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_connectedPartners.isEmpty)
                    const FinanceEmptyState(
                      icon: Icons.people_outline_rounded,
                      title: 'No partners yet',
                      subtitle:
                          'Add a partner first to create shared expenses.',
                    )
                  else
                    ..._connectedPartners.map((p) {
                      final isSelected = _selectedPartners.any(
                        (sp) => sp.id == p.id,
                      );
                      final nickname = pickerUserId == p.senderId
                          ? p.receiverNickname
                          : p.senderNickname;
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: CheckboxListTile(
                          value: isSelected,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          secondary: CircleAvatar(
                            radius: 18,
                            child: Text(
                              nickname.isEmpty
                                  ? '?'
                                  : nickname[0].toUpperCase(),
                            ),
                          ),
                          title: Text('@$nickname'),
                          onChanged: (checked) {
                            setSheetState(() {
                              if (checked == true) {
                                if (!_selectedPartners.any(
                                  (sp) => sp.id == p.id,
                                )) {
                                  _selectedPartners.add(p);
                                }
                              } else {
                                _selectedPartners.removeWhere(
                                  (sp) => sp.id == p.id,
                                );
                              }
                            });
                          },
                        ),
                      );
                    }),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Done'),
                    ),
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

  Widget _categoryField() {
    return DropdownButtonFormField<String>(
      initialValue: _category,
      decoration: const InputDecoration(labelText: 'Category'),
      items: ExpenseCategory.values.map((c) {
        return DropdownMenuItem(
          value: c.name,
          child: Row(
            children: [
              Icon(c.icon, size: 20, color: c.color),
              const SizedBox(width: 12),
              Text(c.label),
            ],
          ),
        );
      }).toList(),
      onChanged: _canEditFinancialFields
          ? (v) => setState(() => _category = v)
          : null,
    );
  }

  Widget _accountField() {
    return InkWell(
      onTap: _canEditFinancialFields ? _showAccountPicker : null,
      borderRadius: BorderRadius.circular(6),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Account',
          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        child: Row(
          children: [
            Icon(
              _selectedAccount?.isSavings == true
                  ? Icons.savings_rounded
                  : Icons.account_balance_wallet_rounded,
              color: _selectedAccount?.isSavings == true
                  ? Colors.amber.shade700
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _selectedAccount == null
                  ? Text(
                      'Select Account',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedAccount!.accountName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          formatIndianRupee(_selectedAccount!.currentBalance),
                          style: TextStyle(
                            fontSize: 12,
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
    );
  }

  Widget _dateField() {
    return InkWell(
      onTap: _canEditFinancialFields ? _selectDate : null,
      borderRadius: BorderRadius.circular(6),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded),
            const SizedBox(width: 12),
            Expanded(
              child: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationField() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: _canEditFinancialFields ? _openMapPicker : null,
            borderRadius: BorderRadius.circular(6),
            child: InputDecorator(
              decoration: const InputDecoration(labelText: 'Location'),
              child: Row(
                children: [
                  Icon(
                    _latitude != null
                        ? Icons.location_on_rounded
                        : Icons.add_location_alt_rounded,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _latitude != null ? 'Location captured' : 'Add location',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
            onPressed: _canEditFinancialFields ? _clearLocation : null,
            tooltip: 'Remove location',
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final policy = _editPolicy;
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isEditMode
                      ? 'Expense updated successfully'
                      : 'Expense added successfully',
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            );
            context.goNamed(AppRoute.home.name);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? 'Edit Expense' : 'Add Expense'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 112),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AmountComposer(
                        amountController: _amountController,
                        expenseType: _expenseType,
                        enabled: _canEditFinancialFields,
                        title: _isEditMode ? 'Edit expense' : 'New expense',
                        onAmountChanged: (_) {
                          _checkBalance();
                          if (_expenseType == ExpenseType.shared) {
                            setState(() {});
                          }
                        },
                        onTypeChanged: (value) {
                          if (!_canEditFinancialFields) return;
                          setState(() {
                            _expenseType = value;
                            if (_expenseType != ExpenseType.shared) {
                              _selectedPartners = [];
                            }
                          });
                        },
                      ),
                      if (_amountExceedsBalance) ...[
                        const SizedBox(height: 12),
                        _BalanceWarning(
                          forceSubmit: _forceSubmit,
                          onChanged: (v) =>
                              setState(() => _forceSubmit = v ?? false),
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (policy != null) ...[
                        _EditPolicyBanner(policy: policy),
                        const SizedBox(height: 14),
                      ],
                      _FormSection(
                        title: 'Basics',
                        icon: Icons.receipt_long_rounded,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                labelText: 'Expense Title',
                                hintText: 'Dinner, Petrol, Shopping...',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            _ResponsiveFieldRow(
                              first: _categoryField(),
                              second: _accountField(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        child: _expenseType == ExpenseType.shared
                            ? _SharedSplitSection(
                                key: const ValueKey('shared_split_section'),
                                selectedPartners: _selectedPartners,
                                splitType: _splitType,
                                onPickPartners: _showPartnerPicker,
                                onRemovePartner: (partner) {
                                  if (!_canEditFinancialFields) return;
                                  setState(() {
                                    _selectedPartners.removeWhere(
                                      (sp) => sp.id == partner.id,
                                    );
                                    if (_splitType == SplitType.manual) {
                                      _initManualAmounts();
                                    }
                                  });
                                },
                                onSplitTypeChanged: (value) {
                                  if (!_canEditFinancialFields) return;
                                  setState(() {
                                    _splitType = value;
                                    if (_splitType == SplitType.manual) {
                                      _initManualAmounts();
                                    }
                                  });
                                },
                                splitPreview: _selectedPartners.isEmpty
                                    ? const []
                                    : _buildSplitPreview(),
                                nicknameFor: _partnerNickname,
                                enabled: _canEditFinancialFields,
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('personal_split_section'),
                              ),
                      ),
                      const SizedBox(height: 14),
                      _FormSection(
                        title: 'Optional Details',
                        icon: Icons.tune_rounded,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _noteController,
                              minLines: 2,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Note (Optional)',
                              ),
                            ),
                            const SizedBox(height: 12),
                            _ResponsiveFieldRow(
                              first: _dateField(),
                              second: _locationField(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _SaveExpenseBar(
          onSubmit: _submit,
          label: _isEditMode ? 'Save Changes' : 'Save Expense',
        ),
      ),
    );
  }

  List<Widget> _buildSplitPreview() {
    final total = double.tryParse(_amountController.text.trim()) ?? 0;
    final totalPeople = 1 + _selectedPartners.length;
    final perPerson = totalPeople > 0
        ? (total / totalPeople).roundToDouble()
        : 0.0;
    final userId = sl<AuthLocalDatasource>().getUserId();
    final widgets = <Widget>[];

    // Build ordered participant list: [currentUser, partner1, partner2, ...]
    final participantIds = <String>[];
    if (userId != null) participantIds.add(userId);
    for (final p in _selectedPartners) {
      participantIds.add(_partnerUserId(p, userId));
    }

    // The last entry auto-completes
    final autoCompleteId = participantIds.length > 1
        ? participantIds.last
        : null;

    for (int i = 0; i < participantIds.length; i++) {
      final pid = participantIds[i];
      final isAuto = pid == autoCompleteId;

      // For auto-complete entry, compute amount = total - sum of others
      final autoAmount = isAuto && total > 0
          ? total -
                _manualAmounts.entries
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
      final partnerEntity = isSelf
          ? null
          : _selectedPartners.firstWhere(
              (p) => _partnerUserId(p, userId) == pid,
              orElse: () => _selectedPartners.first,
            );
      final label = isSelf
          ? 'You'
          : partnerEntity != null
          ? (userId == partnerEntity.senderId
                ? '@${partnerEntity.receiverNickname}'
                : '@${partnerEntity.senderNickname}')
          : pid;

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                isSelf ? Icons.person_rounded : Icons.person_outline_rounded,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(label, style: const TextStyle(fontSize: 14)),
              ),
              if (_splitType == SplitType.equal)
                Text(
                  formatIndianRupee(perPerson),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              else if (isAuto)
                Text(
                  formatIndianRupee(autoAmount),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                )
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                    ),
                    controller: _manualControllers.putIfAbsent(pid, () {
                      final val = _manualAmounts[pid] ?? perPerson;
                      _manualAmounts[pid] = val;
                      return TextEditingController(
                        text: val.toStringAsFixed(0),
                      );
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
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

class _ResponsiveFieldRow extends StatelessWidget {
  final Widget first;
  final Widget second;

  const _ResponsiveFieldRow({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(children: [first, const SizedBox(height: 16), second]);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: first),
            const SizedBox(width: 12),
            Expanded(child: second),
          ],
        );
      },
    );
  }
}

class _AmountComposer extends StatelessWidget {
  final TextEditingController amountController;
  final ExpenseType expenseType;
  final bool enabled;
  final String title;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<ExpenseType> onTypeChanged;

  const _AmountComposer({
    required this.amountController,
    required this.expenseType,
    required this.enabled,
    required this.title,
    required this.onAmountChanged,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GradientPatternPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  expenseType == ExpenseType.shared
                      ? Icons.groups_rounded
                      : Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      expenseType == ExpenseType.shared
                          ? 'Split this spend with partners.'
                          : 'Track a personal spend.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: amountController,
            enabled: enabled,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '₹ ',
            ),
            onChanged: onAmountChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter amount';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return 'Enter a valid amount greater than 0';
              }
              if (amount % 1 != 0) {
                return 'Enter a whole rupee amount';
              }
              if (amount > 999999999) return 'Amount too large';
              return null;
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ExpenseType>(
              selected: {expenseType},
              onSelectionChanged: enabled
                  ? (value) => onTypeChanged(value.first)
                  : null,
              segments: const [
                ButtonSegment(
                  value: ExpenseType.personal,
                  icon: Icon(Icons.person_rounded),
                  label: Text('Personal'),
                ),
                ButtonSegment(
                  value: ExpenseType.shared,
                  icon: Icon(Icons.groups_rounded),
                  label: Text('Shared'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceWarning extends StatelessWidget {
  final bool forceSubmit;
  final ValueChanged<bool?> onChanged;

  const _BalanceWarning({required this.forceSubmit, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.warning_rounded, color: theme.colorScheme.error),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Account balance is less than this expense amount',
                    style: TextStyle(
                      color: theme.colorScheme.onErrorContainer,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              value: forceSubmit,
              onChanged: onChanged,
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Add anyway', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditPolicyBanner extends StatelessWidget {
  final ExpenseEditPolicyResult policy;

  const _EditPolicyBanner({required this.policy});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              policy.canFullEdit
                  ? Icons.edit_calendar_rounded
                  : Icons.lock_outline_rounded,
              color: theme.colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                policy.message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _FormSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _SharedSplitSection extends StatelessWidget {
  final List<PartnershipEntity> selectedPartners;
  final SplitType splitType;
  final VoidCallback onPickPartners;
  final ValueChanged<PartnershipEntity> onRemovePartner;
  final ValueChanged<SplitType> onSplitTypeChanged;
  final List<Widget> splitPreview;
  final String Function(PartnershipEntity) nicknameFor;
  final bool enabled;

  const _SharedSplitSection({
    super.key,
    required this.selectedPartners,
    required this.splitType,
    required this.onPickPartners,
    required this.onRemovePartner,
    required this.onSplitTypeChanged,
    required this.splitPreview,
    required this.nicknameFor,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _FormSection(
      title: 'Split',
      icon: Icons.groups_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: enabled ? onPickPartners : null,
            borderRadius: BorderRadius.circular(6),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Partners',
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      selectedPartners.isEmpty
                          ? 'Select partners'
                          : '${selectedPartners.length} partner${selectedPartners.length > 1 ? 's' : ''} selected',
                      style: TextStyle(
                        color: selectedPartners.isEmpty
                            ? theme.colorScheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedPartners.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: selectedPartners.map((partner) {
                final nickname = nicknameFor(partner);
                return InputChip(
                  avatar: CircleAvatar(
                    child: Text(
                      nickname.isEmpty ? '?' : nickname[0].toUpperCase(),
                    ),
                  ),
                  label: Text('@$nickname'),
                  onDeleted: enabled ? () => onRemovePartner(partner) : null,
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<SplitType>(
              selected: {splitType},
              onSelectionChanged: enabled
                  ? (value) => onSplitTypeChanged(value.first)
                  : null,
              segments: const [
                ButtonSegment(
                  value: SplitType.equal,
                  icon: Icon(Icons.balance_rounded),
                  label: Text('Equal'),
                ),
                ButtonSegment(
                  value: SplitType.manual,
                  icon: Icon(Icons.edit_note_rounded),
                  label: Text('Manual'),
                ),
              ],
            ),
          ),
          if (selectedPartners.isNotEmpty) ...[
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.70,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Split Preview',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    ...splitPreview,
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SaveExpenseBar extends StatelessWidget {
  final VoidCallback onSubmit;
  final String label;

  const _SaveExpenseBar({required this.onSubmit, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
        ),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                  return FilledButton.icon(
                    onPressed: isLoading ? null : onSubmit,
                    icon: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_rounded),
                    label: Text(isLoading ? 'Saving' : label),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
