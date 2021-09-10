import '../../widgets/aio_widgets/my_button.dart';
import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '/utils/margin_padding.dart';

class UnsuccessFullDialogWidget extends StatelessWidget {
  final String msg;
  final int popTimes;
  const UnsuccessFullDialogWidget({required this.msg, this.popTimes = 1});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.4,
      padding: MarginPadding.PADDING_SYMMETRIC_15_15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: screenSize.width * 0.25,
            height: screenSize.width * 0.25,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(
                Icons.sentiment_very_dissatisfied,
                color: MyColors.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              msg,
              style: TextStyle(
                color: MyColors.red,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyButton(
            margin: MarginPadding.MARGIN_SYMMETRIC_40_10,
            onClick: () {
              //Hiding KeyBoard If Visible.
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              //Remove The Dialog and Screen Exception Screen.
              if (popTimes == 1) {
                Navigator.of(context).pop();
              } else {
                for (int i = 0; i < popTimes; i++) {
                  Navigator.of(context).pop();
                }
              }
              // Navigator.of(context).pop();
            },
            btnTxt: 'OK',
            backColor: MyColors.primaryColor,
            textColor: MyColors.white,
          )
        ],
      ),
    );
  }
}
