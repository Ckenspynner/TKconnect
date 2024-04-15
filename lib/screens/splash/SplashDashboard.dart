
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tkconnect/screens/home/home_screen.dart';
import 'package:tkconnect/screens/login_success/login_success_screen.dart';
import 'package:tkconnect/screens/splash/components/SplashAnimation.dart';
import 'package:tkconnect/screens/splash/splash_screen.dart';


class SplashDashboard extends StatelessWidget {
  final String? PhoneNumber;
  final String? CountyName;
  const SplashDashboard({Key? key, this.PhoneNumber, this.CountyName}) : super(key: key);
  static String routeName = "/SplashDashboard";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 2000,
        splash: const SplashAnimationPage(),
        splashIconSize: 350,
        nextScreen: LoginSuccessScreen(PhoneNumber:PhoneNumber,CountyName:CountyName),//Text(SplashScreen.routeName),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.white);
  }
}

