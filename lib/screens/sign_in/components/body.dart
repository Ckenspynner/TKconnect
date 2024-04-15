import 'package:flutter/material.dart';
import 'package:tkconnect/components/appLogo.dart';
import '../../../components/no_account_text.dart';
import '../../../components/socal_card.dart';
import '../../../utils/size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppLogo(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Sign in with your phone number",
                      //  \nor continue with social media
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SocalCard(
                    //       icon: "assets/icons/google-icon.svg",
                    //       press: () {},
                    //     ),
                    //     SocalCard(
                    //       icon: "assets/icons/facebook-2.svg",
                    //       press: () {},
                    //     ),
                    //     SocalCard(
                    //       icon: "assets/icons/twitter.svg",
                    //       press: () {},
                    //     ),
                    //   ],
                    // ),
                    //SizedBox(height: getProportionateScreenHeight(20)),
                    const NoAccountText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
