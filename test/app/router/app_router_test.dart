import 'package:famxpense/app/router/app_router.dart';
import 'package:famxpense/app/router/route_name.dart';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('bottom navigation is Home, Activity, Partners, Profile', () {
    final router = AppRouter.createRouter();
    addTearDown(router.dispose);

    final shell = router.configuration.routes
        .whereType<StatefulShellRoute>()
        .single;
    final branchNames = shell.branches
        .map((branch) => (branch.routes.single as GoRoute).name)
        .toList();

    expect(branchNames, [
      AppRoute.home.name,
      AppRoute.activity.name,
      AppRoute.partners.name,
      AppRoute.profile.name,
    ]);
  });

  test('statistics is standalone and activity is not duplicated', () {
    final router = AppRouter.createRouter();
    addTearDown(router.dispose);

    final topLevel = router.configuration.routes.whereType<GoRoute>().toList();
    expect(
      topLevel.where((route) => route.name == AppRoute.statistics.name),
      hasLength(1),
    );
    expect(
      topLevel.where((route) => route.name == AppRoute.activity.name),
      isEmpty,
    );
  });

  test(
    'links to shell Activity replace location instead of pushing a page',
    () {
      for (final path in [
        'lib/features/expenses/presentation/screens/home_screen.dart',
        'lib/features/profile/presentation/screens/profile_screen.dart',
      ]) {
        final source = File(path).readAsStringSync();
        expect(source, contains('goNamed(AppRoute.activity.name)'));
        expect(source, isNot(contains('pushNamed(AppRoute.activity.name)')));
        expect(source, isNot(contains('push(AppRoute.activity.path)')));
      }
    },
  );
}
