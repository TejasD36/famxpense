import '../../xcore.dart';

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Partners'),

          centerTitle: false,

          bottom: const TabBar(
            tabs: [
              Tab(text: 'Connected'),

              Tab(text: 'Requests'),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.pushNamed(AppRoute.addPartner.name);
          },

          icon: const Icon(Icons.person_add_alt_1_rounded),

          label: const Text('Add Partner'),
        ),

        body: TabBarView(
          children: [
            /// CONNECTED
            _ConnectedTab(),

            /// REQUESTS
            _RequestsTab(),
          ],
        ),
      ),
    );
  }
}

class _ConnectedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// DUMMY DATA

    final partners = [(nickname: 'rahul', email: 'rahul@gmail.com'), (nickname: 'amit', email: 'amit@gmail.com')];

    if (partners.isEmpty) {
      return const PartnerEmptyView(
        title: 'No Partners Yet',

        subtitle:
            'Add partners to start '
            'tracking shared expenses.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),

      itemBuilder: (_, index) {
        final partner = partners[index];

        return PartnerTile(nickname: partner.nickname, email: partner.email, trailing: const Icon(Icons.chevron_right_rounded));
      },

      separatorBuilder: (_, _) => const SizedBox(height: 14),

      itemCount: partners.length,
    );
  }
}

class _RequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// DUMMY DATA

    final incomingRequests = [(nickname: 'saurabh', email: 'saurabh@gmail.com')];

    final outgoingRequests = [(nickname: 'rohit', email: 'rohit@gmail.com')];

    if (incomingRequests.isEmpty && outgoingRequests.isEmpty) {
      return const PartnerEmptyView(
        title: 'No Requests',

        subtitle:
            'Incoming and outgoing '
            'partner requests will appear here.',
      );
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
                nickname: request.nickname,

                email: request.email,

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.close_rounded)),

                    IconButton(onPressed: () {}, icon: const Icon(Icons.check_rounded)),
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
                nickname: request.nickname,

                email: request.email,

                trailing: const Chip(label: Text('Pending')),
              ),
            );
          }),
        ],
      ],
    );
  }
}
