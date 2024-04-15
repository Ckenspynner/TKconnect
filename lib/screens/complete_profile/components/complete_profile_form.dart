import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tkconnect/firebase_repository/controller/signup_controller.dart';
import 'package:tkconnect/screens/otp_home/otp.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../utils/size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.firstname,
            validator: (value) {
              if (value!.isEmpty) {
                return "Must be filled";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            controller: controller.lastname,
            validator: (value) {
              if (value!.isEmpty) {
                return "Must be filled";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your last name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            controller: controller.phoneNo,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            validator: (value) {
              if (value!.isEmpty) {
                return "Must be filled";
              } else if (value.length != 13) {
                if (value.length != 13) {
                  return "Use this format +2547xxxxxxxx";
                }
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Phone Name",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(
                  context,
                  OTP.routeName,
                  arguments: {
                    'otpPhoneNumber': controller.phoneNo.text,
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
