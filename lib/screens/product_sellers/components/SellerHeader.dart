import 'package:flutter/material.dart';
import 'package:tkconnect/screens/cart/cart_screen.dart';
import 'package:tkconnect/screens/home/components/icon_btn_with_counter.dart';
import 'package:tkconnect/screens/home/components/search_field.dart';
import 'package:tkconnect/utils/size_config.dart';
class SellerHeader extends StatelessWidget {
  const SellerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchField(firstname: '', accounttype: '',),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
