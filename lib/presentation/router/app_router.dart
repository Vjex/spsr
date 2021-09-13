import 'package:flutter/cupertino.dart';

import '/presentation/router/routes.dart';
import 'routes_screen.dart';

class AppRouter {
  Route onGenertaRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.INITIAL_ROUTE:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );

      //Route for Date Home Page.
      case MyRoutes.HOME_SP_ROUTE:
        return CupertinoPageRoute(
          builder: (_) => HomeScreenSP(),
          settings: settings,
        );

      //Route for Date Home Page SR.
      case MyRoutes.HOME_SR_ROUTE:
        return MaterialPageRoute(
          builder: (_) => HomeScreenSR(),
          settings: settings,
        );

      //Route for Date Details Single Page.
      case MyRoutes.SIGNIN_LOGIN:
        return CupertinoPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );

      //Route for Date Details Single Page.
      case MyRoutes.SIGNUP_REGISTER:
        return CupertinoPageRoute(
          builder: (_) => SignUpScreen(),
          settings: settings,
        );

      //Route for Date Details Single Page.
      case MyRoutes.FORGET_PASSWORD_ROUTE:
        return CupertinoPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
    }
  }

  // void dispose() {
  //   _counterCubit.close();
  // }
}
