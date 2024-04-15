import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkconnect/utils/http_strings.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../login_success/login_success_screen.dart';
import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password, otpPhoneNumber,selectedValueFilter;
  bool? remember = false;
  bool otpRequest = false;
  String selectedValue2 = "Select Your County";
  final List<String?> errors = [];

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your County", child: Text("Select Your County")),
      const DropdownMenuItem(
          value: "Taita Taveta", child: Text("Taita Taveta")),
      const DropdownMenuItem(value: "Tana River", child: Text("Tana River")),
      const DropdownMenuItem(value: "Mombasa", child: Text("Mombasa")),
      const DropdownMenuItem(value: "Kwale", child: Text("Kwale")),
      const DropdownMenuItem(value: "Kilifi", child: Text("Kilifi")),
      const DropdownMenuItem(value: "Lamu", child: Text("Lamu")),
    ];
    return menuItems;
  }

  ///---------------------------------------------------------------OTP CODE----------------------

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String smscode = "";

  _signInWithMobileNumber() async {
    UserCredential _credential;
    User user;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: otpPhoneNumber,
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            await _auth.signInWithCredential(authCredential).then((value) {
              loggedAcountNumber(selectedValue2);

              Navigator.pushNamed(context, LoginSuccessScreen.routeName,
                  arguments: {
                    'contact': otpPhoneNumber,
                    'county': selectedValueFilter,
                    'term': true,
                    'appBarTitle': 'Login Successful',
                    'welcomeTitle': 'Login Success',
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
                              if (result != null) {
                                Navigator.pop(context);
                                loggedAcountNumber(selectedValue2);

                                Navigator.pushNamed(
                                    context, LoginSuccessScreen.routeName,
                                    arguments: {
                                      'contact': otpPhoneNumber,
                                      'county': selectedValueFilter,
                                      'term': true,
                                      'appBarTitle': 'Login Successful',
                                      'welcomeTitle': 'Login Success',
                                    });
                              }
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

  Future<void> loggedAcountNumber(county) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('loggedAccNumber', otpPhoneNumber!);
    pref.setString('loggedAccCounty', county);
  }

  verifycontact(contact, county) async {
    if (county == 'Guest Account') {
      if(contact == "+254780091858") {
        Navigator.pushNamed(context, LoginSuccessScreen.routeName, arguments: {
          'contact': otpPhoneNumber,
          'county': selectedValueFilter,
          'term': true,
          'appBarTitle': 'Login Successful',
          'welcomeTitle': 'Login Success',
        });
      }else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: const Text('Invalid Guest Account Credentials'),
          action: SnackBarAction(
            textColor: Colors.white,
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //Navigator.pop(context);
      }
    } else {
      var path; //,county ='Lamu',contact ='+254702407935';

      if (county == 'Mombasa') {
        //works
        path = mombasaUserListUrl;
      }
      if (county == 'Lamu') {
        //works
        path = lamuUserListUrl;
      }
      if (county == 'Kwale') {
        //works
        path = kwaleUserListUrl;
      }
      if (county == 'Kilifi') {
        //works
        path = kilifiUserListUrl;
      }
      if (county == 'Tana River') {
        //works
        path = tanariverUserListUrl;
      }
      if (county == 'Taita Taveta') {
        //works
        path = taitatavetaUserListUrl;
      }

      var response = await http.get(Uri.parse(path));
      //print(jsonDecode(response.body));
      var verify = jsonDecode(response.body);
      verify.forEach((element) {
        if (element["contact"].contains(contact)) {
          //there is element
          _signInWithMobileNumber();
          //userprint();
          // setState(() {
          //   otpRequest = true;
          // });
          //loggedAcountNumber(county);
        }

        // else{

        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            validator: (value) =>
                value == "Select Your County" ? "Must be selected" : null,
            //dropdownColor: Colors.blueAccent,
            value: selectedValue2,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue2 = newValue!;
              });
            },
            items: dropdownItems2,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          otpRequest == false
              ? DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      if(otpPhoneNumber == '+254780091858' && selectedValue2 == 'Mombasa'){
                        selectedValueFilter = 'Guest Account';}
                      else{selectedValueFilter = selectedValue2;}

                      verifycontact(otpPhoneNumber, selectedValueFilter);

                      if(otpPhoneNumber == '+254780091858' || selectedValueFilter != 'Guest Account') {
                        setState(() {
                          otpRequest = true;
                        });
                        Future.delayed(const Duration(seconds: 60), () {
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
                      }
                      //print(otpPhoneNumber);
                    }
                  },
                )
              : Column(
                  children: [
                    Text(selectedValue2 == 'Guest Account'
                        ? 'Please wait...'
                        : 'Sending OTP...'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Center(
                          child: LinearProgressIndicator(
                        backgroundColor: Color(0xFFB4B4B4),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => email = newValue,
      maxLength: 10,
      onChanged: (value) {
        otpPhoneNumber = value.isEmpty ? null : '+254${value.substring(1)}';

        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (value.length < 10) {
          removeError(error: kInvalidPhoneError);
        }
        return null;
      },
      validator: (value) {
        //print(value?.substring(1));
        //print(value?.substring(0,1));

        if (value!.isEmpty) {
          //addError(error: kPhoneNumberNullError);
          return "Must be filled";
        } else if (value!.length < 10) {
          removeError(error: kInvalidPhoneError);
          return "The phone number is too short";
        } else if (value?.substring(0, 1) != '0') {
          removeError(error: kInvalidPhoneError);
          return "Invalid Phone Number";
        }
        return null;

        //return otpPhoneNumber;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone OTP.svg"),
      ),
    );
  }
}
