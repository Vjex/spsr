// import 'package:intl/intl.dart';

// import '../../widgets/aio_widgets/shimmer_loader.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
// import 'package:provider/provider.dart';

// import '../../states/internet_connctivity_state.dart';
// import '../../utils/margin_padding.dart';
// import '../../utils/styles.dart';
// import '../../utils/colors.dart';
// import '../../utils/routes.dart';
// import '../../utils/user.dart';
// import '../../utils/constants.dart';

// class MainDrawer extends StatefulWidget {
//   @override
//   _MainDrawerState createState() => _MainDrawerState();
// }

// class _MainDrawerState extends State<MainDrawer> {
//   //Variableto get The Attandance details.
//   String _employeeId;
//   String _employeeDesignation;
//   String _employeePhotoUrl;
//   String _employeeName;
//   String _employeeIsH;
//   String _employeeIsOH;
//   String _employeeIsAH;
//   String _employeeStatus;
//   String _employeeDOJ;
//   String _empWorkFrom;
//   String _empAdhaarVStatus;
//   // String _employeeCO;
//   // String _employeePL;
//   List<String> _employeeDOJList;
//   var _employeeDetailObject;

//   //Variables For Show/Hide The Sub Menus of main Tile in The Drawer.
//   bool _isSubmitReqVisible = false;
//   bool _isViewReqVisible = false;
//   bool _isApproveReqVisible = false;
//   bool _isSettingsReqVisible = false;
//   bool _isEmployeeCanApproveReq = false;
//   bool _isDashoardMainOpended = false;
//   bool _isRequestMainOpended = false;
//   bool _isWFHBiometricOpended = false;

//   //Varaible To Check/ Enable Approove DownTime Request Is Allowed To The Logined Emp Or Not.
//   bool _isLoginEmpCanApprooveDowTime = false;

//   //Varaibles To get the HAppy To help request Referaable Employee List.
//   List<String> employeeIdHTHList = [];
//   List<String> employeeNameHTHList = [];

//   //dIO VARIABLE FOR http request with a base url(options) to be implemented in the initstate.
//   Dio _dio;

//   BaseOptions _options = BaseOptions(
//     baseUrl: Constants.baseUrlLocal,
//     connectTimeout: 22000,
//     receiveTimeout: 22000,
//   );

//   //Variables For Checking whether Employee Can Download ESIC Card and Appointment Letter Or Not.
//   bool _isESICCardVisible = false;
//   bool _isApLetterVisible = false;

//   String _appVersion;

// //Var to Check Whether Logined Emp can Search The WFH Emp Details
//   bool _isWFHSearchEnabled = false;
//   //Local List Of USRS Who can Access the Dashboard Functionality.
//   List<String> _employeeDashboardAccessList = ['CE11091302', 'CE03070003'];

//   //Var To related to Adhaar verification.
//   DateTime _empDOJDate;
//   DateTime _checkDate;
//   bool _isValidEmployee = false;

//   @override
//   void initState() {
//     // print('Print!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
//     //Applying base url with some other option in global class variable of DIO For server request.
//     _dio = new Dio(_options);

//     //Get The Employeee Profile Details Object .
//     User.getEmployeeDetails().then((value) {
//       _employeeDetailObject = value;
//       _employeeId = value['EmployeeID'];
//       // print('$_employeeId');
//       _employeeDesignation = value['Designation'];
//       _employeePhotoUrl = value['PhotoUrl'];
//       _employeeStatus = value['status'];
//       // _empAdhaarVStatus = value['AdhaarVStatus'];
//       _employeeDOJ = value['DOJ'];

//       // if()

//       // print(_employeeDOJ);

//       DateFormat format = DateFormat('yyyy-MM-dd');
//       // _employeeCO = value['empCO'];
//       // _employeePL = value['empPL'];

//       if (_employeeDOJ != null && _employeeDOJ.isNotEmpty) {
//         _empDOJDate = format.parse(_employeeDOJ);
//         _checkDate = format.parse('2021-02-15');

//         _isValidEmployee =
//             _checkDate.difference(_empDOJDate).inDays >= 0 ? true : false;

