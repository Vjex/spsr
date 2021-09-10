// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../utils/colors.dart';
// import '../../utils/margin_padding.dart';

// class MyDateFieldSelectedOnly extends StatefulWidget {
//   final Function onADateSelected;
//   final String dateString;
//   final DateTime initialDate;
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final List<String> enabledaysList;
//   final String msgForWaiting;
//   final bool isClickEnabled;

//   ///Note Initial Date Passed Should Definetly in the enabledList
//   ///
//   MyDateFieldSelectedOnly({
//     @required this.onADateSelected,
//     @required this.dateString,
//     @required this.initialDate,
//     @required this.firstDate,
//     @required this.lastDate,
//     @required this.enabledaysList,
//     @required this.msgForWaiting,
//     this.isClickEnabled = true,
//   });

//   @override
//   _MyDateFieldSelectedOnlyState createState() =>
//       _MyDateFieldSelectedOnlyState();
// }

// class _MyDateFieldSelectedOnlyState extends State<MyDateFieldSelectedOnly> {
//   String helpString;

//   @override
//   void initState() {
//     //initialising date String
//     helpString = widget.dateString;

//     print(widget.enabledaysList);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: _getDateWidget(),
//     );
//   }

//   //Method to Show Selected Date Widget
//   Widget _getDateWidget() {
//     return Container(
//       margin: MarginPadding.MARGIN_SYMMETRIC_0_15,
//       width: double.infinity,
//       child: InkWell(
//         onTap: widget.isClickEnabled
//             ? () {
//                 //passing 0 to assign pickd date to Employee Dob.
//                 _pickDateDialog();
//               }
//             : null,
//         child: Container(
//           padding: MarginPadding.PADDING_SYMMETRIC_15_15,
//           width: MediaQuery.of(context).size.width * 0.4,
//           child: Text(widget.dateString),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.grey,
//               width: 1.0,
//             ),
//             color: MyColors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }

//   //Show Date Picker to Select A Date
//   void _pickDateDialog() {
//     if (widget.enabledaysList.length > 0) {
//       //Split date to match the Selectable Date
//       List<String> selectableDatesList = widget.enabledaysList[0].split('-');
//       int year = int.parse(selectableDatesList[0]);
//       int month = int.parse(selectableDatesList[1]);
//       int day = int.parse(selectableDatesList[2]);

//       showDatePicker(
//         selectableDayPredicate: _getDates,
//         helpText: helpString,
//         context: context,
//         initialDate: DateTime(year, month, day),
//         //widget.initialDate,
//         //which date will display when user open the picker
//         firstDate: widget.firstDate,
//         //what will be the previous supported year in picker
//         lastDate: widget.lastDate,
//       ) //what will be the up to supported date in picker
//           .then((pickedDate) {
//         //then usually do the future job
//         if (pickedDate == null) {
//           //if user tap cancel then this function will stop
//           return;
//         }
//         setState(() {
//           widget.onADateSelected(pickedDate);
//         });
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(widget.msgForWaiting),
//           duration: Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   //Method
//   bool _getDates(DateTime date) {
//     DateFormat formatter = DateFormat('yyyy-MM-dd');

//     String formattedDate = formatter.format(date);

//     return widget.enabledaysList.contains(formattedDate);
//   }
// }
