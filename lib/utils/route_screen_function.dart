import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/routes_screen.dart';
import '../utils/routes.dart';

import 'package:flutter/cupertino.dart';

Route<dynamic> wholeAppRouting(RouteSettings settings) {
  switch (settings.name) {
    case MyRoutes.INITIAL_ROUTE:
      return MaterialPageRoute(
        builder: (_) => SplashScreen(),
        settings: settings,
      );

    //Route for Date Home Page.
    case MyRoutes.HOME_ROUTE:
      return CupertinoPageRoute(
        builder: (_) => HomeScreen(),
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
