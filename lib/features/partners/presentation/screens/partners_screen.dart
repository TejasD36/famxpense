import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';
import '../blocs/partner_bloc.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<PartnerBloc>().add(const PartnerEvent.loadPartners());
  }

  Future<void> _reloadPartners() async {
    final bloc = context.read<PartnerBloc>();
    bloc.add(const PartnerEvent.loadPartners());
    await bloc.stream.firstWhere((s) => s.maybeWhen(loading: () => false, orElse: () => true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartnerBloc, PartnerState>(
      builder: (context, state) {
        final requestCount = state.maybeWhen(loaded: (_, _, incoming, outgoing) => incoming.length + outgoing.length, orElse: () => 0);

        return DefaultTabController(
          length: 2,

          child: Scaffold(
            appBar: AppBar(
              title: Padding(padding: const EdgeInsets.symmetric(horizontal: 13.0), child: const Text('Partners')),

              centerTitle: false,

              actions: [
                IconButton(
                  onPressed: () => context.pushNamed(AppRoute.addPartner.name),
                  icon: const Icon(Icons.person_add_alt_1_rounded),
                  tooltip: 'Add Partner',
                ),
              ],

              bottom: TabBar(
                tabs: [
                  const Tab(text: 'Connected'),
                  Tab(
                    child: Badge.count(count: requestCount, isLabelVisible: requestCount > 0, child: const Text('Requests')),
                  ),
                ],
              ),
            ),

            body: state.when(
              initial: () => const Center(child: Text('Loading...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (_, connectedPartners, incomingRequests, outgoingRequests) {
                return TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: () => _reloadPartners(),
                      child: _ConnectedTab(partners: connectedPartners),
                    ),
                    RefreshIndicator(
                      onRefresh: () => _reloadPartners(),
                      child: _RequestsTab(incomingRequests: incomingRequests, outgoingRequests: outgoingRequests),
                    ),
                  ],
                );
              },
              error: (message) => Center(child: Text(message)),
            ),
          ),
        );
      },
    );
  }
}

class _ConnectedTab extends StatelessWidget {
  final List<PartnershipEntity> partners;
  const _ConnectedTab({required this.partners});

  @override
  Widget build(BuildContext context) {
    if (partners.isEmpty) {
      return const PartnerEmptyView(title: 'No Partners Yet', subtitle: 'Add partners to start tracking shared expenses.');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),

      itemBuilder: (_, index) {
        final partnership = partners[index];
        final isSender = partnership.senderId == sl<AuthLocalDatasource>().getUserId();
        final nickname = isSender ? partnership.receiverNickname : partnership.senderNickname;
        final email = isSender ? partnership.receiverEmail : partnership.senderEmail;

        return PartnerTile(nickname: nickname, email: email, trailing: const Icon(Icons.chevron_right_rounded));
      },

      separatorBuilder: (_, _) => const SizedBox(height: 14),

      itemCount: partners.length,
    );
  }
}

class _RequestsTab extends StatelessWidget {
  final List<PartnershipEntity> incomingRequests;
  final List<PartnershipEntity> outgoingRequests;
  const _RequestsTab({required this.incomingRequests, required this.outgoingRequests});

  @override
  Widget build(BuildContext context) {
    if (incomingRequests.isEmpty && outgoingRequests.isEmpty) {
      return const PartnerEmptyView(title: 'No Requests', subtitle: 'Incoming and outgoing partner requests will appear here.');
    }

    return ListView(
      padding: const EdgeInsets.all(20),

      children: [
        /// INCOMING
        if (incomingRequests.isNotEmpty) ...[
          const Text('Incoming Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 14),

          ...incomingRequests.map((request) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),

              child: PartnerTile(
                nickname: request.senderNickname,
                email: request.senderEmail,

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(
                      onPressed: () => context.read<PartnerBloc>().add(PartnerEvent.rejectRequest(partnership: request)),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    IconButton(
                      onPressed: () => context.read<PartnerBloc>().add(PartnerEvent.acceptRequest(partnership: request)),
                      icon: const Icon(Icons.check_rounded),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],

        /// OUTGOING
        if (outgoingRequests.isNotEmpty) ...[
          const SizedBox(height: 28),

          const Text('Pending Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 14),

          ...outgoingRequests.map((request) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),

              child: PartnerTile(
                nickname: request.receiverNickname,
                email: request.receiverEmail,

                trailing: const Chip(label: Text('Pending')),
              ),
            );
          }),
        ],
      ],
    );
  }
}
