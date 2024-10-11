import 'package:daelim_class/helpers/storage_helper.dart';
import 'package:daelim_class/main/main_screen.dart';
import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/screens/login_screen.dart';
import 'package:daelim_class/setting/setting_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppScreen.login.toPath,
  redirect: (context, state) {
    debugPrint(state.fullPath);

    if (state.fullPath != AppScreen.login.toPath) {
      if (StorageHelper.authData == null) {
        return AppScreen.login.toPath;
      }
      return null;
    }

    return null;
  },
  routes: [
    // NOTE: 로그인 화면
    GoRoute(
      path: AppScreen.login.toPath,
      name: AppScreen.login.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
    // NOTE: 메인 화면
    GoRoute(
      path: AppScreen.main.toPath,
      name: AppScreen.main.name,
      pageBuilder: (context, state) => NoTransitionPage(
        child: MainScreen(),
      ),
    ),
    // NOTE: 세팅 화면
    GoRoute(
      path: AppScreen.setting.toPath,
      name: AppScreen.setting.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingScreen(),
      ),
    ),
  ],
);
