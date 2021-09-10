// import '../../utils/colors.dart';
// import '../../utils/margin_padding.dart';
// import 'package:intl/intl.dart';

// import '../../utils/styles.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// import 'package:flutter/material.dart';

// class DatePickerCustomRangeSelection extends StatefulWidget {
//   final Function onClickedOk;
//   final String helpText;
//   final DateTime minDate;
//   final DateTime maxDate;

//   const DatePickerCustomRangeSelection({
//     @required this.onClickedOk,
//     @required this.helpText,
//     this.minDate,
//     this.maxDate,
//   });

//   @override
//   _DatePickerCustomRangeSelectionState createState() =>
//       _DatePickerCustomRangeSelectionState();
// }

// class _DatePickerCustomRangeSelectionState
//     extends State<DatePickerCustomRangeSelection> {
//   String startDateSelectedString;
//   String endDateSelectedString;
//   DateTime startDateSelected;
//   DateTime endDateSelected;

//   DateTime today = DateTime.now();

//   DateTime defaultMaxDate;

//   @override
//   void initState() {
//     defaultMaxDate = DateTime(today.year + 2, today.month, today.day);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Dialog(
//       // content: Text('dfdfb'),
//       child: Container(
//         height: screenSize.height * 0.6,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: MarginPadding.MARGIN_SYMMETRIC_10_10,
//                 width: screenSize.width,
//                 child: Center(
//                     child: FittedBox(
//                   fit: BoxFit.contain,
//                   child: Text(
//                     widget.helpText,
//                     style: MyStyles.STYLE_col_black_size_14,
//                   ),
//                 )),
//               ),
//               Container(
//                 margin: MarginPadding.MARGIN_SYMMETRIC_10_10,
//                 child: SfDateRangePicker(
//                   view: DateRangePickerView.month,
//                   showNavigationArrow: true,
//                   allowViewNavigation: true,
//                   selectionColor: MyColors.primaryColor,
//                   todayHighlightColor: MyColors.primaryColor,

//                   rangeSelectionColor: MyColors.primaryColor.withOpacity(0.3),

//                   onSelectionChanged:
//                       (DateRangePickerSelectionChangedArgs arg) {
//                     DateFormat format = DateFormat('yyyy-MM-dd');

//                     if (arg.value is PickerDateRange) {
//                       PickerDateRange selectedDates = arg.value;

//                       if (selectedDates.endDate != null) {
//                         startDateSelectedString =
//                             format.format(selectedDates.startDate);
//                         endDateSelectedString =
//                             format.format(selectedDates.endDate);
//                         startDateSelected = selectedDates.startDate;
//                         endDateSelected = selectedDates.endDate;
//                       }

//                       setState(() {});
//                     }
//                   },
//                   // enableMultiView: true,
//                   minDate:
//                       widget.minDate != null ? widget.minDate : DateTime.now(),
//                   maxDate:
//                       widget.maxDate != null ? widget.maxDate : defaultMaxDate,
//                   selectionMode: DateRangePickerSelectionMode.range,
//                   // monthViewSettings:
//                   //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   FlatButton(
//                     child: Text("CANCEL"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   FlatButton(
//                     child: Text("OK"),
//                     onPressed: () {
//                       if (startDateSelectedString == null ||
//                           endDateSelectedString == null) {
//                         widget.onClickedOk(null, null, null, null);
//                       } else {
//                         //Pass The Selcted Dates To The Parent/Calling Class
//                         widget.onClickedOk(
//                           startDateSelectedString,
//                           endDateSelectedString,
//                           startDateSelected,
//                           endDateSelected,
//                         );
//                       }

//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
