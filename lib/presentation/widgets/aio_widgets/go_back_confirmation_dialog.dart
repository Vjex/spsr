// import '../../utils/colors.dart';
// import '../../utils/margin_padding.dart';
// import '../../utils/styles.dart';
// import '../../widgets/aio_widgets/my_button.dart';
// import 'package:flutter/material.dart';

// class GoBackConfirmationDialogWidget extends StatelessWidget {
//   final String msg;
//   const GoBackConfirmationDialogWidget({@required this.msg});

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Container(
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
//                   width: screenSize.width * 0.3,
//                   height: screenSize.width * 0.3,
//                   child: FittedBox(
//                     fit: BoxFit.cover,
//                     child: Icon(
//                       Icons.sentiment_dissatisfied,
//                       color: MyColors.primaryColor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 15,
//                   ),
//                   child: Text(
//                     msg,
//                     style: MyStyles.STYLE_col_black_size_16_bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
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
//                         btnTxt: 'Cancel',
//                         backColor: MyColors.primaryColor,
//                         textColor: MyColors.white,
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       MyButton(
//                         width: 100,
//                         margin: MarginPadding.MARGIN_ONLY_Right_10,
//                         onClick: () {
//                           //Hiding KeyBoard If Visible.
//                           FocusScopeNode currentFocus = FocusScope.of(context);

//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }

//                           //Pop Screen And Dialog Both.
//                           Navigator.of(context).pop();
//                           Navigator.of(context).pop();
//                         },
//                         btnTxt: 'Yes',
//                         backColor: MyColors.primaryColor,
//                         textColor: MyColors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
