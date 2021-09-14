import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spsr/logic/cubit/auth_cubit.dart';
import 'package:spsr/presentation/widgets/aio_widgets/every_screen_widget.dart';

import 'package:spsr/presentation/widgets/aio_widgets/my_button.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_password_texfield.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_text_field.dart';
import 'package:spsr/utils/colors.dart';
import 'package:spsr/services/string_extensions.dart';
import 'package:spsr/utils/margin_padding.dart';
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

  ///Postion Var For Current Emp Position.
  Position? _position;
  List<Address>? _addrressListCurrent;

  @override
  void initState() {
    //Get Current Location
    _getUserLocation();
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          loadingDialog(context);
        } else if (state is AuthSignUpSPSuccess) {
          //Remove The Loading Dialog
          Navigator.of(context).pop();
          //Now Navigate to SP Home Screen
          // Navigator.of(context).pushReplacementNamed(MyRoutes.HOME_SP_ROUTE);
        } else if (state is AuthLoginSRSuccess) {
          Navigator.of(context).pop();
          //Now Navigate to SR Home Screen
          // Navigator.of(context).pushReplacementNamed(MyRoutes.HOME_SR_ROUTE);
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
              width: MediaQuery.of(context).size.width,
              child: _getCopleteSignUpScreenBody(),
            ),
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
          keyboardType: TextInputType.name,
          errorText: _nameError,
          maxLines: 1,
          maxLength: 30,
        ),
        //TextField
        MyTextField(
          autofocus: false,
          textEditingController: _mobileController,
          keyboardType: TextInputType.phone,
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
          keyboardType: TextInputType.emailAddress,
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

  void _onRegisterClicKed() {
    //Setting error Back to null;
    setState(() {
      _nameError = '';
      _passwordError = '';
      _passwordConfirmError = '';
      _mobileError = '';
      _emailError = '';
    });
    //Validating the Employee Id and Password Field.
    String nameString = _nameController.text.trim();
    String passwordString = _passwordController.text.trim();
    String confirmPasswordString = _passwordConfirmController.text.trim();
    String mobileString = _mobileController.text.trim();
    String emailString = _emailController.text.trim();

    //validating Employee Id
    if (nameString.isEmpty || nameString.length < 3) {
      setState(() {
        _nameError = 'Invalid Name';
      });
      // Navigator.pop(context); //pop dialog

      return;
    }

    //Validating Security Question
    if (mobileString.isEmpty ||
        mobileString.length != 10 ||
        !mobileString.isNumeric()) {
      setState(() {
        _mobileError = 'Invalid Mobile';
      });
      // Navigator.pop(context); //pop dialog

      return;
    }

    //Validating Security Answer
    if (emailString.isEmpty || !emailString.isValidEmail()) {
      setState(() {
        _emailError = 'Invalid Email';
      });
      // Navigator.pop(context); //pop dialog

      return;
    }

    //validating Employee password
    if (passwordString.isEmpty || passwordString.length < 6) {
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

    //Now Validate Current Location and Address
    if (_position == null || _addrressListCurrent == null) {
      showSnackBar(context, 'Please wait your location not found', sec: 3);
      return;
    }
    Coordinates pos = Coordinates(_position?.latitude, _position?.longitude);
    Address add = _addrressListCurrent![0];

    //Now EveryThing is Ok Call SignUp in Auth Cubit
    BlocProvider.of<AuthCubit>(context).signupSpUser(
        nameString, emailString, mobileString, passwordString, pos, add);
  }

  //Method To Request For Location From User
  void _getUserLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        //Delay for Reading
        showDetailDialogLocation(
            context, 'GPS is not enable, Please enable it first!');
      }

      //Checking Location Permission
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // return;
      }

      //Checking If Denied Forever.
      if (permission == LocationPermission.deniedForever) {
        showDetailDialogLocation(context,
            'Location permission is denied. Please provide manually from settings.');

        // return;
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await Geolocator.getCurrentPosition().then((position) async {
          print(position.toString());
          _position = position;
          final coordinates =
              new Coordinates(position.latitude, position.longitude);
          _addrressListCurrent =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);

          setState(() {});
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString(), sec: 3);
    }
  }

  //Method to be called on Sign In Button Click.
  void _onLoginClicked() {
    //navigate to signUp Screen Here

    //going to LogIn Screen
    Navigator.of(context).pop();
  }
}
