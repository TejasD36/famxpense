import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../core.dart';
import '../../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

class MainNavigation extends StatefulWidget {
  final StatefulNavigationShell shell;

  const MainNavigation({super.key, required this.shell});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  StreamSubscription<bool>? _connectivitySub;
  late final RefreshNotifier _refreshNotifier;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    final connectivity = sl<ConnectivityService>();
    _connectivitySub = connectivity.onStatusChanged.listen(
      _onConnectivityChanged,
    );
    connectivity.startMonitoring();

    _refreshNotifier = sl<RefreshNotifier>();
    _refreshNotifier.addListener(_onRefresh);
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    _refreshNotifier.removeListener(_onRefresh);
    super.dispose();
  }

  void _onRefresh() {
    final error = _refreshNotifier.lastSyncError;
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.orange.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      _refreshNotifier.clearSyncError();
    }
  }

  Future<void> _onConnectivityChanged(bool online) async {
    final wasOnline = _isOnline;
    if (mounted) setState(() => _isOnline = online);
    if (!online || wasOnline) return;

    final userId = sl<AuthLocalDatasource>().getUserId();
    if (userId == null) return;
    await sl<SyncService>().syncAll(userId: userId);
    sl<RefreshNotifier>().notifyDataChanged();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            context.go(AppRoute.login.path);
          },
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            if (!_isOnline)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                color: Theme.of(context).colorScheme.errorContainer,
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 16,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'You are offline. Changes will sync when connected.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(child: widget.shell),
          ],
        ),

        floatingActionButton: isKeyboardVisible
            ? null
            : FloatingActionButton(
                heroTag: 'add_expense_fab',
                shape: CircleBorder(),
                onPressed: () {
                  context.push(AppRoute.addExpense.path);
                },
                child: const Icon(Icons.add),
              ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: _icons,
          backgroundColor: Theme.of(context).colorScheme.surface,
          activeIndex: widget.shell.currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) => widget.shell.goBranch(
            index,
            initialLocation: index != widget.shell.currentIndex,
          ),
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).colorScheme.onSurfaceVariant,
          iconSize: 24,
          elevation: 8,
        ),
      ),
    );
  }

  static const _icons = [
    Icons.home_rounded,
    Icons.receipt_long_rounded,
    Icons.people_rounded,
    Icons.person_rounded,
  ];
}
