import 'package:flutter/widgets.dart';
import 'package:tkconnect/screens/addproducts/addproducts.dart';
import 'package:tkconnect/screens/contactus/contactus.dart';
import 'package:tkconnect/screens/filter_by/filter_screen.dart';
import 'package:tkconnect/screens/home/home_screen.dart';
import 'package:tkconnect/screens/otp_home/otp.dart';
import 'package:tkconnect/screens/partners/partners.dart';
import 'package:tkconnect/screens/pilots/pilots.dart';
import 'package:tkconnect/screens/pilots/pilotstats.dart';
import 'package:tkconnect/screens/product_sellers/sellers.dart';
import 'package:tkconnect/screens/splash/SplashAnimation.dart';
import 'package:tkconnect/screens/splash/SplashDashboard.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/complete_profile/complete_profile_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/login_success/login_success_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  SellerScreen.routeName: (context) => const SellerScreen(),
  FilterScreen.routeName: (context) => const FilterScreen(),
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  SplashAnimation.routeName: (context) => const SplashAnimation(),
  PartnerScreen.routeName: (context) => const PartnerScreen(),
  ContactScreen.routeName: (context) => const ContactScreen(),
  PilotsScreen.routeName: (context) => const PilotsScreen(),
  PilotStatScreen.routeName: (context) => const PilotStatScreen(),
  SplashDashboard.routeName: (context) => const SplashDashboard(),
  OTP.routeName: (context) => const OTP(),
};


// TextFormField(
// keyboardType: TextInputType.text,
// onSaved: (newValue) => email = newValue,
// onChanged: (value) {
// if (value.isNotEmpty) {
// removeError(error: kEmailNullError);
// } else if (emailValidatorRegExp.hasMatch(value)) {
// removeError(error: kInvalidEmailError);
// }
// return null;
// },
// validator: (value) {
// if (value!.isEmpty) {
// addError(error: kEmailNullError);
// return "";
// } else if (!emailValidatorRegExp.hasMatch(value)) {
// addError(error: kInvalidEmailError);
// return "";
// }
// return null;
// },
// decoration: const InputDecoration(
// labelText: "Email",
// hintText: "Enter your email",
// // If  you are using latest version of flutter then lable text and hint text shown like this
// // if you r using flutter less then 1.20.* then maybe this is not working properly
// floatingLabelBehavior: FloatingLabelBehavior.always,
// suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
// ),
// ),