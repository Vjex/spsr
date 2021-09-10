// import '../../utils/colors.dart';
// import '../../utils/margin_padding.dart';
// import '../../utils/styles.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:flutter/material.dart';

// class DatePickerCustom extends StatefulWidget {
//   final Function onClickedOk;
//   final String helpText;
//   final List<DateTime> preSelctedDates;

//   const DatePickerCustom({
//     @required this.onClickedOk,
//     @required this.helpText,
//     @required this.preSelctedDates,
//   });

//   @override
//   _DatePickerCustomState createState() => _DatePickerCustomState();
// }

// class _DatePickerCustomState extends State<DatePickerCustom> {
//   String datesSlectedString;
//   // String initialStringString;
//   List<DateTime> selcteddatesList = [];

//   @override
//   void initState() {
//     datesSlectedString = widget.helpText;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Dialog(
//       // content: Text('dfdfb'),
//       child: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.6),
//           child: Container(
//             height: screenSize.height * 0.6,
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     margin: MarginPadding.MARGIN_SYMMETRIC_10_10,
//                     width: screenSize.width,
//                     child: Center(
//                         child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: Text(
//                         datesSlectedString,
//                         style: MyStyles.STYLE_col_black_size_14,
//                       ),
//                     )),
//                   ),
//                   Container(
//                     margin: MarginPadding.MARGIN_SYMMETRIC_10_10,
//                     child: SfDateRangePicker(
//                       view: DateRangePickerView.month,
//                       showNavigationArrow: true,
//                       allowViewNavigation: true,
//                       selectionColor: MyColors.primaryColor,
//                       todayHighlightColor: MyColors.primaryColor,

//                       initialSelectedDates: widget.preSelctedDates.length > 0
//                           ? widget.preSelctedDates
//                           : [],
//                       onSelectionChanged:
//                           (DateRangePickerSelectionChangedArgs arg) {
//                         DateFormat format = DateFormat('MM/dd/yyyy');
//                         if (arg.value is List<DateTime>) {
//                           List<DateTime> selectedDates = arg.value;
//                           // print(selectedDates.toString());

//                           datesSlectedString = '';

//                           //Set To The Variable For Passing To Parent Class.
//                           selcteddatesList = selectedDates;
//                           for (int i = 0; i < selectedDates.length; i++) {
//                             if (selectedDates.length == 1) {
//                               datesSlectedString =
//                                   format.format(selectedDates[i]) + ' ';
//                               setState(() {});
//                             } else {
//                               if (i == (selectedDates.length - 1)) {
//                                 datesSlectedString = datesSlectedString +
//                                     format.format(selectedDates[i]);
//                                 setState(() {});
//                               } else {
//                                 datesSlectedString = datesSlectedString +
//                                     format.format(selectedDates[i]) +
//                                     ' , ';
//                               }
//                             }
//                           }
//                         } else {
//                           setState(() {
//                             datesSlectedString = 'Select';
//                             selcteddatesList = [];
//                           });
//                         }
//                       },
//                       // enableMultiView: true,
//                       selectionMode: DateRangePickerSelectionMode.multiple,
//                       // monthViewSettings:
//                       //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       FlatButton(
//                         child: Text("CANCEL"),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       FlatButton(
//                         child: Text("OK"),
//                         onPressed: () {
//                           //Pass The Selcted Dates To The Parent/Calling Class
//                           widget.onClickedOk(
//                               datesSlectedString, selcteddatesList);
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
