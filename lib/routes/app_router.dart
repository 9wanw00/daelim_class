import 'package:daelim_class/main/main_screen.dart';
import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRoutter = GoRouter(
  routes: [
    GoRoute(
      path: AppScreen.login.toPath,
      name: AppScreen.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppScreen.main.toPath,
      name: AppScreen.main.name,
      builder: (context, state) => const MainScreen(),
    ),
  ],
);
