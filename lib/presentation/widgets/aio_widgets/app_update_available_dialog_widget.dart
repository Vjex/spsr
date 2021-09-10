// import '../../utils/constants.dart';

// import '../../utils/styles.dart';
// import '../../widgets/aio_widgets/my_button.dart';

// import '../../utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../utils/margin_padding.dart';

// class AppUpdateAvailableDialogWidget extends StatelessWidget {
//   final String dateFrom;
//   final String description;
//   final String newVersion;
//   final int updateMandate;

//   const AppUpdateAvailableDialogWidget({
//     required this.dateFrom,
//     required this.description,
//     required this.newVersion,
//     required this.updateMandate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Container(
//       // height: screenSize.height * 0.5,
//       padding: MarginPadding.PADDING_SYMMETRIC_15_15,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   child: Text(
//                     'New Update V$newVersion',
//                     style: MyStyles.STYLE_col_primary_size_20_bold,
//                   ),
//                 ),
//                 Container(
//                   width: screenSize.width * 0.3,
//                   height: screenSize.width * 0.3,
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     child: Icon(
//                       Icons.sentiment_neutral,
//                       color: MyColors.amber,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'What\'s New : \n \n$description',
//                   style: MyStyles.STYLE_col_black_size_16_bold,
//                   textAlign: TextAlign.left,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                     child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (updateMandate == 0)
//                       MyButton(
//                         width: 100,
//                         margin: MarginPadding.MARGIN_ONLY_Right_10,
//                         onClick: () {
//                           //Hiding KeyBoard If Visible.
//                           FocusScopeNode currentFocus = FocusScope.of(context);

//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }

//                           Navigator.of(context).pop();
//                         },
//                         btnTxt: 'Next Time',
//                         backColor: MyColors.primaryColor,
//                         textColor: MyColors.white,
//                       ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     MyButton(
//                       width: 130,
//                       margin: MarginPadding.MARGIN_ONLY_Right_10,
//                       onClick: () {
//                         //Hiding KeyBoard If Visible.
//                         FocusScopeNode currentFocus = FocusScope.of(context);

//                         if (!currentFocus.hasPrimaryFocus) {
//                           currentFocus.unfocus();
//                         }

//                         _launchURL();
//                       },
//                       btnTxt: 'Update Now',
//                       backColor: MyColors.primaryColor,
//                       textColor: MyColors.white,
//                     ),
//                   ],
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _launchURL() async {
//     const url = Constants.appUrl;

//     try {
//       if (await canLaunch(url)) {
//         await launch(url);
//       } else {
//         throw 'Could not launch $url';
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
