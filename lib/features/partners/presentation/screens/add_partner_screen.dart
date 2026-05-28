import '../../xcore.dart';
import '../blocs/partner_bloc.dart';

class AddPartnerScreen extends StatefulWidget {
  const AddPartnerScreen({super.key});

  @override
  State<AddPartnerScreen> createState() => _AddPartnerScreenState();
}

class _AddPartnerScreenState extends State<AddPartnerScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  void _searchUser() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    context.read<PartnerBloc>().add(PartnerEvent.searchUser(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Partner')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            /// SEARCH FIELD
            TextField(
              controller: _searchController,

              textInputAction: TextInputAction.search,

              onSubmitted: (_) => _searchUser(),

              decoration: InputDecoration(
                hintText: 'Search by nickname or email',

                prefixIcon: const Icon(Icons.search_rounded),

                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();

                          context.read<PartnerBloc>().add(const PartnerEvent.clearSearch());
                        },

                        icon: const Icon(Icons.close_rounded),
                      )
                    : null,

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),

            const SizedBox(height: 18),

            /// SEARCH BUTTON
            SizedBox(
              width: double.infinity,

              child: FilledButton(onPressed: _searchUser, child: const Text('Search')),
            ),

            const SizedBox(height: 28),

            /// RESULTS
            Expanded(
              child: BlocBuilder<PartnerBloc, PartnerState>(
                builder: (context, state) {
                  return state.when(
                    /// INITIAL
                    initial: () {
                      return const PartnerEmptyView(
                        title: 'Search Partners',

                        subtitle:
                            'Search using nickname '
                            'or email to connect.',
                      );
                    },

                    /// LOADING
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },

                    /// ERROR
                    error: (message) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const PartnerEmptyView(
                            title: 'User Not Found',

                            subtitle:
                                'Invite them to join '
                                'FamXpense.',
                          ),

                          const SizedBox(height: 24),

                          FilledButton.icon(
                            onPressed: () {
                              /// SHARE INVITE LATER
                            },

                            icon: const Icon(Icons.share_rounded),

                            label: const Text('Invite'),
                          ),
                        ],
                      );
                    },

                    /// LOADED
                    loaded: (searchedUser, connectedPartners, incomingRequests, outgoingRequests) {
                      /// USER NOT FOUND

                      if (searchedUser == null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const PartnerEmptyView(
                              title: 'User Not Found',

                              subtitle:
                                  'Invite them to join '
                                  'FamXpense.',
                            ),

                            const SizedBox(height: 24),

                            FilledButton.icon(
                              onPressed: () {
                                /// SHARE INVITE LATER
                              },

                              icon: const Icon(Icons.share_rounded),

                              label: const Text('Invite'),
                            ),
                          ],
                        );
                      }

                      /// CHECK CONNECTION STATUS

                      final isConnected = connectedPartners.any((e) {
                        return e.senderId == searchedUser.id || e.receiverId == searchedUser.id;
                      });

                      final isPending = outgoingRequests.any((e) {
                        return e.receiverId == searchedUser.id;
                      });

                      return PartnerTile(
                        nickname: searchedUser.nickname,

                        email: searchedUser.email,

                        trailing: isConnected
                            ? const Chip(label: Text('Connected'))
                            : isPending
                            ? const Chip(label: Text('Pending'))
                            : FilledButton(
                                onPressed: () {
                                  context.read<PartnerBloc>().add(PartnerEvent.sendRequest(user: searchedUser));
                                },

                                child: const Text('Add'),
                              ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
