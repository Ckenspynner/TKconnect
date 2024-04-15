import 'package:flutter/material.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: agrs.product.rating),
      ),
      body: Body(
          product: agrs.product,
          customerAccount: agrs.customerAccount,
          firstname: agrs.firstname,
          lastname: agrs.lastname,
          county: agrs.county,
          contact: agrs.contact,
          subcounty: agrs.subcounty),
    );
  }
}

class ProductDetailsArguments {
  final String firstname;
  final String lastname;
  final String county;
  final String contact;
  final String subcounty;
  final Product product;
  final String customerAccount;

  ProductDetailsArguments({
    required this.product,
    required this.customerAccount,
    required this.firstname,
    required this.lastname,
    required this.county,
    required this.contact,
    required this.subcounty,
  });
}
