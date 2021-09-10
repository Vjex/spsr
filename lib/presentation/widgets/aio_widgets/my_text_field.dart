import 'package:flutter/material.dart';

import '/utils/colors.dart';

class MyTextField extends StatelessWidget {
  final EdgeInsetsGeometry marginContainer;
  final bool isObscured;
  final Decoration decorationContainer;
  final Function? onSubmitTextField;
  final int? maxLength;
  final int maxLines;
  final bool autofocus;
  final FocusNode? focusNode;
  final FocusNode? focusNodeToRequest;
  final TextEditingController textEditingController;
  final TextStyle styleTextField;
  final TextInputAction focusAction;
  final TextInputType keyboardType;
  final String labelTextTextField;
  final TextStyle labelTextStyle;

  final String? errorText;

  MyTextField({
    this.marginContainer = const EdgeInsets.only(
      top: 20,
    ),
    this.isObscured = false,
    decorationContainer,
    this.onSubmitTextField,
    this.maxLength,
    this.maxLines = 1,
    this.autofocus = false,
    this.focusNode,
    this.focusAction = TextInputAction.none,
    this.focusNodeToRequest,
    required this.textEditingController,
    styleTextField,
    this.keyboardType = TextInputType.text,
    required this.labelTextTextField,
    labelTextStyle,
    required this.errorText,
  })  : this.decorationContainer = BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        this.styleTextField = TextStyle(
          color: MyColors.black,
        ),
        this.labelTextStyle = TextStyle(
          color: MyColors.grey,
        );

  @override
  Widget build(BuildContext context) {
    // print('Called Rebuild ' + _obscureText.toString());
    return Container(
      margin: marginContainer,
      decoration: decorationContainer,
      child: TextField(
        onSubmitted: (v) {
          if (focusNodeToRequest != null) {
            focusNodeToRequest!.requestFocus();
          }

          //Function to execute after on submit
          if (onSubmitTextField != null) {
            onSubmitTextField!();
          }
        },
        textInputAction: focusAction,
        focusNode: focusNode != null ? focusNode : null,
        autofocus: autofocus,
        maxLength: maxLength != null ? maxLength : null,
        maxLines: 1,
        style: styleTextField,
        controller: textEditingController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelTextTextField,
          labelStyle: labelTextStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
