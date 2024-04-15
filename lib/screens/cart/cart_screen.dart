import 'package:flutter/material.dart';
import 'package:tkconnect/components/coustom_bottom_nav_bar.dart';
import 'package:tkconnect/utils/enums.dart';

import 'components/body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      body: Body(
          id: '${arguments['id']}',
          firstname: arguments['firstname'],
          lastname: arguments['lastname'],
          contact: arguments['contact'],
          accounttype: arguments['accounttype'],
          county: arguments['county'],
          subcounty: arguments['subcounty'],
          gender: arguments['gender']
      ),
      // bottomNavigationBar: const CheckoutCard(),
      bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.order,
          id: '${arguments['id']}',
          firstname: arguments['firstname'],
          lastname: arguments['lastname'],
          contact: arguments['contact'],
          accounttype: arguments['accounttype'],
          county: arguments['county'],
          subcounty: arguments['subcounty'],
          gender: arguments['gender']
      ),
    );
  }

}
