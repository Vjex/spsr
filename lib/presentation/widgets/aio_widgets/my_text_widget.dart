import 'package:flutter/material.dart';

import '/utils/margin_padding.dart';
import '/utils/styles.dart';
import '/utils/colors.dart';

class MyTextWidget extends StatelessWidget {
  final EdgeInsetsGeometry marginContainer;
  final Decoration decorationContainer;
  final TextStyle styleTextField;
  final TextStyle styleTitleField;
  final String text;
  final String title;
  final Function? onTapTextWidget;
  final int calledBy;

  MyTextWidget({
    this.marginContainer = const EdgeInsets.only(
      top: 5,
    ),
    decorationContainer,
    styleTextField,
    styleTitleField,
    required this.text,
    this.title = '',
    this.onTapTextWidget,
    required this.calledBy,
  })  : this.styleTitleField = MyStyles.STYLE_col_greyDark_size_16,
        this.styleTextField = TextStyle(
            color: MyColors.black, fontSize: 14, fontWeight: FontWeight.bold),
        this.decorationContainer = BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapTextWidget == null
          ? () {}
          : () {
              onTapTextWidget!(calledBy);
            },
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: MarginPadding.MARGIN_SYMMETRIC_15,
              child: Text(
                title,
                style: styleTitleField,
              ),
            ),
            Container(
              width: double.infinity,
              margin: marginContainer,
              padding: MarginPadding.PADDING_SYMMETRIC_15_15,
              decoration: decorationContainer,
              child: Text(
                text,
                style: styleTextField,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
