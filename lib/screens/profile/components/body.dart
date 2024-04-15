import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkconnect/components/dev_name_text.dart';
import 'package:tkconnect/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String contact;
  final String accounttype;
  final String county;
  final String subcounty;
  final String gender;

  const Body(
      {super.key,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.contact,
      required this.accounttype,
      required this.county,
      required this.subcounty,
      required this.gender
      });

  Future<void> loggedAcountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedAccNumber');
    prefs.remove('loggedAccCounty');
  }

  @override
  Widget build(BuildContext context) {
    final baseHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(gender:gender),
          SizedBox(height: 20),
          ProfileMenu(
            text: '$firstname $lastname',
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: '$county - $subcounty',
            icon: "assets/icons/Location point.svg",
            press: () {},
          ),
          ProfileMenu(
            text: contact,
            icon: "assets/icons/Phone OTP.svg",
            press: () {},
          ),

          ProfileMenu(
            text: accounttype,
            icon: accounttype == 'Seller'?"assets/icons/seller.svg":accounttype == 'Buyer'?"assets/icons/buyer.svg":"assets/icons/recycle.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignInScreen.routeName, (Route<dynamic> route) => false);
              loggedAcountNumber();
            },
          ),
          SizedBox(height: baseHeight*0.02,),
          // const Text('Developed by Codespynner\nEmail: codespynner@gmail.com',textAlign: TextAlign.center,style: TextStyle(fontSize: 12.0,),),

          const DevText(),
        ],
      ),
    );
  }
}
