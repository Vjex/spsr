import 'package:flutter/material.dart';

import '/utils/colors.dart';

class MyPasswordTextField extends StatefulWidget {
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

  MyPasswordTextField({
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
  _MyPasswordTextFieldState createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    this.setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('Called Rebuild ' + _obscureText.toString());
    return Container(
      margin: widget.marginContainer,
      decoration: widget.decorationContainer,
      child: TextField(
        obscureText: _obscureText,
        onSubmitted: (v) {
          if (widget.focusNodeToRequest != null) {
            widget.focusNodeToRequest!.requestFocus();
          }

          //Function to execute after on submit
          if (widget.onSubmitTextField != null) {
            widget.onSubmitTextField!();
          }
        },
        textInputAction: widget.focusAction,
        focusNode: widget.focusNode != null ? widget.focusNode : null,
        autofocus: widget.autofocus,
        maxLength: widget.maxLength != null ? widget.maxLength : null,
        maxLines: 1,
        style: widget.styleTextField,
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          errorText: widget.errorText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: widget.labelTextTextField,
          labelStyle: widget.labelTextStyle,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordStatus,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
