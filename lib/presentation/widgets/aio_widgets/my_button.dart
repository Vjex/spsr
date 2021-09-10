import 'package:flutter/material.dart';

import '/utils/margin_padding.dart';
import '/utils/colors.dart';

class MyButton extends StatefulWidget {
  final Function onClick;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double borderRadiusValue;
  final String btnTxt;
  final Color backColor;
  final Color textColor;
  final TextStyle? btnTextStyle;

  MyButton({
    required this.onClick,
    this.height = 50,
    this.width = double.infinity,
    this.margin = MarginPadding.MARGIN_SYMMETRIC_55_10,
    this.padding = MarginPadding.PADDING_ALL_0,
    this.elevation = 10,
    this.borderRadiusValue = 10.0,
    required this.btnTxt,
    this.backColor = MyColors.white,
    this.textColor = MyColors.accentColor,
    this.btnTextStyle,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(widget.borderRadiusValue),
        boxShadow: [
          BoxShadow(
            color: MyColors.grey,
            offset: Offset(1.0, 5.0),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: widget.backColor,
          //  disabledColor: MyColors.greyLight,
          // disabledTextColor: MyColors.primaryColor,
          elevation: widget.elevation,
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadiusValue),
            // side: BorderSide(color: MyColors.accentColor)
          ),
        ),
        onPressed: () {
          widget.onClick();
        },
        child: FittedBox(
          child: Text(
            widget.btnTxt,
            style:
                widget.btnTextStyle != null ? widget.btnTextStyle : TextStyle(),
          ),
        ),
      ),
    );
  }
}
