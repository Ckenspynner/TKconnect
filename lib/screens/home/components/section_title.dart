import 'package:flutter/material.dart';
import 'package:tkconnect/utils/constants.dart';

import '../../../utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.account,
  }) : super(key: key);

  final String title;
  final String? account;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            account == 'Buyer'?"What's in the Market":account == 'Recycler'?"What's in the Market":'Seller Account',
            //style: TextStyle(color: Color(0xFFBBBBBB),),
            style: const TextStyle(color: kPrimaryColor,),
          ),
        ),
      ],
    );
  }
}
