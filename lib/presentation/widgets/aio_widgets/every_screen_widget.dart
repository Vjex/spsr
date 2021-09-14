import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spsr/presentation/widgets/aio_widgets/my_button.dart';
import 'package:spsr/presentation/widgets/aio_widgets/successfull_dialog.dart';
import 'package:spsr/presentation/widgets/aio_widgets/unsuccessfull_dialog.dart';
import 'package:spsr/utils/colors.dart';
import 'package:spsr/utils/margin_padding.dart';
import 'package:spsr/utils/styles.dart';

void showSuccessFullUnsuccessFullDialog(
    BuildContext context, bool isSuccessFull, String msg) {
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

//Show Dialog Method
void loadingDialog(BuildContext context) {
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

//Method to Show Enable Location Dialog.
void showDetailDialogLocation(BuildContext context, String msg) {
  Size screenSize = MediaQuery.of(context).size;
  //Show Dialog method To Show Any Dialog.
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: screenSize.width * 0.3,
                      height: screenSize.width * 0.3,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Icon(
                          Icons.sentiment_dissatisfied,
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
                        style: MyStyles.STYLE_col_black_size_16_bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            width: 100,
                            margin: MarginPadding.MARGIN_ONLY_Right_10,
                            onClick: () {
                              //Hiding KeyBoard If Visible.
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              Navigator.of(context).pop();
                            },
                            btnTxt: 'Cancel',
                            backColor: MyColors.primaryColor,
                            textColor: MyColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MyButton(
                            width: 100,
                            margin: MarginPadding.MARGIN_ONLY_Right_10,
                            onClick: () {
                              //Hiding KeyBoard If Visible.
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.of(context).pop();
                              //Opening Loccation Settings
                              Geolocator.openLocationSettings();
                            },
                            btnTxt: 'OK',
                            backColor: MyColors.primaryColor,
                            textColor: MyColors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showSnackBar(BuildContext context, String text,
    {int sec = 2, Color backColor = Colors.black}) async {
  var snackbar = SnackBar(
    backgroundColor: backColor,
    content: Text(text),
    duration: Duration(seconds: sec),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
