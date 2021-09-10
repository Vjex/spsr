// import 'package:flutter/material.dart';

// import '../../utils/colors.dart';
// import '../../utils/margin_padding.dart';

// class MyDateField extends StatefulWidget {
//   final Function onADateSelected;
//   final String dateString;
//   final DateTime initialDate;
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final bool isClickEnabled;

//   MyDateField({
//     @required this.onADateSelected,
//     @required this.dateString,
//     this.initialDate,
//     this.firstDate,
//     this.lastDate,
//     this.isClickEnabled = true,
//   });

//   @override
//   _MyDateFieldState createState() => _MyDateFieldState();
// }

// class _MyDateFieldState extends State<MyDateField> {
//   String helpString;

//   @override
//   void initState() {
//     //initialising date String
//     helpString = widget.dateString;
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
//     showDatePicker(
//       // selectableDayPredicate: _getDates,

//       helpText: helpString,
//       context: context,

//       initialDate:
//           widget.initialDate != null ? widget.initialDate : DateTime.now(),
//       //which date will display when user open the picker
//       firstDate: widget.firstDate != null ? widget.firstDate : DateTime(1948),
//       //what will be the previous supported year in picker
//       lastDate: widget.lastDate != null ? widget.lastDate : DateTime.now(),
//     ) //what will be the up to supported date in picker
//         .then((pickedDate) {
//       //then usually do the future job
//       if (pickedDate == null) {
//         //if user tap cancel then this function will stop
//         return;
//       }
//       setState(() {
//         // //for rebuilding the ui
//         // DateFormat formatter = DateFormat('yyyy-MM-dd');
//         // setState(() {
//         //   dateString = formatter.format(pickedDate);
//         // });

//         //calling parent class method.
//         widget.onADateSelected(pickedDate);
//       });
//     });
//   }

//   // //Show Date Picker to Select A Date
//   // void _pickDateDialog() {
//   //   print('Clicked!!');
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return Dialog(
//   //         child: SfCalendar(
//   //           view: CalendarView.month,
//   //           ,
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   //Method

//   // bool _getDates(DateTime date) {
//   //   DateFormat formatter = DateFormat('yyyy-MM-dd');
//   //   List<String> available = [
//   //     "2020-10-10",
//   //     "2020-10-20",
//   //     "2020-10-21",
//   //     "2020-10-11",
//   //     "2020-10-13",
//   //     "2020-10-14",
//   //     "2020-10-17"
//   //   ];

//   //   String formattedDate = formatter.format(date);

//   //   return available.contains(formattedDate);
//   // }
// }
