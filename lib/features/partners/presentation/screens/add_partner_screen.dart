import 'package:share_plus/share_plus.dart';

import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';
import '../blocs/partner_bloc.dart';

class AddPartnerScreen extends StatefulWidget {
  const AddPartnerScreen({super.key});

  @override
  State<AddPartnerScreen> createState() => _AddPartnerScreenState();
}

class _AddPartnerScreenState extends State<AddPartnerScreen> {
  final _searchController = TextEditingController();
  bool _isSending = false;

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

      body: BlocListener<PartnerBloc, PartnerState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_, _, _, outgoing) {
              if (_isSending) {
                _isSending = false;
                sl<RefreshNotifier>().notifyDataChanged();
                Navigator.pop(context);
              }
            },
            error: (message) {
              if (_isSending) {
                _isSending = false;
              }
            },
            orElse: () {},
          );
        },
        child: Padding(
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

                child: BlocBuilder<PartnerBloc, PartnerState>(
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
                    return FilledButton(
                      onPressed: isLoading ? null : _searchUser,
                      child: isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Search'),
                    );
                  },
                ),
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
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline_rounded, size: 64),
                                const SizedBox(height: 16),
                                Text(message, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
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
                                  final userId = sl<AuthLocalDatasource>().getUserId();
                                  final user = userId != null ? sl<UserLocalDatasource>().getUser(userId) : null;
                                  final nickname = user?.nickname ?? 'Someone';
                                  final message =
                                      'Join me on FamXpense to track shared expenses!\n\n'
                                      '$nickname is already using it to manage expenses with friends and family.\n\n'
                                      'Download: https://famxpense-web.vercel.app/';
                                  SharePlus.instance.share(ShareParams(text: message));
                                },

                                icon: const Icon(Icons.share_rounded),

                                label: const Text('Invite'),
                              ),
                            ],
                          );
                        }

                        /// USER FOUND

                        final isConnected = connectedPartners.any((e) {
                          return e.senderId == searchedUser.id || e.receiverId == searchedUser.id;
                        });

                        final isPending =
                            outgoingRequests.any((e) {
                              return e.receiverId == searchedUser.id;
                            }) ||
                            incomingRequests.any((e) {
                              return e.senderId == searchedUser.id;
                            });

                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Text(
                                    searchedUser.nickname.isNotEmpty ? searchedUser.nickname[0].toUpperCase() : '?',
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(searchedUser.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                  '@${searchedUser.nickname}',
                                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  searchedUser.email,
                                  style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: isConnected
                                      ? OutlinedButton.icon(
                                          onPressed: null,
                                          icon: const Icon(Icons.check_circle_rounded),
                                          label: const Text('Connected'),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          ),
                                        )
                                      : isPending
                                      ? OutlinedButton.icon(
                                          onPressed: null,
                                          icon: const Icon(Icons.hourglass_empty_rounded),
                                          label: const Text('Request Sent'),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          ),
                                        )
                                      : FilledButton.icon(
                                          onPressed: _isSending
                                              ? null
                                              : () {
                                                  setState(() => _isSending = true);
                                                  context.read<PartnerBloc>().add(PartnerEvent.sendRequest(user: searchedUser));
                                                },
                                          icon: _isSending
                                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                              : const Icon(Icons.person_add_alt_1_rounded),
                                          label: Text(_isSending ? 'Sending...' : 'Add Partner'),
                                          style: FilledButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          ),
                                        ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
