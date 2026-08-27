import 'dart:math' show min;

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
    final theme = Theme.of(context);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          children: [
            const SheetGrabber(),
            const SizedBox(height: 12),
            GradientPatternPanel(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Icon(
                          expense.expenseType == ExpenseType.shared
                              ? Icons.groups_rounded
                              : Icons.person_rounded,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          expense.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        expense.syncStatus == SyncStatus.synced
                            ? Icons.cloud_done_rounded
                            : Icons.cloud_upload_rounded,
                        color: expense.syncStatus == SyncStatus.synced
                            ? Colors.green
                            : theme.colorScheme.tertiary,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formatIndianRupee(expense.amount),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Column(
                  children: [
                    _infoRow(context, 'Category', _categoryLabel(expense)),
                    if (expense.note?.trim().isNotEmpty == true)
                      _infoRow(context, 'Note', expense.note!.trim()),
                    _infoRow(
                      context,
                      'Date',
                      DateFormat(
                        'dd MMM yyyy · h:mm a',
                      ).format(expense.expenseDate),
                    ),
                    _infoRow(
                      context,
                      'Type',
                      expense.expenseType == ExpenseType.personal
                          ? 'Personal'
                          : 'Shared',
                    ),
                    if (expense.accountId != null)
                      _infoRow(
                        context,
                        'Account',
                        _resolveAccountName(expense.accountId!),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _participantsSection(context, expense, userId),
            if (expense.latitude != null && expense.longitude != null) ...[
              const SizedBox(height: 12),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
                      child: Text(
                        'Location',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(expense.latitude!, expense.longitude!),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('expense_location'),
                            position: LatLng(
                              expense.latitude!,
                              expense.longitude!,
                            ),
                          ),
                        },
                        zoomControlsEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        onMapCreated: (controller) =>
                            _mapController = controller,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Expense ID: ${expense.id}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(ExpenseEntity expense) {
    return ExpenseCategory.values
            .where((item) => item.name == expense.category)
            .firstOrNull
            ?.label ??
        expense.category ??
        '—';
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
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _resolveAccountName(String accountId) {
    final accounts = Hive.box<AccountDto>(HiveBoxes.accounts).values.toList();
    final match = accounts.where((a) => a.id == accountId).firstOrNull;
    if (match == null) return accountId;
    return match.isDeleted
        ? '${match.accountName} (Deleted)'
        : match.accountName;
  }

  Widget _participantsSection(
    BuildContext context,
    ExpenseEntity expense,
    String? userId,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Participants',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          ...expense.participants.map(
            (p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    p.userId == userId
                        ? Icons.person_rounded
                        : Icons.person_outline_rounded,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    p.userId == userId
                        ? 'You'
                        : sl<UserLocalDatasource>()
                                  .getUser(p.userId)
                                  ?.nickname ??
                              p.userId.substring(0, min(8, p.userId.length)),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    formatIndianRupee(p.amount),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
