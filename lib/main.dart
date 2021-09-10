// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './utils/route_screen_function.dart';
import './screens/login_screen.dart';
import './utils/colors.dart';
import './utils/routes.dart';

// import '../utils/route_screen_function.dart';
// import '../utils/routes_screen.dart';

void main() {
  //First fis App Orientation
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MyApp(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: const Color(0xff19aec4),
      100: const Color(0xff19aec4),
      200: const Color(0xff19aec4),
      300: const Color(0xff19aec4),
      400: const Color(0xff19aec4),
      500: const Color(0xff19aec4),
      600: const Color(0xff19aec4),
      700: const Color(0xff19aec4),
      800: const Color(0xff19aec4),
      900: const Color(0xff19aec4),
    };
    MaterialColor myColor = MaterialColor(0xff19aec4, color);
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cogent',
        theme: ThemeData(
          primarySwatch: myColor,
          accentColor: Colors.orange,
          backgroundColor: MyColors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
          primaryColor: myColor,
          primaryIconTheme:
              Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
        ),
        initialRoute: MyRoutes.INITIAL_ROUTE,
        //Setting NAmed Routes
        onGenerateRoute: (RouteSettings settings) {
          return wholeAppRouting(settings);
        },

        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          );
        },
      ),
    );
  }
}
