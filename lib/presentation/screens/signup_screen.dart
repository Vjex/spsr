import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spsr/presentation/router/routes.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_button.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_password_texfield.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_text_field.dart';
import 'package:spsr/presentation/widgets/aio_widgets/successfull_dialog.dart';
import 'package:spsr/presentation/widgets/aio_widgets/unsuccessfull_dialog.dart';
import 'package:spsr/utils/colors.dart';
import 'package:spsr/utils/margin_padding.dart';
import 'package:spsr/utils/strings.dart';
import 'package:spsr/utils/styles.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Scafoold Global key for this screen
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

//Controller for text Fields in the Screen.
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  //Error and labelString for Both these textFields.
  String _nameLanel = 'SP Name';
  String _passwordlabel = 'Password';
  String _passwordConfirmlabel = 'Confirm Password';
  String _mobilelabel = 'Mobile';
  String _emailLabel = 'Email';

  //Error String Corressponding to each controller
  String _nameError = '';
  String _passwordError = '';
  String _passwordConfirmError = '';
  String _mobileError = '';
  String _emailError = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
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
            child: _getCopleteSignUpScreenBody(),
          ),
        ),
      ),
    );
  }

  //Method to get the Complete Screen For Sign Up A Employee.
  Widget _getCopleteSignUpScreenBody() {
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
              'Sign UP - Only SP',
              style: MyStyles.STYLE_col_black_size_26_bold,
            ),
          ),
        ),

        MyTextField(
          autofocus: false,
          textEditingController: _nameController,
          labelTextTextField: _nameLanel,
          errorText: _nameError,
          maxLines: 1,
          maxLength: 30,
        ),
        //TextField
        MyTextField(
          autofocus: false,
          textEditingController: _mobileController,
          labelTextTextField: _mobilelabel,
          errorText: _mobileError,
          maxLines: 1,
          maxLength: 10,
        ),
        //TextField
        MyTextField(
          autofocus: false,
          textEditingController: _emailController,
          labelTextTextField: _emailLabel,
          errorText: _emailError,
          maxLines: 1,
          maxLength: 70,
        ),

        //TextField
        MyPasswordTextField(
          textEditingController: _passwordController,
          labelTextTextField: _passwordlabel,
          errorText: _passwordError,
          maxLines: 1,
          maxLength: 20,
        ),

        //TextField

        MyPasswordTextField(
          textEditingController: _passwordConfirmController,
          labelTextTextField: _passwordConfirmlabel,
          errorText: _passwordConfirmError,
          maxLines: 1,
          maxLength: 20,
        ),

        SizedBox(
          height: 20,
        ),

        SizedBox(
          height: 10,
        ),

        MyButton(
          onClick: _onRegisterClicKed,
          btnTxt: 'REGISTER',
          backColor: MyColors.greenColor,
          btnTextStyle: TextStyle(
            color: MyColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        MyButton(
          onClick: _onLoginClicked,
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
      _nameError = '';
      _passwordError = '';
      _passwordConfirmError = '';
      _mobileError = '';
      _emailError = '';
      //Validating the Employee Id and Password Field.
      String employeeIdString = _nameController.text.trim();
      String passwordString = _passwordController.text.trim();
      String confirmPasswordString = _passwordConfirmController.text.trim();
      String securityQuesString = _mobileController.text.trim();
      String securityAnsString = _emailController.text.trim();

      //validating Employee Id
      if (employeeIdString == null || employeeIdString.length < 9) {
        setState(() {
          _nameError = 'Invalid ID';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      //validating Employee password
      if (passwordString == null || passwordString.length < 6) {
        setState(() {
          _passwordError = 'Min Length 6';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      //Validating password for diffreent characters.
      if (passwordString.contains('%')) {
        // print('Found');
        setState(() {
          _passwordError = '% is not allowed!';
        });
        // Navigator.pop(context); //pop dialog
        return;
      }

      //Validating password for diffreent characters.
      if (passwordString.contains('\$')) {
        // print('Found');
        setState(() {
          _passwordError = '\$ is not allowed!';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      if (confirmPasswordString != passwordString) {
        setState(() {
          _passwordConfirmError = 'Password not matched.';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      //Validating Security Question
      if (securityQuesString == null || securityQuesString.length < 1) {
        setState(() {
          _mobileError = 'Field required';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      //Validating Security Answer
      if (securityAnsString == null || securityAnsString.length < 1) {
        setState(() {
          _emailError = 'Answer required';
        });
        // Navigator.pop(context); //pop dialog

        return;
      }

      //Validaing quest answer should not match
      if (securityQuesString == securityAnsString) {
        setState(() {
          _emailError = 'Question and anser cant be same.';
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
  void _onLoginClicked() {
    //navigate to signUp Screen Here

    //going to LogIn Screen
    Navigator.of(context).pop();
  }
}
