import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/scaffold/app_navigation_rail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final AppScreen appScreen;

  const AppScaffold({
    super.key,
    required this.appScreen,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppNavigationRail(
              appScreen: appScreen,
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