//         setState(() {});
//         _employeeDOJList = _employeeDOJ.split('-');
//       }
//       // print(_employeeDOJ.toString());
//       _employeeName = value['EmpName'];
//       _employeeIsH = value['isH'];

//       _employeeIsOH = value['empOh'];
//       _employeeIsAH = value['empAh'];
//       _empWorkFrom = value['empWorkFrom'];

//       // print('Work From  : ' + _empWorkFrom.toString());
//       // String isAH = value['isAH'];
//       _isEmployeeCanApproveReq =
//           _employeeIsAH.toUpperCase() == 'YES' ? true : false;
//       // print('$_isEmployeeCanApproveReq employeeeeeee');
//       // checkReq()

//       // setState(() {});
//       //Get DownTime Approve List
//       User.isEmpcanApprooveDownTimeReq(_dio, _employeeId).then(
//         (isLoginEmpCanApprooveDowTimeObject) {
//           if (isLoginEmpCanApprooveDowTimeObject != null) {
//             if (isLoginEmpCanApprooveDowTimeObject['isCanApprooveDownTime']
//                     as bool !=
//                 null) {
//               _isLoginEmpCanApprooveDowTime =
//                   isLoginEmpCanApprooveDowTimeObject['isCanApprooveDownTime']
//                       as bool;

//               setState(() {
//                 // print('Downtime Check');
//               });
//             }
//           }
//         },
//       );

//       //is Adhaar Verified By User.
//       User.isEmpAadhaarVerified(_dio, _employeeId).then((adhaarVSttaus) {
//         if (adhaarVSttaus != null) {
//           _empAdhaarVStatus = adhaarVSttaus;
//           setState(() {});
//         }
//       });

//       //Getting That Employe Can See/ Download The ESIC and Appointment letter.
//       User.isEmpcanDownloadESICAndAppointmentLetter(_dio, _employeeId)
//           .then((dataObject) {
//         // print('aa gyaa!!');
//         if (dataObject != null) {
//           // print(dataObject.toString());
//           _isESICCardVisible = dataObject['isDownloadedESICCard'];
//           _isApLetterVisible = dataObject['isDownloadedAppointmentLetter'];
//           setState(() {
//             // print('Esic and Ap  Check');
//           });
//         }
//       });

//       //get WFH Empl Search Option Enabled EMP List.
//       if (_employeeDesignation != null &&
//           _employeeDesignation.toUpperCase() != 'CSA')
//         User.getWFHEmplSearchEnabledList(_dio).then((employeeList) {
//           // print(employeeList.toString());
//           if (employeeList != null && employeeList.length > 0)
//             _isWFHSearchEnabled =
//                 employeeList.contains(_employeeId.toUpperCase());

//           setState(() {
//             // print('HTH  Check');
//           });
//         });
//     });

//     //get Referaable Employee List For Happy To Help Approval.
//     User.getReferableEmpDetailsForHTHApproval(_dio)
//         .then((referableEmployeeList) {
//       employeeIdHTHList =
//           referableEmployeeList['employeeIdList'] as List<String>;

//       // print(employeeIdHTHList.toString());

//       // print(employeeIdHTHList.contains(_employeeId.toUpperCase()));
//       employeeNameHTHList =
//           referableEmployeeList['employeeNameList'] as List<String>;
//       setState(() {
//         // print('HTH  Check');
//       });
//     });

//     super.initState();
//   }

//   // @override
//   // void didChangeDependencies() {

//   //   super.didChangeDependencies();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (_appVersion == null)
//       PackageInfo.fromPlatform().then((packageInfo) {
//         // String versionNumber = packageInfo.buildNumber;
//         _appVersion = packageInfo.version;
//       });
//     /**********************************Internet Connectivity************************************ */
//     //Calling state class for continous connectivity Reslut. all over the app ap]fter this.
//     final stateInternet = Provider.of<InternetConnectivityState>(context);

