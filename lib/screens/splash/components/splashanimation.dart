import 'package:flutter/material.dart';
class SplashAnimationPage extends StatelessWidget {
  const SplashAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //const Spacer(flex: 2),
          Image.asset(
            'assets/images/appLogo.png',
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/2,
          ),
          // const Text(
          //   "tkconnect",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(color: Colors.black),
          // ),
        ],
      ),
    );
  }
}
