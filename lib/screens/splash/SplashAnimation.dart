import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tkconnect/screens/splash/components/splashanimation.dart';
import 'package:tkconnect/screens/splash/splash_screen.dart';


class SplashAnimation extends StatelessWidget {
  const SplashAnimation({Key? key}) : super(key: key);
  static String routeName = "/splashAnimation";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: const SplashAnimationPage(),
        splashIconSize: 350,
        nextScreen: const SplashScreen(),//Text(SplashScreen.routeName),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.white);
  }
}


