import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tkconnect/components/custom_surfix_icon.dart';
import 'package:tkconnect/components/default_button.dart';
import 'package:tkconnect/helper/keyboard.dart';
import 'package:tkconnect/screens/login_success/login_success_screen.dart';
import 'package:tkconnect/utils/constants.dart';
import 'package:tkconnect/utils/size_config.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = "/complete_profile";

  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  var firstname = TextEditingController();
  var lastname = TextEditingController();

  //var phoneNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? otpPhoneNumber;
  var arguments;

  bool otpRequest = false;

  ///---------------------------------------------------------------OTP CODE----------------------

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String smscode = "";

  _signInWithMobileNumber() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: otpPhoneNumber?.trim(),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              Navigator.pushNamed(context, LoginSuccessScreen.routeName,
                  arguments: {
                    //'otpPhoneNumber': otpPhoneNumber,
                    'firstname': firstname.text,
                    'lastname': lastname.text,
                    'contact': otpPhoneNumber,
                    'accounttype': arguments['accounttype'],
                    'county': arguments['county'],
                    'subcounty': arguments['subcounty'],
                    'gender': arguments['gender'],
                    'term': false,
                    'appBarTitle': 'Terms and Conditions',
                    'welcomeTitle': 'Get Started',
                  });
            });
          },
          verificationFailed: ((error) {
            print(error);
          }),
          codeSent: (String verificationId, [int? forceResendingToken]) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                      title: Text("Enter OTP Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: getProportionateScreenWidth(35),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.box,
                            onChanged: (val) {},
                            onCompleted: (code) {
                              setState(() {
                                smscode = code;
                              });
                            },
                          ),
                        ],
                      ),
                      actions: [
                        DefaultButton(
                          text: "Send",
                          press: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            PhoneAuthCredential _credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smscode);
                            auth
                                .signInWithCredential(_credential)
                                .then((result) {
                              Navigator.pop(context);

                              Navigator.pushNamed(
                                  context, LoginSuccessScreen.routeName,
                                  arguments: {
                                    //'otpPhoneNumber': otpPhoneNumber,
                                    'firstname': firstname.text,
                                    'lastname': lastname.text,
                                    'contact': otpPhoneNumber,
                                    'accounttype': arguments['accounttype'],
                                    'county': arguments['county'],
                                    'subcounty': arguments['subcounty'],
                                    'gender': arguments['gender'],
                                    'term': false,
                                    'appBarTitle': 'Terms and Conditions',
                                    'welcomeTitle': 'Get Started',
                                  });
                                                        }).catchError((e) {
                              print(e);
                            });
                          },
                        ),
                      ],
                    ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            verificationId = verificationId;
          },
          timeout: Duration(seconds: 60));
    } catch (e) {}
  }

  ///---------------------------------------------------------------END OTP CODE------------------
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Text("Complete Profile", style: headingStyle),
                  const Text(
                    "Complete your details or continue  \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  //CompleteProfileForm(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: firstname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your first name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "First Name",
                            hintText: "Enter your first name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/User.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
                          controller: lastname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your last name";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Last Name",
                            hintText: "Enter your last name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/User.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        TextFormField(
                          //controller: phoneNo,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          onChanged: (value) {
                            otpPhoneNumber = value.isEmpty
                                ? null
                                : '+254${value.substring(1)}';

                            if (value.isNotEmpty) {
                              removeError(error: kPhoneNumberNullError);
                            } else if (value.length < 10) {
                              removeError(error: kInvalidPhoneError);
                            }
                            return;
                          },
                          validator: (value) {
                            //print(value?.substring(1));
                            //print(value?.substring(0,1));

                            if (value!.isEmpty) {
                              addError(error: kPhoneNumberNullError);
                              return "format 07xxxxxxxx";
                            } else if (value.length < 10) {
                              removeError(error: kInvalidPhoneError);
                              return "The phone number is too short";
                            } else if (value.substring(0, 1) != '0') {
                              removeError(error: kInvalidPhoneError);
                              return "Invalid Phone Number";
                            }
                            return null;

                            //return otpPhoneNumber;
                          },
                          decoration: const InputDecoration(
                            labelText: "Phone Name",
                            hintText: "Enter your phone number",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSurffixIcon(
                                svgIcon: "assets/icons/Phone.svg"),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        otpRequest == false
                            ? DefaultButton(
                                text: "continue",
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    KeyboardUtil.hideKeyboard(context);
                                    _signInWithMobileNumber();
                                    setState(() {
                                      otpRequest = true;
                                    });

                                    Future.delayed(const Duration(seconds: 60),
                                        () {
                                      //asynchronous delay
                                      if (mounted) {
                                        //checks if widget is still active and not disposed
                                        setState(() {
                                          //tells the widget builder to rebuild again because ui has updated
                                          otpRequest =
                                              false; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                                        });
                                      }
                                    });

                                    //print(otpPhoneNumber);
                                  }
                                },
                              )
                            : Column(
                                children: [
                                  const Text('Sending OTP...'),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Center(
                                        child: LinearProgressIndicator(
                                      backgroundColor: Color(0xFFB4B4B4),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    )),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
