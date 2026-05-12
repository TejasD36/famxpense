import '../../core.dart';

class MainNavigation extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MainNavigation({super.key, required this.shell});

  void _onTap(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoute.addExpense.path);
        },

        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: shell.currentIndex,

        onTap: _onTap,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.groups_rounded), label: 'Groups'),

          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Activity'),

          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
