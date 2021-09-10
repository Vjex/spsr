import 'dart:async';

import 'package:ntp/ntp.dart';

import '../utils/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/routes.dart';
import '../utils/colors.dart';

import 'dart:convert';

import 'package:package_info/package_info.dart';

import '../utils/constants.dart';

import 'package:dio/dio.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var sharedPreferences;

  var _isUserLogined;

  bool _is72HoursComplete = false;

  //dIO VARIABLE FOR http request with a base url(options) to be implemented in the initstate.
  Dio? _dio;

  // new Dio with a BaseOptions instance.
  //Note * : To Test a Local APi In Emuator Use HOST IP: 10.0.2.2
  BaseOptions _options = new BaseOptions(
    baseUrl: Constants.baseUrlLocal,
    connectTimeout: 52000,
    receiveTimeout: 52000,
  );

  // AppUpdateInfo _updateInfo;

  bool _isAppUpdateAvailable = false;
  bool _isMandatoryUpdate = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    //Applying base url with some other option in global class variable of DIO For server request.
    _dio = new Dio(_options);
  }

  //Delaying for 3000 milisecond to get spash effect
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});

    return true;
  }

  //Navigating to home
  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed(
      MyRoutes.HOME_ROUTE,
      // arguments: {
      //   'EmployeeID': _empID,
      //   'Designation': _employeeDesignation,
      //   //      'empPhone': _userPhone,
      // },
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
      sharedPreferences = sp;
      _isUserLogined = sharedPreferences.getBool('isUserLogined') ?? false;

      // will be null if never previously saved
      if (_isUserLogined == null) {
        _isUserLogined = false;
      }

      //Create Folder in the External storage name QCPML
    });

    //navigating affter delay of 2000 miliseconds.
    _mockCheckForSession().then((mockReturn) {
      //Validatinfg The User .
      _navigateToSignIN();
      //  _getSplashDataFromServer(_empID);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // /**********************************Internet Connectivity************************************ */
    // //Calling state class for continous connectivity Reslut. all over the app ap]fter this.
    // final stateInternet = Provider.of<InternetConnectivityState>(context);

    return Scaffold(
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
    );
  }

  //Method To get The Current App Verion From Server.
  void _getSplashDataFromServer(String empId) async {
    // print('Calld');
    var map = new Map<String, dynamic>();
    map['appkey'] = 'all';
    map['EmployeeID'] = empId != null ? empId.toUpperCase() : null;
    // map['cmId'] = _cmId != null ? _cmId : '';

    // print(map.toString());
    // print(_dio.options.baseUrl.toString());
    try {
      Response response = await _dio!
          .post("/App_ver_stop_com_coninfo_covid_all.php", data: map);

      if (response.statusCode == 200) {
        // print(response.toString());

        // return;
        //Validation For Other Check And Do Accroedingly

      } else {
        print('A network error occurred');
        throw Exception('Failed to Load App Update Date!');
      }
    } catch (e) {
      print(e);
    }
  }

  // //Method
  // void _validationCheckMethod(var response) {
  //   // print(response.toString());
  //   int responseStatusS = jsonDecode(response.toString())['statusS'] as int;
  //   // int responseStatusV = jsonDecode(response.toString())['statusV'] as int;
  //   int responseStatusC = jsonDecode(response.toString())['statusC'] as int;
  //   // int responseStatusAV =
  //   //     jsonDecode(response.toString())['statusAV'] as int;
  //   int responseStatusAVNEW =
  //       jsonDecode(response.toString())['statusAVNew'] as int;
  //   var imageurlObject = jsonDecode(response.toString())['ImageUrlObject'];
  //   int statusURLSlidingImages = imageurlObject['statusURL'] as int;

  //   //Special Bool to  Show Adhaar Verification
  //   bool _isAdhaarVerWarnoingDialogToShow = false;
  //   String msgDialogAdhaarVer = 'Please verify your adhaar.';
  //   String currTimegAdhaar;
  //   // int responseStatusCO =
  //   //     jsonDecode(response.toString())['statusCO'] as int;
  //   // int responseStatusPL =
  //   //     jsonDecode(response.toString())['statusPL'] as int;
  //   int responseStatusContactUpdate =
  //       jsonDecode(response.toString())['statusCUD'] as int;
  //   // print(responseStatusContactUpdate.toString());
  //   int responseStatusCovid =
  //       jsonDecode(response.toString())['statusCD'] as int;

  //   //Checking The App Stop Facility for All Users.
  //   // stop The App From Usage if any Stop Data Found
  //   if (responseStatusS == 1) {
  //     // print('App need To Stop ');

  //     dynamic appStopDetailsList =
  //         jsonDecode(response.toString())['appStopStatus'] as dynamic;

  //     //Naviagte To App Stop Message Screen
  //     Navigator.of(context).pushReplacementNamed(
  //         MyRoutes.STOP_APP_MSG_SCREEN_ROUTE,
  //         arguments: {'data': appStopDetailsList[0]});

  //     return;
  //   }

  //   // //Checking For Adhaar
  //   // if (responseStatusAV != null && responseStatusAV == 1) {
  //   //   int adhaarVStatus = jsonDecode(response.toString())['adhaarV'] as int;

  //   //   //Go to verify adhaar Screen if not verified
  //   //   if (adhaarVStatus == 0) {
  //   //     Navigator.of(context).pushReplacementNamed(
  //   //       MyRoutes.ADHAAR_AUTH_DIGILOCKER_SCREEN_ROUTE,
  //   //       arguments: {
  //   //         "EmployeeID": empId.toUpperCase(),
  //   //         "Designation": _employeeDesignation,
  //   //         "location": _employeeLocationId,
  //   //       },
  //   //     );

  //   //     return;
  //   //   }
  //   // }
  //   //
  //   //

  //   //Checking For Adhaar NEW
  //   if (responseStatusAVNEW != null && responseStatusAVNEW == 1) {
  //     int adhaarVStatusNEW =
  //         jsonDecode(response.toString())['adhaarVNew'] as int;

  //     //Go to verify adhaar Screen if not verified
  //     if (adhaarVStatusNEW == 0) {
  //       int adhaarVNewDialog =
  //           jsonDecode(response.toString())['adhaarVNewDialog'] as int;

  //       if (adhaarVNewDialog == 2) {
  //         msgDialogAdhaarVer =
  //             jsonDecode(response.toString())['msgAVNew'] as String;
  //         currTimegAdhaar =
  //             jsonDecode(response.toString())['CurrentTimeAVNew'] as String;

  //         //Show Warning Msg
  //         _isAdhaarVerWarnoingDialogToShow = true;
  //       } else if (adhaarVNewDialog == 3) {
  //         //Log Out The User And
  //         //

  //         String msgDialog =
  //             jsonDecode(response.toString())['msgAVNew'] as String;
  //         currTimegAdhaar =
  //             jsonDecode(response.toString())['CurrentTimeAVNew'] as String;
  //         User.logOutUser();
  //         _navigateToSignIN();
  //         _showAdhaarVerificationDialog(msgDialog, 1, currTimegAdhaar);
  //         //
  //         //
  //         return;
  //       }
  //     }
  //   }

  //   //If Time is Completed Then Navigate To Home Screen

  //   if (_isUserLogined != null && _isUserLogined && !_is72HoursComplete) {
  //     //Getting The Required data From Server.
  //     _navigateToHome();

  //     //Show Adhaar ver Warning Dialog if Needed
  //     if (_isAdhaarVerWarnoingDialogToShow)
  //       _showAdhaarVerificationDialog(msgDialogAdhaarVer, 0, currTimegAdhaar);
  //   } else {
  //     //Log Out User
  //     User.logOutUser();
  //     _navigateToSignIN();
  //   }

  //   // //Checking/updating Employee CO and PL.
  //   // //CO
  //   // if (responseStatusCO == 1) {
  //   //   dynamic coObject =
  //   //       jsonDecode(response.toString())['comboCount'] as dynamic;
  //   //   int coCount = coObject[0]['CO'];
  //   //   User.setEmpCO(coCount.toString());
  //   // }

  //   // //PL
  //   // if (responseStatusPL == 1) {
  //   //   dynamic coObject =
  //   //       jsonDecode(response.toString())['comboCount'] as dynamic;
  //   //   int coCount = coObject[0]['CO'];
  //   //   User.setEmpPL(coCount.toString());
  //   // }

  //   //Checking for covid declaration is to show
  //   if (responseStatusCovid == 0 && _empID != null) {
  //     //Naviagte to Covid Declaration Screen
  //     Navigator.of(context).pushReplacementNamed(
  //       MyRoutes.COVID_DECL_SCREEN_ROUTE,
  //       arguments: {
  //         'EmpName': _employeeName,
  //         'location': _employeeLocationId,
  //         'EmployeeID': _empID,
  //         'Designation': _employeeDesignation,
  //       },
  //     );

  //     //Show Adhaar ver Warning Dialog if Needed
  //     if (_isAdhaarVerWarnoingDialogToShow)
  //       _showAdhaarVerificationDialog(msgDialogAdhaarVer, 0, currTimegAdhaar);
  //     return;
  //   }

  //   //Now Finally Validating
  //   //Checking The for anny pending message. ==> not for Scahin Sir
  //   if (responseStatusC == 1 &&
  //       _empID != null &&
  //       _empID.toLowerCase() != 'CE03070003') {
  //     // dynamic appCommDetailsList =
  //     //     jsonDecode(response.toString())['communicationResponse']
  //     //         as dynamic;

  //     List<ComMessageViewModel> appCommDetailsList =
  //         (jsonDecode(response.toString())['communicationResponse'] as List)
  //             .map((comObj) => ComMessageViewModel.fromJson(comObj))
  //             .toList();

  //     //Naviagte To App Com  Message Screen
  //     Navigator.of(context).pushReplacementNamed(
  //       MyRoutes.COMM_MESSAGE_VIEWER_REPLY_SCREEN_ROUTE,
  //       arguments: {
  //         'data': appCommDetailsList,
  //         'EmployeeID': _empID,
  //         'Designation': _employeeDesignation,
  //       },
  //     );
  //     //Show Adhaar ver Warning Dialog if Needed
  //     if (_isAdhaarVerWarnoingDialogToShow)
  //       _showAdhaarVerificationDialog(msgDialogAdhaarVer, 0, currTimegAdhaar);

  //     return;
  //   }

  //   //Checking The Update Contact Info date Got Or Not
  //   if (responseStatusContactUpdate == 1 && _empID != null) {
  //     dynamic contactUpdateDateList =
  //         jsonDecode(response.toString())['contact_updated_date'] as dynamic;
  //     DateTime today = DateTime.now();
  //     DateTime contactUpdDate = DateFormat('yyyy-MM-dd')
  //         .parse(contactUpdateDateList[0]['created_on']);
  //     // print('Diff Days ${today.difference(contactUpdDate).inDays}');
  //     //Go to Update Contct Screen/Page
  //     if (today.difference(contactUpdDate).inDays > 15) {
  //       //Navigating Updare Contact Info Screen
  //       Navigator.of(context).pushReplacementNamed(
  //           MyRoutes.UPDATE_CONTACT_INFO_SCREEN_ROUTE,
  //           arguments: {
  //             'screenData': contactUpdateDateList[0],
  //             'EmployeeID': _empID,
  //             'EmpName': _employeeName,
  //             'Designation': _employeeDesignation,
  //           });
  //       //Show Adhaar ver Warning Dialog if Needed
  //       if (_isAdhaarVerWarnoingDialogToShow)
  //         _showAdhaarVerificationDialog(msgDialogAdhaarVer, 0, currTimegAdhaar);

  //       return;
  //     }
  //   }

  //   ///Checking for Sliding Images.
  //   if (statusURLSlidingImages != null && statusURLSlidingImages == 1) {
  //     bool isUserLogin = false;
  //     if (_isUserLogined != null && _isUserLogined && !_is72HoursComplete) {
  //       isUserLogin = true;
  //     }

  //     var imageList = imageurlObject['imageListURL'];
  //     var imageListDiscount = imageurlObject['imageListURLDiscount'];
  //     var imageListRecog = imageurlObject['imageListURLRecog'];

  //     //if Any Image Url Found Then Go To Sliding Update Screen.
  //     if ((imageList != null && imageList.length > 0) ||
  //         (imageListDiscount != null && imageListDiscount.length > 0) ||
  //         (imageListRecog != null && imageListRecog.length > 0)) {
  //       //going Updates and News Screen
  //       Navigator.of(context).pushReplacementNamed(
  //           MyRoutes.UPDATE_NEWS_SCREEN_ROUTE,
  //           arguments: {
  //             "ImageList": imageList,
  //             "ImageListRecog": imageListRecog,
  //             "ImageListDiscount": imageListDiscount,
  //             'EmployeeID': _empID,
  //             'Designation': _employeeDesignation,
  //             "IsUserLogined": isUserLogin
  //           });
  //       //Show Adhaar ver Warning Dialog if Needed
  //       if (_isAdhaarVerWarnoingDialogToShow)
  //         _showAdhaarVerificationDialog(msgDialogAdhaarVer, 0, currTimegAdhaar);

  //       return;
  //     }
  //   }
  // }

  // //Method To Show App Update Dialog.
  // void _showAppUpdateDialog(
  //     String dateFrom, String description, String newVersion, int isManadate) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async {
  //           // Navigator.of(context).pop();
  //           // Navigator.of(context).pop();
  //           if (isManadate != null && isManadate == 1) {
  //             SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //             return false;
  //           } else {
  //             return true;
  //           }
  //         },
  //         child: Dialog(
  //           child: AppUpdateAvailableDialogWidget(
  //             dateFrom: dateFrom,
  //             description: description,
  //             newVersion: newVersion,
  //             updateMandate: isManadate,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  //Method To Show Adhaar Verificattion Dialog.

  // void _showAdhaarVerificationDialog(
  //     String msg, int isManadate, String curTime) {
  //   // print('InNN');
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async {
  //           // Navigator.of(context).pop();
  //           // Navigator.of(context).pop();
  //           if (isManadate != null && isManadate == 1) {
  //             SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //             return false;
  //           } else {
  //             return true;
  //           }
  //         },
  //         child: Dialog(
  //           child: AdhaarVerifFixWarnDialogWidget(
  //             ismanadatory: isManadate,
  //             msg: msg,
  //             empId: _empID,
  //             empLocation: _employeeLocationId,
  //             currTimeFromServer: curTime,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

}
