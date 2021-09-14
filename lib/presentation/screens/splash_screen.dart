import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntp/ntp.dart';
import 'package:spsr/data/models/user_sp_model.dart';
import 'package:spsr/data/models/user_sr_model.dart';
import 'package:spsr/data/utility/user_data.dart';
import 'package:spsr/logic/cubit/auth_cubit.dart';

import '../../utils/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routes.dart';
import '../../utils/colors.dart';

import 'dart:convert';

import 'package:package_info/package_info.dart';

import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _sharedPreferences;
  var _isUserLogined;
  var _userType;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    //Applying base url with some other option in global class variable of DIO For server request.
    // _dio = new Dio(_options);
  }

  //Delaying for 3000 milisecond to get spash effect
  // Future<bool> _mockCheckForSession() async {
  //   await Future.delayed(Duration(milliseconds: 2000), () {});

  //   return true;
  // }

  //Navigating to home SP
  void _navigateToHomeSP() {
    Navigator.of(context).pushReplacementNamed(
      MyRoutes.HOME_SP_ROUTE,
    );
  }

  //Navigating to home SR
  void _navigateToHomeSR() {
    Navigator.of(context).pushReplacementNamed(
      MyRoutes.HOME_SR_ROUTE,
    );
  }

  //Navigating to SignIN
  void _navigateToSignIN() {
    Navigator.of(context).pushReplacementNamed(
      MyRoutes.SIGNIN_LOGIN,
    );
  }

  @override
  void didChangeDependencies() {
    //Checking the User is Logined or not from shared prefrences.
    SharedPreferences.getInstance().then((SharedPreferences sp) async {
      _sharedPreferences = sp;
      _isUserLogined = _sharedPreferences.getBool('isUserLogined') ?? false;
      String _userType = _sharedPreferences.getString('userType') ?? '';
      // will be null if never previously saved
      if (_isUserLogined == null) {
        _isUserLogined = false;
      }

      // sp
      if (_isUserLogined && _userType.isNotEmpty && _userType == 'sp') {
        var d = await User.getEmployeeDetails();

        var data = SPModel.fromMap(d);
        BlocProvider.of<AuthCubit>(context).loginSPSrUserBackend(spUser: data);
      } else if (_isUserLogined && _userType.isNotEmpty && _userType == 'sr') {
        var d = await User.getEmployeeDetails();

        var data = SRModel.fromMap(d);
        BlocProvider.of<AuthCubit>(context).loginSPSrUserBackend(srUser: data);
      } else {
        BlocProvider.of<AuthCubit>(context).emitAuthInitialState();
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _navigateToSignIN();

        // if (state is AuthLoginSPSuccess) {
        //   //Now Navigate to SP Home Screen
        //   _navigateToHomeSP();
        // } else if (state is AuthLoginSRSuccess) {
        //   //Now Navigate to SR Home Screen
        //   _navigateToHomeSR();
        // } else {
        //   _navigateToSignIN();
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Center(
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Opacity(opacity: 0.5, child: Image.asset('assets/img/bg.png')),
                Shimmer.fromColors(
                  period: Duration(milliseconds: 3000),
                  baseColor: MyColors.primaryColor, //Color(0xff7f00ff),
                  highlightColor: MyColors.accentColor, //Color(0xffe100ff),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Image(
                      image: AssetImage('assets/images/icon.png'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
