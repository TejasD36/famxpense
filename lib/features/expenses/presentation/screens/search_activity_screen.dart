import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../xcore.dart';

enum _SearchFilter { all, expenses, settlements, deposits }

class _SearchableItem {
  final String id;
  final DateTime date;
  final double amount;
  final String title;
  final String searchText;
  final _SearchFilter type;
  final ExpenseEntity? expense;
  final SettlementEntity? settlement;

  _SearchableItem({
    required this.id,
    required this.date,
    required this.amount,
    required this.title,
    required this.searchText,
    required this.type,
    this.expense,
    this.settlement,
  });
}

class SearchActivityScreen extends StatefulWidget {
  const SearchActivityScreen({super.key});

  @override
  State<SearchActivityScreen> createState() => _SearchActivityScreenState();
}

class _SearchActivityScreenState extends State<SearchActivityScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final Set<String> _expandedIds = {};
  _SearchFilter _filter = _SearchFilter.all;
  List<_SearchableItem> _allItems = [];
  List<_SearchableItem> _filteredItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final userId = sl<AuthLocalDatasource>().getUserId() ?? '';
    if (userId.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final allExpenses = await sl<ExpenseLocalDatasource>().getExpenses(
      ownerUserId: userId,
    );
    final allSettlements = await sl<SettlementLocalDatasource>()
        .getSettlements();
    final userSettlements = allSettlements
        .where(
          (s) =>
              (s.fromUserId == userId || s.toUserId == userId) &&
              s.status == SettlementStatus.confirmed,
        )
        .toList();
    final userCache = <String, String?>{};

    String? nickname(String uid) {
      return userCache.putIfAbsent(uid, () {
        final u = sl<UserLocalDatasource>().getUser(uid);
        return u?.nickname;
      });
    }

    final items = <_SearchableItem>[];

    for (final dto in allExpenses) {
      final e = dto.toEntity();
      final catLabel =
          e.category != null && e.category != ExpenseCategory.other.name
          ? ExpenseCategory.values
                    .where((c) => c.name == e.category)
                    .firstOrNull
                    ?.label ??
                e.category!
          : '';
      final paidBy = nickname(e.paidByUserId) ?? e.paidByUserId;
      final partnerNames = e.participants
          .where((p) => p.userId != userId)
          .map((p) => nickname(p.userId) ?? p.userId)
          .join(' ');
      final searchText =
          '${e.title} ${e.note ?? ''} $catLabel ${e.amount.toStringAsFixed(0)} $paidBy $partnerNames'
              .toLowerCase();

      items.add(
        _SearchableItem(
          id: e.id,
          date: e.expenseDate,
          amount: e.amount,
          title: e.title,
          searchText: searchText,
          type: _SearchFilter.expenses,
          expense: e,
        ),
      );
    }

    for (final dto in userSettlements) {
      final s = dto.toEntity();
      final otherId = s.fromUserId == userId ? s.toUserId : s.fromUserId;
      final other = nickname(otherId) ?? otherId;
      final isOutgoing = s.fromUserId == userId;
      final prefix = isOutgoing ? 'Settlement to' : 'Settlement from';
      final title = '$prefix @$other';
      final searchText =
          '$title ${s.amount.toStringAsFixed(0)} $other ${isOutgoing ? 'paid' : 'received'}'
              .toLowerCase();
      final type = isOutgoing
          ? _SearchFilter.settlements
          : _SearchFilter.deposits;

      items.add(
        _SearchableItem(
          id: s.id,
          date: s.createdAt,
          amount: s.amount,
          title: title,
          searchText: searchText,
          type: type,
          settlement: s,
        ),
      );
    }

    items.sort((a, b) => b.date.compareTo(a.date));

    if (mounted) {
      setState(() {
        _allItems = items;
        _isLoading = false;
      });
      _applyFilter();
    }
  }

  void _applyFilter() {
    final query = _controller.text.trim().toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        if (query.isNotEmpty && !item.searchText.contains(query)) {
          return false;
        }
        if (_filter == _SearchFilter.expenses &&
            item.type != _SearchFilter.expenses) {
          return false;
        }
        if (_filter == _SearchFilter.settlements &&
            item.type != _SearchFilter.settlements) {
          return false;
        }
        if (_filter == _SearchFilter.deposits &&
            item.type != _SearchFilter.deposits) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _clearSearch() {
    _controller.clear();
    _applyFilter();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Search expenses, settlements...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: _clearSearch,
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                    ),
                    onChanged: (_) => _applyFilter(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _filterChip('All', _SearchFilter.all),
                        const SizedBox(width: 8),
                        _filterChip('Expenses', _SearchFilter.expenses),
                        const SizedBox(width: 8),
                        _filterChip('Settlements', _SearchFilter.settlements),
                        const SizedBox(width: 8),
                        _filterChip('Deposits', _SearchFilter.deposits),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      Text(
                        '${_filteredItems.length} result${_filteredItems.length == 1 ? '' : 's'} found',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _filteredItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No matching transactions',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: item.expense != null
                                  ? _expenseCard(item.expense!)
                                  : _settlementCard(item.settlement!, item.id),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _filterChip(String label, _SearchFilter value) {
    final isSelected = _filter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() => _filter = value);
        _applyFilter();
      },
    );
  }

  Widget _buildCategoryRow(String category) {
    final catEnum = ExpenseCategory.values
        .where((c) => c.name == category)
        .firstOrNull;
    return Row(
      children: [
        Icon(
          catEnum?.icon ?? Icons.label_rounded,
          size: 14,
          color: catEnum?.color,
        ),
        const SizedBox(width: 4),
        Text(catEnum?.label ?? category, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  String? _nickname(String userId) {
    final user = sl<UserLocalDatasource>().getUser(userId);
    return user?.nickname;
  }

  Widget _expenseCard(ExpenseEntity expense) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    final isExpanded = _expandedIds.contains(expense.id);
    final isPayer = userId != null && expense.paidByUserId == userId;
    final paidBy = _nickname(expense.paidByUserId) ?? expense.paidByUserId;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(expense.id)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color:
                          (expense.expenseType == ExpenseType.shared
                                  ? Colors.orange
                                  : Colors.green)
                              .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      expense.expenseType == ExpenseType.shared
                          ? Icons.groups_rounded
                          : Icons.person_rounded,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat(
                            'dd MMM yyyy · h:mm a',
                          ).format(expense.expenseDate),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatIndianRupee(expense.amount),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          expense.expenseType.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      if (expense.note != null && expense.note!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          expense.note!,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.paypal_rounded, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            isPayer ? 'Paid by You' : 'Paid by @$paidBy',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      if (expense.category != null &&
                          expense.category != ExpenseCategory.other.name) ...[
                        const SizedBox(height: 4),
                        _buildCategoryRow(expense.category!),
                      ],
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settlementCard(SettlementEntity settlement, String id) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    final isExpanded = _expandedIds.contains(id);
    final isPayer = settlement.fromUserId == userId;
    final otherId = isPayer ? settlement.toUserId : settlement.fromUserId;
    final other = _nickname(otherId) ?? otherId;
    final title = isPayer ? 'Settlement to @$other' : 'Settlement from @$other';

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => setState(() => _expandedIds.toggle(id)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.swap_horiz_rounded, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat(
                            'dd MMM yyyy · h:mm a',
                          ).format(settlement.createdAt),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatIndianRupee(settlement.amount),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'SETTLEMENT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.person_rounded, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            isPayer
                                ? 'Paid to @$other'
                                : 'Received from @$other',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Set<String> {
  void toggle(String id) {
    if (contains(id)) {
      remove(id);
    } else {
      add(id);
    }
  }
}
