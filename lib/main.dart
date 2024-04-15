
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tkconnect/firebase_options.dart';
import 'package:tkconnect/screens/splash/SplashAnimation.dart';
import 'package:tkconnect/screens/splash/SplashDashboard.dart';
import 'package:tkconnect/utils/routes.dart';
import 'package:tkconnect/utils/size_config.dart';
import 'package:tkconnect/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var PhoneNumber = prefs.getString('loggedAccNumber');
  var CountyName = prefs.getString('loggedAccCounty');
  runApp(PhoneNumber == null ? const MyApp() : LoggedIn(PhoneNumber:PhoneNumber,CountyName:CountyName));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //You have to call it on your starting screen
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TakaConnect',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashAnimation.routeName,
      routes: routes,

    );
  }
}

class LoggedIn extends StatelessWidget {
  final String? PhoneNumber;
  final String? CountyName;
  const LoggedIn({Key? key, required this.PhoneNumber, required this.CountyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //You have to call it on your starting screen
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TakaConnect',
      theme: AppTheme.lightTheme(context),
      home: SplashDashboard(PhoneNumber:PhoneNumber,CountyName:CountyName),
      routes: routes,
    );
  }
}