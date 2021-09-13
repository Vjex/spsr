import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spsr/logic/cubit/auth_cubit.dart';

import '../widgets/aio_widgets/my_button.dart';
import '../widgets/aio_widgets/my_password_texfield.dart';
import '../widgets/aio_widgets/my_text_field.dart';
// import 'package:trust_fall/trust_fall.dart';
import 'package:spsr/services/string_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/user.dart';
import '../../utils/colors.dart';
import '../../utils/margin_padding.dart';
import '../router/routes.dart';
import '../../utils/styles.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controller for text Fields in the Screen.
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _idError;
  //Error and labelString for Both these textFields.
  late String _idlabel;

  // new Dio with a BaseOptions instance.

  //Error Strings for this screen.
  String? _passwordError;
  late String _passwordlabel;

  //Radio selectio for Login Type
  int _radioSelected = 1;
  String _radioVal = 'sp';

  //Scafoold Global key for this screen
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //Initalising text field labels.
    _idlabel = 'Phone or Email';
    _passwordlabel = 'Password';

    //Checking Deivce Is Trusted or safe if Not Then Auto Close the Application.
    // _checkDeviceSafe();

    User.getEmpAndPwdForLogin().then((data) {
      String empId =
          data['empIdLogin'] != null && data['empIdLogin']!.isNotEmpty
              ? data['empIdLogin'] as String
              : '';
      String pwd = data['pwdLogin'] != null && data['pwdLogin']!.isNotEmpty
          ? data['pwdLogin'] as String
          : '';

      // Auto Providing Emp and password If Saved.
      if (empId.isNotEmpty) {
        _idController.text = empId.toUpperCase();
      }
      if (pwd.isNotEmpty) {
        _passwordController.text = pwd;
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          _loadingDialog();
        } else if (state is AuthLoginSPSuccess) {
          //Remove The Loading Dialog
          Navigator.of(context).pop();
          //Now Navigate to SP Home Screen
          Navigator.of(context).pushReplacementNamed(MyRoutes.HOME_SP_ROUTE);
        } else if (state is AuthLoginSRSuccess) {
          Navigator.of(context).pop();
          //Now Navigate to SR Home Screen
          Navigator.of(context).pushReplacementNamed(MyRoutes.HOME_SR_ROUTE);
        } else if (state is AuthFailure) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: MyColors.white,
            child: Container(
              padding: MarginPadding.PADDING_SYMMETRIC_20,
              margin: MarginPadding.MARGIN_ONLY_Top_20,
              width: MediaQuery.of(context).size.width,
              child: _getCompleteLoginScreen(),
            ),
          ),
        ),
      ),
    );
  }

  //Method for Complete Screen Body of LOgin Page.
  Widget _getCompleteLoginScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        //Ems Logo
        Container(
          margin: MarginPadding.MARGIN_ONLY_Left_40,
          child: Center(
            child: Image(
              image: AssetImage('assets/images/icon.png'),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),

        //Text
        Container(
          child: Center(
            child: Text(
              'SPSR Login',
              style: MyStyles.STYLE_col_black_size_26_bold,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SP'),
            Radio(
              value: 1,
              groupValue: _radioSelected,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                  _radioVal = 'sp';
                });
              },
            ),
            Text('SR'),
            Radio(
              value: 2,
              groupValue: _radioSelected,
              activeColor: Colors.pink,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                  _radioVal = 'sr';
                });
              },
            )
          ],
        ),

        //TextField
        MyTextField(
          autofocus: false,
          textEditingController: _idController,
          labelTextTextField: _idlabel,
          errorText: _idError,
          maxLines: 1,
          maxLength: 60,
        ),

        //TextField
        MyPasswordTextField(
          textEditingController: _passwordController,
          labelTextTextField: _passwordlabel,
          errorText: _passwordError,
          maxLines: 1,
          maxLength: null,
        ),

        SizedBox(
          height: 50,
        ),

        //Login Button
        MyButton(
          onClick: _onSignInClicled,
          btnTxt: 'Login',
          backColor: MyColors.greenColor,
          btnTextStyle: TextStyle(
            color: MyColors.white,
            fontSize: 16,
          ),
        ),

        //Sign Up Button
        MyButton(
          onClick: _onSignUpClicled,
          btnTxt: 'Sign Up',
          backColor: MyColors.accentColor,
          btnTextStyle: TextStyle(
            color: MyColors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 20,
        ),

        //Forget Password text Button
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Material(
              child: InkWell(
                child: Text(
                  'Forget Password ?',
                  style: MyStyles.STYLE_col_primary_size_16_bold,
                ),
                onTap: () {
                  //Navigate to Forget password Screen
                  Navigator.of(context).pushReplacementNamed(
                    MyRoutes.FORGET_PASSWORD_ROUTE,
                  );
                },
              ),
              color: Colors.transparent,
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // //Method To Check Whether The Device IS Rooted or trusted
  // void _checkDeviceSafe() async {
  //   try {
  //     bool isJailBroken = await TrustFall.isJailBroken;
  //     bool isRealDevice = await TrustFall.isRealDevice;
  //     // bool isTrustFall3 = await TrustFall.isOnExternalStorage;

  //     //IF Device is Not Trusted Then Auto Close The Application.
  //     if (isJailBroken || !isRealDevice) {
  //       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //     }
  //   } catch (e) {
  //     print('Errorrerrrrr $e');
  //   }
  // }

  //Login Employee Call Get API.
  // void _loginEmployee(Dio dio, var employeeId, var password) async {
  //   //Map the required json Data to send in the Body of the Post request.
  //   var map = new Map<String, dynamic>();
  //   map['LoginId'] = employeeId;
  //   map['refrance'] = password;
  //   map['appkey'] = 'ces';

  //   print(map.toString());

  //   //Special Bool to  Show Adhaar Verification
  //   bool _isAdhaarVerWarnoingDialogToShow = false;
  //   String msgDialogAdhaarVer = 'Please verify your adhaar.';
  //   String currTimegAdhaar;

  //   try {
  //     Response response = await _dio.post('/GetLogin.php', data: map);

  //     //Show message to
  //     // Future.delayed(duration)

  //     if (response.statusCode == 200) {
  //       var decodeObject = jsonDecode(response.toString());

  //       // print(decodeObject);

  //       int responseStatus = decodeObject['status'] as int;
  //       /////////////////////////////Filtering All the Employee Details to Save in Shared Prefrences //////////////////////////
  //       var employeeDetailsObject = decodeObject['employ_details'];
  //     } else {
  //       final snackBar = SnackBar(
  //           content: Text('OOPS,Server can not be reached. Please try again.'));

  //       // Find the Scaffold in the widget tree and use it to show a SnackBar.
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //       Navigator.pop(context); //pop dialog
  //     }
  //   } catch (e) {
  //     Navigator.pop(context); //pop dialog
  //     final snackBar = SnackBar(
  //         content: Text('OOPS,Server can not be reached. Please try again.'));

  //     // Find the Scaffold in the widget tree and use it to show a SnackBar.
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //     print(e);
  //   }
  // }

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

  ///Method to Show Messg of Server Error! When Response

  //Method to be called on Sign In Button Click.
  void _onSignInClicled() {
    // _loadingDialog();

    //Setting error Back to null;
    _idError = '';
    _passwordError = '';

    setState(() {});

    //Validating the Employee Id and Password Field.
    String idString = _idController.text.trim();
    String passwordString = _passwordController.text.trim();

    //validating Employee Id
    if (idString.isEmpty || idString.length < 3) {
      setState(() {
        _idError = 'Invalid ID';
      });

      return;
    }

    //Vlidating Email/Phone
    if (idString.contains('@')) {
      //ValidateEmail
      if (!idString.isValidEmail()) {
        setState(() {
          _idError = 'Invalid Email-ID.';
        });
        return;
      }
    } else {
      //Validating Phone
      if (!idString.isNumeric() ||
          idString.length < 10 ||
          idString.length > 10) {
        setState(() {
          _idError = 'Invalid mobile.';
        });
        return;
      }
    }

    //Validating Password
    if (passwordString.isEmpty) {
      _passwordError = 'required.';

      return;
    }

    //Now Call The Login Method depending upon login type.
    if (_radioVal == 'sp') {
      BlocProvider.of<AuthCubit>(context).loginSpUser(idString, passwordString);
    } else {
      BlocProvider.of<AuthCubit>(context).loginSrUser(idString, passwordString);
    }

    //Now Login The User
    // _loginEmployee(_dio, employeeIdString, passwordString);
  }

  //Method to be called on Sign In Button Click.

  void _onSignUpClicled() {
    //going to SignUp Screen
    Navigator.of(context).pushNamed(MyRoutes.SIGNUP_REGISTER);
  }
}
