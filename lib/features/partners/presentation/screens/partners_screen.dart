import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../../debt_ledger/data/datasources/debt_ledger_local_datasource.dart';
import '../../../settlement/data/datasources/settlement_local_datasource.dart';
import '../../xcore.dart';
import '../blocs/partner_bloc.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<PartnerBloc>().add(const PartnerEvent.loadPartners());
  }

  Future<void> _reloadPartners() async {
    final bloc = context.read<PartnerBloc>();
    bloc.add(const PartnerEvent.loadPartners());
    await bloc.stream.firstWhere(
      (s) => s.maybeWhen(loading: () => false, orElse: () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerBloc, PartnerState>(
      builder: (context, state) {
        final requestCount = state.maybeWhen(
          loaded: (_, _, incoming, outgoing) =>
              incoming.length + outgoing.length,
          orElse: () => 0,
        );

        return DefaultTabController(
          length: 2,

          child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: const Text('Partners'),
              ),

              centerTitle: false,

              actions: [
                IconButton(
                  onPressed: () async {
                    await context.pushNamed(AppRoute.addPartner.name);
                    if (context.mounted) {
                      context.read<PartnerBloc>().add(
                        const PartnerEvent.loadPartners(),
                      );
                    }
                  },
                  icon: const Icon(Icons.person_add_alt_1_rounded),
                  tooltip: 'Add Partner',
                ),
              ],

              bottom: TabBar(
                tabs: [
                  const Tab(text: 'Connected'),
                  Tab(
                    child: Badge.count(
                      count: requestCount,
                      isLabelVisible: requestCount > 0,
                      child: const Text('Requests'),
                    ),
                  ),
                ],
              ),
            ),

            body: Stack(
              children: [
                state.maybeWhen(
                  loaded:
                      (
                        _,
                        connectedPartners,
                        incomingRequests,
                        outgoingRequests,
                      ) {
                        return TabBarView(
                          children: [
                            RefreshIndicator(
                              onRefresh: () => _reloadPartners(),
                              child: _ConnectedTab(partners: connectedPartners),
                            ),
                            RefreshIndicator(
                              onRefresh: () => _reloadPartners(),
                              child: _RequestsTab(
                                incomingRequests: incomingRequests,
                                outgoingRequests: outgoingRequests,
                              ),
                            ),
                          ],
                        );
                      },
                  orElse: () =>
                      const TabBarView(children: [SizedBox(), SizedBox()]),
                ),
                state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  initial: () => const Center(child: Text('Loading...')),
                  error: (message) => Center(child: Text(message)),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConnectedTab extends StatefulWidget {
  final List<PartnershipEntity> partners;
  const _ConnectedTab({required this.partners});

  @override
  State<_ConnectedTab> createState() => _ConnectedTabState();
}

class _ConnectedTabState extends State<_ConnectedTab> {
  final Set<String> _removingIds = {};

  Future<bool> _canRemovePartner(BuildContext context, String partnerId) async {
    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return false;

    final ledgers = await sl<DebtLedgerLocalDatasource>().getLedgers();
    final hasDebt = ledgers.any((l) {
      if (l.userA == userId && l.userB == partnerId) return l.netBalance != 0;
      if (l.userB == userId && l.userA == partnerId) return l.netBalance != 0;
      return false;
    });
    if (hasDebt) return false;

    final settlementDtos = await sl<SettlementLocalDatasource>()
        .getSettlements();
    final hasPending = settlementDtos.any((s) {
      final pair =
          (s.fromUserId == userId && s.toUserId == partnerId) ||
          (s.fromUserId == partnerId && s.toUserId == userId);
      return pair && s.status == SettlementStatus.pending;
    });
    if (hasPending) return false;

    return true;
  }

  Future<void> _confirmRemove(
    BuildContext context,
    PartnershipEntity partnership,
  ) async {
    setState(() => _removingIds.add(partnership.id));
    try {
      final canRemove = await _canRemovePartner(
        context,
        _partnerId(partnership),
      );
      if (!context.mounted) return;

      if (!canRemove) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cannot remove partner. Outstanding settlements or debts exist.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Remove Partner'),
          content: const Text(
            'This will permanently remove this partner. All shared expenses will remain but you will no longer be connected.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Remove'),
            ),
          ],
        ),
      );

      if (confirmed == true && context.mounted) {
        context.read<PartnerBloc>().add(
          PartnerEvent.removePartner(partnershipId: partnership.id),
        );
      }
    } finally {
      if (mounted) setState(() => _removingIds.remove(partnership.id));
    }
  }

  String _partnerId(PartnershipEntity p) {
    final userId = sl<AuthLocalDatasource>().getUserId();
    return userId == p.senderId ? p.receiverId : p.senderId;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.partners.isEmpty) {
      return const PartnerEmptyView(
        title: 'No Partners Yet',
        subtitle: 'Add partners to start tracking shared expenses.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),

      itemBuilder: (_, index) {
        final partnership = widget.partners[index];
        final isSender =
            partnership.senderId == sl<AuthLocalDatasource>().getUserId();
        final nickname = isSender
            ? partnership.receiverNickname
            : partnership.senderNickname;
        final email = isSender
            ? partnership.receiverEmail
            : partnership.senderEmail;
        final isRemoving = _removingIds.contains(partnership.id);

        return PartnerTile(
          nickname: nickname,
          email: email,
          trailing: IconButton(
            icon: isRemoving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.person_remove_rounded, color: Colors.red),
            tooltip: 'Remove Partner',
            onPressed: isRemoving
                ? null
                : () => _confirmRemove(context, partnership),
          ),
        );
      },

      separatorBuilder: (_, _) => const SizedBox(height: 14),

      itemCount: widget.partners.length,
    );
  }
}

class _RequestsTab extends StatefulWidget {
  final List<PartnershipEntity> incomingRequests;
  final List<PartnershipEntity> outgoingRequests;
  const _RequestsTab({
    required this.incomingRequests,
    required this.outgoingRequests,
  });

  @override
  State<_RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<_RequestsTab> {
  final Set<String> _processingIds = {};

  @override
  Widget build(BuildContext context) {
    if (widget.incomingRequests.isEmpty && widget.outgoingRequests.isEmpty) {
      return const PartnerEmptyView(
        title: 'No Requests',
        subtitle: 'Incoming and outgoing partner requests will appear here.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),

      children: [
        /// INCOMING
        if (widget.incomingRequests.isNotEmpty) ...[
          const Text(
            'Incoming Requests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          ...widget.incomingRequests.map((request) {
            final isProcessing = _processingIds.contains(request.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),

              child: PartnerTile(
                nickname: request.senderNickname,
                email: request.senderEmail,

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(
                      onPressed: isProcessing
                          ? null
                          : () => _handleAction(context, request, reject: true),
                      icon: isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.close_rounded),
                    ),
                    IconButton(
                      onPressed: isProcessing
                          ? null
                          : () =>
                                _handleAction(context, request, reject: false),
                      icon: isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_rounded),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],

        /// OUTGOING
        if (widget.outgoingRequests.isNotEmpty) ...[
          const SizedBox(height: 28),

          const Text(
            'Pending Requests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          ...widget.outgoingRequests.map((request) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),

              child: PartnerTile(
                nickname: request.receiverNickname,
                email: request.receiverEmail,

                trailing: const Chip(label: Text('Sent')),
              ),
            );
          }),
        ],
      ],
    );
  }

  Future<void> _handleAction(
    BuildContext context,
    PartnershipEntity request, {
    required bool reject,
  }) async {
    setState(() => _processingIds.add(request.id));
    try {
      context.read<PartnerBloc>().add(
        reject
            ? PartnerEvent.rejectRequest(partnership: request)
            : PartnerEvent.acceptRequest(partnership: request),
      );
    } finally {
      if (mounted) setState(() => _processingIds.remove(request.id));
    }
  }
}
