import 'package:daelim_class/helpers/storage_helper.dart';
import 'package:daelim_class/routes/app_screen.dart';
import 'package:daelim_class/screens/login/login_screen.dart';
import 'package:daelim_class/screens/main/main_screen.dart';
import 'package:daelim_class/screens/setting/setting_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppScreen.login.toPath,
  redirect: (context, state) {
    Log.green('Route FullPath: ${state.fullPath}');

    if (state.fullPath == AppScreen.login.toPath) {
      return null;
    }

    if (StorageHelper.authData == null) {
      return AppScreen.login.toPath;
    }

    return null;
  },
  routes: [
    // NOTE: 로그인 화면
    GoRoute(
      path: AppScreen.login.toPath,
      name: AppScreen.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    // NOTE: 메인 화면
    GoRoute(
      path: AppScreen.main.toPath,
      name: AppScreen.main.name,
      pageBuilder: (context, state) => NoTransitionPage(
        child: MainScreen(),
      ),
    ),
    // NOTE: 설정 화면
    GoRoute(
      path: AppScreen.setting.toPath,
      name: AppScreen.setting.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingScreen(),
      ),
    ),
  ],
);