//     stateInternet.checkConnectivity(context);
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//               color: MyColors.white,
//               width: double.infinity,
//               height: 2,
//             ),
//             _getAccountNameAndPhotoTopWidget(),
//             const SizedBox(
//               height: 20,
//             ),
//             _getFeaturesAndScreenTilesWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   //Method to get the Dfferent Screens and Features tiles Widgets in Darawer
//   Widget _getFeaturesAndScreenTilesWidget() {
//     return Container(
//       child: Column(
//         children: [
//           buildListTile(
//             MyColors.greenColor,
//             'Attendance',
//             Icons.perm_contact_calendar,
//             () {
//               //going to home
//               Navigator.of(context).pushReplacementNamed(
//                 MyRoutes.HOME_ROUTE2,
//                 arguments: {
//                   'EmployeeID': _employeeId,
//                   'Designation': _employeeDesignation,
//                 },
//               );
//             },
//           ),
//           buildListTile(
//             MyColors.greenColor,
//             'Home New',
//             Icons.perm_contact_calendar,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.HOME_SCREEN_NEW_SCREEN_ROUTE,
//               );
//             },
//           ),
//           if (_empAdhaarVStatus != null &&
//               _empAdhaarVStatus.isNotEmpty &&
//               _empAdhaarVStatus == "0" &&
//               _isValidEmployee)
//             buildListTile(
//               MyColors.purple,
//               'Verify Aadhaar',
//               Icons.verified_user,
//               () {
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.ADHAAR_AUTH_DIGILOCKER_SCREEN_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           if ((_empWorkFrom != null && _empWorkFrom.toUpperCase() == 'WFH') ||
//               _isWFHSearchEnabled)
//             buildListTileMain(
//               MyColors.purple,
//               'WFH Biometric',
//               Icons.panorama_fish_eye_sharp,
//               _onPressedWFHBiometricTile,
//               _isWFHBiometricOpended,
//             ),
//           if (_isWFHBiometricOpended) _getSubMenusOfWFHBiometric(),
//           buildListTileMain(
//             MyColors.navyBlue,
//             'Request',
//             Icons.receipt,
//             _onPressedRequestMainTile,
//             _isRequestMainOpended,
//           ),
//           if (_isRequestMainOpended) _getSubMenusOfRequest(),
//           if ((_employeeIsH != null && _employeeIsH.toUpperCase() == 'YES') ||
//               (_employeeId != null
//                   ? _employeeDashboardAccessList.contains(
//                       _employeeId.toUpperCase(),
//                     )
//                   : false))
//             buildListTileMain(
//               MyColors.amber,
//               'DashBoard',
//               Icons.dashboard,
//               _onPressedDashBoardMainTile,
//               _isDashoardMainOpended,
//             ),
//           if (_isDashoardMainOpended) _getSubMenusOfDashBoard(),
//           buildListTileMain(
//             MyColors.greyDark,
//             'Settings',
//             Icons.settings,
//             _onPressedSettingsRequestTile,
//             _isSettingsReqVisible,
//           ),
//           if (_isSettingsReqVisible) _getSubMenusOfSettingsReq(),
//           // buildListTile(
//           //   MyColors.olive,
//           //   'View 2',
//           //   Icons.perm_contact_calendar,
//           //   () {
//           //     //going to home
//           //     Navigator.of(context).pushReplacementNamed(
//           //       MyRoutes.HOME_ROUTE,
//           //       arguments: {
//           //         'EmployeeID': _employeeId,
//           //         'Designation': _employeeDesignation,
//           //       },
//           //     ); //Replacing the existing page as we are adding the Drawer on each page.
//           //   },
//           // ),
//           if (_isESICCardVisible != null && _isESICCardVisible == true)
//             buildListTile(
//               MyColors.steelBlue,
//               'ESIC Card',
//               Icons.card_membership,
//               () {
//                 //going to ESIC Screen
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.ESIC_CARD_SCREEN_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           if (_employeeStatus != null &&
//               _employeeStatus == '6' &&
//               _employeeDOJList != null &&
//               int.parse(_employeeDOJList[0]) >= 2019 &&
//               int.parse(_employeeDOJList[1]) >= 1)
//             if (_isApLetterVisible != null && _isApLetterVisible == true)
//               buildListTile(
//                 MyColors.magenta,
//                 'Appointment Letter',
//                 Icons.insert_drive_file,
//                 () {
//                   //going to Appointment Letter Screen.
//                   Navigator.of(context).pushNamed(
//                     MyRoutes.APPOINTMENT_LETTER_SCREEN_ROUTE,
//                     arguments: _employeeDetailObject,
//                   );
//                 },
//               ),
//           if (_employeeDesignation != null &&
//               _employeeDesignation.toUpperCase() != 'CSA')
//             buildListTile(
//               MyColors.olive,
//               'Notes',
//               Icons.note_add,
//               () {
//                 //going to ESIC Screen
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.NOTES_SCREEN_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           buildListTile(
//             MyColors.black,
//             'Holidays List',
//             Icons.work_off,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.HO_LIST_SCREEN_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//           buildListTile(
//             MyColors.seaGreen,
//             'Announcements',
//             Icons.announcement,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.ANOUNCEMENTS_LIST_SCREEN_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//           buildListTile(
//             MyColors.purple,
//             'Reference',
//             Icons.new_releases,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.REFRENCE_REGISTRATION_CANDIDATE_SCREEN_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//           buildListTile(
//             MyColors.red,
//             'Log Out',
//             Icons.exit_to_app,
//             () {
//               //Log Out User
//               User.logOutUser();
//               //going to home
//               Navigator.of(context).pushReplacementNamed(
//                 MyRoutes.SIGNIN_ROUTE,
//               );
//             },
//           ),
//           if (_appVersion == null)
//             Container(
//               width: 50,
//               alignment: Alignment.center,
//               child: ShimmerLoaderWidget(rowRequired: 1),
//             ),
//           if (_appVersion != null)
//             Container(
//               // width: 20,
//               alignment: Alignment.center,
//               child: Text(
//                 '© Cogent V$_appVersion',
//                 style: MyStyles.STYLE_col_primary_size_14_bold,
//               ),
//             ),
//         ],
//       ),
//     );
//   }

// //Method to get the Submenus of Submit request
//   Widget _getSubMenusOfSubmitReq() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         buildListSubTile(
//           MyColors.maroon,
//           'Exception',
//           Icons.report_problem,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.EXCEPTION_EMPLOYEE_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         buildListSubTile(
//           MyColors.steelBlue,
//           'Leave',
//           Icons.stop_screen_share,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.LEAVE_EMPLOYEE_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         if (_employeeDesignation == 'CSA')
//           buildListSubTile(
//             MyColors.yellowVeryDark,
//             'DownTime',
//             Icons.timer_off,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.DOWNTIME_EMPLOYEE_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//         buildListSubTile(
//           MyColors.navyBlue,
//           'Happy To Help',
//           Icons.account_balance,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.HAPPY_TO_HELP_EMPLOYEE_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//       ]),
//     );
//   }

//   //Method to get the Submenus of Submit request
//   Widget _getSubMenusOfViewReq() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         buildListSubTile(
//           MyColors.maroon,
//           'Exception',
//           Icons.report_problem,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.EXCEPTION_REQUEST_EMPLOYEE_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         buildListSubTile(
//           MyColors.steelBlue,
//           'Leave',
//           Icons.stop_screen_share,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.LEAVE_EMPLOYEE_REQUEST_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         if (_employeeDesignation == 'CSA')
//           buildListSubTile(
//             MyColors.yellowVeryDark,
//             'DownTime',
//             Icons.timer_off,
//             () {
//               //going to home
//               Navigator.of(context).pushNamed(
//                 MyRoutes.DOWNTIME_EMPLOYEE_REQUESTS_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//         buildListSubTile(
//           MyColors.navyBlue,
//           'Happy To Help',
//           Icons.account_balance,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.HAPPY_TO_HELP_REQUESTS_EMPLOYEE_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//       ]),
//     );
//   }

//   //Method to get the Submenus of Submit request
//   Widget _getSubMenusOfapproveReq() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(
//         children: [
//           if (_isEmployeeCanApproveReq)
//             buildListSubTile(
//               MyColors.maroon,
//               'Exception',
//               Icons.report_problem,
//               () {
//                 //going to home
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.EXCEPTION_EMPLOYEE_APPROVE_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           if ((_employeeId != null
//                   ? _employeeId.toString().toUpperCase() != 'CE01145570' &&
//                       _isEmployeeCanApproveReq
//                   : false) ||
//               (_employeeIsOH != null && _employeeIsOH.toUpperCase() == 'YES'
//                   ? true
//                   : false))
//             buildListSubTile(
//               MyColors.steelBlue,
//               'Leave',
//               Icons.stop_screen_share,
//               () {
//                 //going to home
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.LEAVE_EMPLOYEE_APPROVE_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           if (_employeeId != null ? _isLoginEmpCanApprooveDowTime : false)
//             buildListSubTile(
//               MyColors.yellowVeryDark,
//               'DownTime',
//               Icons.timer_off,
//               () {
//                 //going to home
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.DOWNTIME_EMPLOYEE_APPROVE_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//           if (employeeIdHTHList.contains(_employeeId.toUpperCase()) ||
//               _employeeId.toString().toUpperCase() == 'CE01145570')
//             buildListSubTile(
//               MyColors.navyBlue,
//               'Happy To Help',
//               Icons.account_balance,
//               () {
//                 //going to home
//                 Navigator.of(context).pushNamed(
//                   MyRoutes.HAPPY_TO_HELP_APPROVE_EMPLOYEE_ROUTE,
//                   arguments: _employeeDetailObject,
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }

//   //Method to get the Submenus of Dashorad
//   Widget _getSubMenusOfDashBoard() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         buildListSubTile(
//           MyColors.greenDark,
//           'Operation',
//           Icons.settings_applications,
//           () {
//             _onPressedDashBoardTile(
//                 'http://172.105.61.198/web/index.php?r=dashboard/delivery&employee_id=',
//                 'delivery');
//           },
//         ),
//         buildListSubTile(
//           MyColors.navyBlue,
//           'Quality',
//           Icons.high_quality,
//           () {
//             _onPressedDashBoardTile(
//                 'http://172.105.61.198/web/index.php?r=dashboard2/quality&employee_id=',
//                 'quality');
//           },
//         ),
//         buildListSubTile(
//           MyColors.blue,
//           'Attendance',
//           Icons.person,
//           () {
//             //Going Dashboard Attendance Screen
//             Navigator.of(context).pushNamed(
//               MyRoutes.DASHBOARD_ATTENDANCE_SCREEN_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         buildListSubTile(
//           MyColors.pink,
//           'NCNS Pendency',
//           Icons.not_interested_rounded,
//           () {
//             //Going Dashboard Attendance Screen
//             Navigator.of(context).pushNamed(
//               MyRoutes.DASHBOARD_NCNS_DETAILS_SCREEN_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//         // buildListSubTile(
//         //   MyColors.olive,
//         //   'Interview',
//         //   Icons.person_add,
//         //   () {
//         //     //Going Dashboard Attendance Screen
//         //     Navigator.of(context).pushNamed(
//         //       MyRoutes.DASHBOARD_INTERVIEW_SCREEN_ROUTE,
//         //       arguments: _employeeDetailObject,
//         //     );
//         //   },
//         // ),
//       ]),
//     );
//   }

//   //Method to get the Submenus of Dashorad
//   Widget _getSubMenusOfWFHBiometric() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         if (_empWorkFrom != null && _empWorkFrom.toUpperCase() == 'WFH')
//           buildListSubTile(
//             MyColors.skyBlue,
//             'Punch',
//             Icons.remove_red_eye,
//             () {
//               //going to Biometric Screen
//               Navigator.of(context).pushNamed(
//                 MyRoutes.BIOMETRIC_ATTENDNACE_INSERT_SCREEN_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//         if (_isWFHSearchEnabled)
//           buildListSubTile(
//             MyColors.greenDark,
//             'Track',
//             Icons.remove_red_eye_sharp,
//             () {
//               //going to Search WFH employee BIo Inserted Location Screen
//               Navigator.of(context).pushNamed(
//                 MyRoutes.SEARCH_WFH_EMPLOYEE_BIO_SCREEN_ROUTE,
//                 arguments: _employeeDetailObject,
//               );
//             },
//           ),
//       ]),
//     );
//   }

//   //Method to get the Submenus of Dashorad
//   Widget _getSubMenusOfRequest() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         buildListTileMain(
//           MyColors.primaryColor,
//           'Raise',
//           Icons.receipt,
//           _onPressedSubmitRequestTile,
//           _isSubmitReqVisible,
//         ),
//         if (_isSubmitReqVisible) _getSubMenusOfSubmitReq(),
//         buildListTileMain(
//           MyColors.steelBlue,
//           'View',
//           Icons.receipt,
//           _onPressedViewRequestsTile,
//           _isViewReqVisible,
//         ),
//         if (_isViewReqVisible) _getSubMenusOfViewReq(),
//         if (_isEmployeeCanApproveReq ||
//             _isLoginEmpCanApprooveDowTime ||
//             (_employeeId != null
//                 ? _employeeId.toString().toUpperCase() == 'CE01145570'
//                 : false || employeeIdHTHList.contains(_employeeId)) ||
//             (_employeeIsOH != null && _employeeIsOH.toUpperCase() == 'YES'
//                 ? true
//                 : false))
//           buildListTileMain(
//             MyColors.maroon,
//             'Approve',
//             Icons.receipt,
//             _onPressedApproveRequestTile,
//             _isApproveReqVisible,
//           ),
//         if (_isApproveReqVisible) _getSubMenusOfapproveReq(),
//       ]),
//     );
//   }

//   //Method to get the Submenus of Submit request
//   Widget _getSubMenusOfSettingsReq() {
//     return Container(
//       color: MyColors.greyVeryLight,
//       child: Column(children: [
//         buildListSubTile(
//           MyColors.amber,
//           'Change Password',
//           Icons.lock,
//           () {
//             //going to home
//             Navigator.of(context)
//                 .pushNamed(MyRoutes.CHANGE_PASSWORD_SCREEN_ROUTE, arguments: {
//               'EmployeeID': _employeeId,
//               'calledFrom': '1',
//             });
//           },
//         ),
//         buildListSubTile(
//           MyColors.greenDark,
//           'Change Security',
//           Icons.security,
//           () {
//             //going to home
//             Navigator.of(context).pushNamed(
//               MyRoutes.CHANGE_SECURITY_KEY_SCREEN_ROUTE,
//               arguments: _employeeDetailObject,
//             );
//           },
//         ),
//       ]),
//     );
//   }

//   //Method for Top Account Name and Photo Widget
//   Widget _getAccountNameAndPhotoTopWidget() {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.22,
//       width: double.infinity,
//       padding: const EdgeInsets.only(
//         top: 30,
//         left: 20,
//         right: 20,
//         bottom: 10,
//       ),
//       alignment: Alignment.centerLeft,
//       color: MyColors.primaryColor,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _employeeName != null
//                             ? _employeeName
//                             : 'Cogent Employee',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                           color: MyColors.white,
//                         ),
//                       ),
//                       Text(
//                         _employeeDesignation != null
//                             ? _employeeDesignation
//                             : '',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w900,
//                           fontSize: 15,
//                           color: MyColors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   //Navigate to Profile Screen
//                   Navigator.of(context).pushNamed(MyRoutes.PROFILE_VIEW_ROUTE,
//                       arguments: _employeeDetailObject);
//                 },
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundColor: MyColors.white,
//                   backgroundImage:
//                       _employeePhotoUrl == null || _employeePhotoUrl == ''
//                           ? AssetImage('assets/images/businessman.png')
//                           : NetworkImage(_employeePhotoUrl),
//                 ),
//               ),
//             ],
//           ),
//           // Container(
//           //   child: Row(
//           //     children: [
//           //       Text(
//           //         _employeeCO != null ? 'CO: $_employeeCO' : 'CO: -',
//           //         style: MyStyles.STYLE_col_white_size_14_bold,
//           //       ),
//           //       SizedBox(
//           //         width: 30,
//           //       ),
//           //       Text(
//           //         _employeePL != null ? 'PL: $_employeePL' : 'PL: -',
//           //         style: MyStyles.STYLE_col_white_size_14_bold,
//           //       ),
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }

//   //Methid To Create any new tile in the Drawer.
//   Widget buildListTile(
//       Color backCol, String title, IconData icon, Function tapHandler) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: tapHandler,
//         splashColor: MyColors.greyLight,
//         child: ListTile(
//           leading: Container(
//             width: 30,
//             height: 30,
//             padding: MarginPadding.PADDING_ALL_7,
//             decoration: BoxDecoration(
//               color: backCol,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(17),
//               ),
//             ),
//             child: Center(
//               child: Icon(
//                 icon,
//                 size: 16,
//                 color: MyColors.white,
//               ),
//             ),
//           ),
//           title: Text(
//             title,
//             style: MyStyles.STYLE_col_black_size_14,
//           ),
//         ),
//       ),
//     );
//   }

//   //Method To Create any new Sub tile in the Drawer.
//   Widget buildListSubTile(
//       Color backCol, String title, IconData icon, Function tapHandler) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: tapHandler,
//         splashColor: MyColors.greyLight,
//         child: ListTile(
//           leading: Container(
//             width: 30,
//             height: 30,
//             margin: MarginPadding.MARGIN_ONLY_Left_30,
//             padding: MarginPadding.PADDING_ALL_7,
//             decoration: BoxDecoration(
//               color: backCol,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(17),
//               ),
//             ),
//             child: Center(
//               child: Icon(
//                 icon,
//                 size: 16,
//                 color: MyColors.white,
//               ),
//             ),
//           ),
//           title: Text(
//             title,
//             style: MyStyles.STYLE_col_black_size_14,
//           ),
//         ),
//       ),
//     );
//   }

//   //Methid To Create any new tile in the Drawer.
//   Widget buildListTileMain(Color backCol, String title, IconData icon,
//       Function tapHandler, bool showHideBool) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: tapHandler,
//         splashColor: MyColors.greyLight,
//         child: ListTile(
//           leading: Container(
//             width: 30,
//             height: 30,
//             padding: MarginPadding.PADDING_ALL_7,
//             decoration: BoxDecoration(
//               color: backCol,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(17),
//               ),
//             ),
//             child: Center(
//               child: Icon(
//                 icon,
//                 size: 16,
//                 color: MyColors.white,
//               ),
//             ),
//           ),
//           title: Text(
//             title,
//             style: MyStyles.STYLE_col_black_size_14,
//           ),
//           trailing: Icon(
//             showHideBool ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//           ),
//         ),
//       ),
//     );
//   }

//   ///***********************************Methods*********************************** */

// //Method To Got To DashBoard WebView Page
//   void _onPressedDashBoardTile(String urlPass, String urlType) {
//     //going to DashBoard Screen
//     Navigator.of(context).pushNamed(
//       MyRoutes.DASHBOARD_SCREEN_ROUTE,
//       arguments: {
//         'empData': _employeeDetailObject,
//         'urlToUse': urlPass,
//         'urlType': urlType,
//       },
//     );
//   }

//   //Method To revoked on Presses Submit Request Main tile.
//   void _onPressedSubmitRequestTile() {
//     setState(() {
//       _isSubmitReqVisible
//           ? _isSubmitReqVisible = false
//           : _isSubmitReqVisible = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedApproveRequestTile() {
//     setState(() {
//       _isApproveReqVisible
//           ? _isApproveReqVisible = false
//           : _isApproveReqVisible = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedDashBoardMainTile() {
//     setState(() {
//       _isDashoardMainOpended
//           ? _isDashoardMainOpended = false
//           : _isDashoardMainOpended = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedRequestMainTile() {
//     setState(() {
//       _isRequestMainOpended
//           ? _isRequestMainOpended = false
//           : _isRequestMainOpended = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedWFHBiometricTile() {
//     setState(() {
//       _isWFHBiometricOpended
//           ? _isWFHBiometricOpended = false
//           : _isWFHBiometricOpended = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedSettingsRequestTile() {
//     setState(() {
//       _isSettingsReqVisible
//           ? _isSettingsReqVisible = false
//           : _isSettingsReqVisible = true;
//     });
//   }

//   //Method To revoked on Presses Approve Request Main tile.
//   void _onPressedViewRequestsTile() {
//     setState(() {
//       _isViewReqVisible ? _isViewReqVisible = false : _isViewReqVisible = true;
//     });
//   }

//   void checkReq() {}
// }
