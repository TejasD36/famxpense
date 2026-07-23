import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

class TransactionDetailSheet extends StatefulWidget {
  final ExpenseEntity expense;

  const TransactionDetailSheet({super.key, required this.expense});

  @override
  State<TransactionDetailSheet> createState() => _TransactionDetailSheetState();
}

class _TransactionDetailSheetState extends State<TransactionDetailSheet> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expense = widget.expense;
    final userId = sl<AuthLocalDatasource>().getUserId();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                formatIndianRupee(expense.amount),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            _infoRow(context, 'Category', expense.category ?? '—'),
            if (expense.note != null) _infoRow(context, 'Note', expense.note!),
            _infoRow(context, 'Date', DateFormat('dd MMM yyyy · h:mm a').format(expense.expenseDate)),
            _infoRow(context, 'Type', expense.expenseType == ExpenseType.personal ? 'Personal' : 'Shared'),
            if (expense.accountId != null)
              _infoRow(context, 'Account', _resolveAccountName(expense.accountId!)),
            _infoRow(context, 'Status', expense.syncStatus == SyncStatus.synced ? 'Synced' : 'Pending'),
            const SizedBox(height: 12),
            _participantsSection(context, expense, userId),
            if (expense.latitude != null && expense.longitude != null) ...[
              const SizedBox(height: 16),
              const Text('Location', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(expense.latitude!, expense.longitude!),
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('expense_location'),
                        position: LatLng(expense.latitude!, expense.longitude!),
                      ),
                    },
                    zoomControlsEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    onMapCreated: (controller) => _mapController = controller,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Expense ID: ${expense.id}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  String _resolveAccountName(String accountId) {
    final accounts = Hive.box<AccountDto>(HiveBoxes.accounts).values.toList();
    final match = accounts.where((a) => a.id == accountId).firstOrNull;
    return match?.accountName ?? accountId;
  }

  Widget _participantsSection(BuildContext context, ExpenseEntity expense, String? userId) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Participants', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          ...expense.participants.map((p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Icon(p.userId == userId ? Icons.person_rounded : Icons.person_outline_rounded, size: 16),
                const SizedBox(width: 8),
                Text(p.userId == userId ? 'You' : p.userId, style: const TextStyle(fontSize: 13)),
                const Spacer(),
                Text(formatIndianRupee(p.amount), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
