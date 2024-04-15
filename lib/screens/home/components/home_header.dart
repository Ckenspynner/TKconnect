import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkconnect/screens/sign_in/sign_in_screen.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String contact;
  final String county;
  final String subcounty;
  final String gender;
  final String id;
  const HomeHeader({Key? key, required this.firstname, required this.accounttype, required this.lastname, required this.contact, required this.county, required this.subcounty, required this.gender, required this.id}) : super(key: key);

  Future<void> loggedAcountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedAccNumber');
    prefs.remove('loggedAccCounty');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(firstname: firstname,
            accounttype: accounttype,),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName,
              arguments: {
                'contact': contact,
                'county': county,
                'subcounty': subcounty,
                'accounttype': accounttype,
                'firstname': firstname,
                'lastname': lastname,
                'gender': gender,
                'id': id,
              },),
          ),
          IconBtnWithCounter(
            //svgSrc: "assets/icons/Bell.svg",
            svgSrc: "assets/icons/logout.svg",
            //numOfitem: 3,
            press: () async {
              //AuthenticationRepository.instance.logout();
              //Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(SignInScreen.routeName, (Route<dynamic> route) => false);
              loggedAcountNumber();
            },
          ),
        ],
      ),
    );
  }
}
