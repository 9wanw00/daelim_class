import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:daelim_class/routes/app_screen.dart';

class AppNavigationRail extends StatelessWidget {
  final AppScreen appScreen;

  const AppNavigationRail({
    super.key,
    required this.appScreen,
  });

  // 수정 필요
  @override
  Widget build(BuildContext context) {
    final screens =
        AppScreen.values.where((e) => e != AppScreen.login).toList();

    return NavigationRail(
      onDestinationSelected: (value) {
        final screen = screens[value];
        context.pushNamed(screen.name);
      },
      selectedIndex: screens.indexOf(appScreen),
      destinations: screens.map((e) {
        return NavigationRailDestination(
          icon: Icon(e.getIcon),
          label: Text(e.name),
        );
      }).toList(),
    );
  }
}
