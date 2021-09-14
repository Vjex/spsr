import 'package:flutter/material.dart';

import 'package:spsr/presentation/widgets/aio_widgets/my_button.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_password_texfield.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_text_field.dart';
import 'package:spsr/presentation/widgets/aio_widgets/successfull_dialog.dart';
import 'package:spsr/presentation/widgets/aio_widgets/unsuccessfull_dialog.dart';
import 'package:spsr/utils/colors.dart';
import 'package:spsr/utils/margin_padding.dart';
import 'package:spsr/utils/styles.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  //Scafoold Global key for this screen
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Controller for text Fields in the Screen.
  TextEditingController _emailPhoneController = TextEditingController();

  //Error and labelString for Both these textFields.
  String _phoneEmailLabel = 'Phone/email';

  //Error String Corressponding to each controller
  String _phoneEmailError = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: MyColors.white,
          child: Container(
            padding: MarginPadding.PADDING_SYMMETRIC_20,
            width: MediaQuery.of(context).size.width,
            child: _getCopleteForgetPWDBody(),
          ),
        ),
      ),
    );
  }

  //Method to get the Complete Screen For Sign Up A Employee.
  Widget _getCopleteForgetPWDBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),

        //Ems Logo
        Container(
          child: Center(
            child: Image(
              image: AssetImage('assets/images/icon.png'),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //Text
        Container(
          child: Center(
            child: Text(
              'Password Recovery',
              style: MyStyles.STYLE_col_black_size_26_bold,
            ),
          ),
        ),

        MyTextField(
          autofocus: false,
          textEditingController: _emailPhoneController,
          labelTextTextField: _phoneEmailLabel,
          errorText: _phoneEmailError,
          maxLines: 1,
          maxLength: 30,
        ),

        SizedBox(
          height: 20,
        ),

        SizedBox(
          height: 10,
        ),

        MyButton(
          onClick: _onRegisterClicKed,
          btnTxt: 'Find',
          backColor: MyColors.greenColor,
          btnTextStyle: TextStyle(
            color: MyColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        MyButton(
          onClick: _onCancel,
          btnTxt: 'CANCEL',
          backColor: MyColors.accentColor,
          btnTextStyle: TextStyle(
            color: MyColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Show Dialog Method
  void _loadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: MarginPadding.PADDING_SYMMETRIC_15_15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text("Please wait.."),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void _onRegisterClicKed() {
    // print('Register Clicked');

    // //Show Dialog
    // _loadingDialog();

    //Setting error Back to null;
    setState(() {
      _phoneEmailError = '';

      //Validating the Employee Id and Password Field.
      String idString = _emailPhoneController.text.trim();

      //validating Employee Id
      if (idString.isEmpty || idString.length < 3) {
        setState(() {
          _phoneEmailError = 'Invalid ID';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }
    });
  }

  //Method to Show SuccessUnSuccessFull Dialog.
  void _showSuccessFullUnsuccessFullDialog(bool isSuccessFull, String msg) {
    //Show Dialog method To Show Any Dialog.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: isSuccessFull
              ? SuccessFullDialogWidget(
                  msg: msg,
                  popTimes: 2,
                )
              : UnsuccessFullDialogWidget(msg: msg),
        );
      },
    );
  }

  //Method to be called on Sign In Button Click.
  void _onCancel() {
    //navigate to signUp Screen Here

    //going to LogIn Screen
    Navigator.of(context).pop();
  }
}
