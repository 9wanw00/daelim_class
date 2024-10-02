class AppScreen {login, main}

extension AppScreenExtensions on AppScreen{
  String get toPath{
    switch (this){
      case AppScreen.login:
        return '/login';
      case AppScreen.main:
        return '/main';
    }
  }
}