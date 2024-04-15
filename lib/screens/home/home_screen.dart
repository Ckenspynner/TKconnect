import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../utils/enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Body(
          firstname: arguments['firstname'],
          lastname: arguments['lastname'],
          contact: arguments['contact'],
          county: arguments['county'],
          subcounty: arguments['subcounty'],
          accounttype: arguments['accounttype'],
          id: arguments['id'],
          gender: arguments['gender'],
        ),
        bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.home,
            id: '${arguments['id']}',
            firstname: arguments['firstname'],
            lastname: arguments['lastname'],
            contact: arguments['contact'],
            accounttype: arguments['accounttype'],
            county: arguments['county'],
            subcounty: arguments['subcounty'],
            gender: arguments['gender']
        ),
      ),
    );
  }
}
// ,arguments: {
// 'firstname': firstname,
// 'accounttype': accounttype,
// },
