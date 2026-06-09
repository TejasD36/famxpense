import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../core.dart';

class MainNavigation extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MainNavigation({super.key, required this.shell});

  final List<IconData> _icons = const [Icons.home_rounded, Icons.people_rounded, Icons.receipt_long_rounded, Icons.person_rounded];

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: shell,

      floatingActionButton: isKeyboardVisible
          ? null
          : FloatingActionButton(
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
        activeIndex: shell.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => shell.goBranch(index, initialLocation: index != shell.currentIndex),
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.onSurfaceVariant,
        iconSize: 24,
        elevation: 8,
      ),
    );
  }
}
