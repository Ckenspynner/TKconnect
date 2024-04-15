import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tkconnect/screens/cart/cart_screen.dart';
import 'package:tkconnect/screens/home/home_screen.dart';
import 'package:tkconnect/screens/profile/profile_screen.dart';

import '../utils/constants.dart';
import '../utils/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String contact;
  final String accounttype;
  final String county;
  final String subcounty;
  final String gender;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.contact,
    required this.accounttype,
    required this.county,
    required this.subcounty,
    required this.gender,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName,
                      arguments: {
                        'id': id,
                        'firstname': firstname,
                        'lastname': lastname,
                        'contact': contact,
                        'accounttype': accounttype,
                        'county': county,
                        'subcounty': subcounty,
                        'gender': gender
                      },),
              ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Cart Icon.svg",
                  color: MenuState.order == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, CartScreen.routeName,
                      arguments: {
                        'id': id,
                        'firstname': firstname,
                        'lastname': lastname,
                        'contact': contact,
                        'accounttype': accounttype,
                        'county': county,
                        'subcounty': subcounty,
                        'gender': gender
                      },),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  ProfileScreen.routeName,
                  arguments: {
                    'id': id,
                    'firstname': firstname,
                    'lastname': lastname,
                    'contact': contact,
                    'accounttype': accounttype,
                    'county': county,
                    'subcounty': subcounty,
                    'gender': gender
                  },
                ),
              ),
            ],
          )),
    );
  }
}
