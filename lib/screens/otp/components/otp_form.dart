import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tkconnect/firebase_repository/controller/otp_controller.dart';
import '../../../components/default_button.dart';
import '../../../utils/size_config.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {

  String otp = '';
  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: getProportionateScreenWidth(45),
            style: TextStyle(
              fontSize: 17,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onChanged: (val) {},
            onCompleted: (code) {
              otp = code;
              OTPController.instance.verifyOTP(otp);
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              //if (otp !='') {
                OTPController.instance.verifyOTP(otp);
                //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              // }else{
              //   final snackBar = SnackBar(
              //     backgroundColor: Colors.green,
              //     content: const Text('No OTP Code found.'),
              //     action: SnackBarAction(
              //       textColor: Colors.white,
              //       label: 'Undo',
              //       onPressed: () {
              //         // Some code to undo the change.
              //       },
              //     ),
              //   );
              //
              //   // Find the ScaffoldMessenger in the widget tree
              //   // and use it to show a SnackBar.
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // }
            },
          )
        ],
      ),
    );
  }
}
