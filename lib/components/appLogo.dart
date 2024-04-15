import 'package:flutter/material.dart';
import 'package:tkconnect/screens/addproducts/components/top_rounded_container.dart';
import 'package:tkconnect/utils/size_config.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopRoundedContainer(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            "assets/images/appLogo.png",
            width: getProportionateScreenWidth(80),
            height: getProportionateScreenWidth(80),
          ),
          const Text('TakaConnect'),
        ],
      ),
    );
  }
}
