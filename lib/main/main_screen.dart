import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final int _selectedIndex = 0;

  // 화면을 전환할 때 보여줄 위젯
  final List<Widget> _screens = [
    const Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 50),
      ),
    ),
    const Center(
      child: Text(
        'Settings',
        style: TextStyle(fontSize: 50),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appScreen: AppScreen.main,
      child: Center(
        child: Text(
          '메인',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
