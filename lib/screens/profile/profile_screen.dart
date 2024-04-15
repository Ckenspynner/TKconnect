import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../utils/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Body(
        id: arguments['id'],
        firstname: arguments['firstname'],
        lastname: arguments['lastname'],
        contact: arguments['contact'],
        county: arguments['county'],
        subcounty: arguments['subcounty'],
        accounttype: arguments['accounttype'],
        gender: arguments['gender'],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.profile,
        id: arguments['id'],
        firstname: arguments['firstname'],
        lastname: arguments['lastname'],
        contact: arguments['contact'],
        county: arguments['county'],
        subcounty: arguments['subcounty'],
        accounttype: arguments['accounttype'],
        gender: arguments['gender'],
      ),
    );
  }
}
