import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spsr/logic/cubit/auth_cubit.dart';
import 'package:spsr/logic/cubit/internet_cubit.dart';
import 'package:spsr/logic/utility/app_bloc_observer.dart';
import 'package:spsr/presentation/router/app_router.dart';
import 'package:spsr/presentation/router/routes_screen.dart';

import './utils/colors.dart';

// import '../utils/route_screen_function.dart';
// import '../utils/routes_screen.dart';

void main() {
  //First fis App Orientation
  WidgetsFlutterBinding.ensureInitialized();

  //Saving the AppBloc Observer so that Each Bloc or Cubit can be mainatiner by our observer Class under utility folder which
  //is under logic folder.
  Bloc.observer = AppBlocObserver();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MyApp(
          appRoute: AppRouter(),
          connectivity: Connectivity(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRoute;
  final Connectivity connectivity;

  const MyApp({Key? key, required this.appRoute, required this.connectivity})
      : super(key: key);

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
      child: MultiProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          // BlocProvider<SettingsCubit>(
          //   create: (counterCubitContext) => SettingsCubit(),
          //   lazy: false,
          // ),
        ],
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
            primaryIconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: Colors.white),
          ),
          //Setting NAmed Routes
          onGenerateRoute: appRoute.onGenertaRoute,
        ),
      ),
    );
  }
}
