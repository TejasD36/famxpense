import '../../xcore.dart';

class AddPartnerScreen extends StatefulWidget {
  const AddPartnerScreen({super.key});

  @override
  State<AddPartnerScreen> createState() => _AddPartnerScreenState();
}

class _AddPartnerScreenState extends State<AddPartnerScreen> {
  final _searchController = TextEditingController();

  bool _isLoading = false;

  _SearchState _searchState = _SearchState.initial;

  /// DUMMY SEARCH RESULT

  String nickname = '';

  String email = '';

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  Future<void> _searchUser() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    /// DUMMY LOGIC

    if (query == 'rahul' || query == 'rahul@gmail.com') {
      nickname = 'rahul';

      email = 'rahul@gmail.com';

      _searchState = _SearchState.found;
    } else if (query == 'amit') {
      nickname = 'amit';

      email = 'amit@gmail.com';

      _searchState = _SearchState.connected;
    } else if (query == 'rohit') {
      nickname = 'rohit';

      email = 'rohit@gmail.com';

      _searchState = _SearchState.pending;
    } else {
      _searchState = _SearchState.notFound;
    }

    setState(() {
      _isLoading = false;
    });
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

                          setState(() {
                            _searchState = _SearchState.initial;
                          });
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

              child: FilledButton(
                onPressed: _isLoading ? null : _searchUser,

                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Search'),
              ),
            ),

            const SizedBox(height: 28),

            /// RESULTS
            Expanded(
              child: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _buildContent()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_searchState) {
      case _SearchState.initial:
        return const PartnerEmptyView(
          title: 'Search Partners',

          subtitle:
              'Search using nickname '
              'or email to connect.',
        );

      case _SearchState.found:
        return PartnerTile(
          nickname: nickname,

          email: email,

          trailing: FilledButton(onPressed: () {}, child: const Text('Add')),
        );

      case _SearchState.connected:
        return PartnerTile(
          nickname: nickname,

          email: email,

          trailing: const Chip(label: Text('Connected')),
        );

      case _SearchState.pending:
        return PartnerTile(
          nickname: nickname,

          email: email,

          trailing: const Chip(label: Text('Pending')),
        );

      case _SearchState.notFound:
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
  }
}

enum _SearchState { initial, found, connected, pending, notFound }
