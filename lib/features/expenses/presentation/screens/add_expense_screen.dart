import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
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

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _noteController.dispose();
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

  void _submit() {
    if (!_formKey.currentState!.validate()) {
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
      return;
    }

    final expense = ExpenseEntity(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      paidByUserId: userId!,
      expenseType: _expenseType,
      splitType: _splitType,
      participants: [ExpenseParticipantEntity(userId: userId!, amount: double.parse(_amountController.text.trim()))],
      expenseDate: _selectedDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      syncStatus: SyncStatus.pending,
    );
    context.read<AddExpenseBloc>().add(AddExpenseEvent.submit(expense));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense added successfully')));
            context.pop();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter amount';
                          }
                          final amount = double.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                      ),
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
                          if (value == null || value.isEmpty) {
                            return 'Enter title';
                          }
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

                      /// Expense Type
                      const Text('Expense Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      SegmentedButton<ExpenseType>(
                        selected: {_expenseType},
                        onSelectionChanged: (value) {
                          setState(() {
                            _expenseType = value.first;
                          });
                        },
                        segments: const [
                          ButtonSegment(value: ExpenseType.personal, label: Text('Personal')),
                          ButtonSegment(value: ExpenseType.shared, label: Text('Shared')),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// Split Type
                      if (_expenseType == ExpenseType.shared) ...[
                        const Text('Split Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        SegmentedButton<SplitType>(
                          selected: {_splitType},
                          onSelectionChanged: (value) {
                            setState(() {
                              _splitType = value.first;
                            });
                          },
                          segments: const [
                            ButtonSegment(value: SplitType.equal, label: Text('Equal')),
                            ButtonSegment(value: SplitType.manual, label: Text('Manual')),
                          ],
                        ),
                        const SizedBox(height: 24),
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
                                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator())
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
}
