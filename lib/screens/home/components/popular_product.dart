import 'package:flutter/material.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';
import 'package:tkconnect/screens/product_sellers/sellers.dart';
import '../../../components/product_card.dart';
import '../../../utils/size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final String customerAccount;
  final String accounttype;
  final String lastname;
  final String firstname;
  final String county;
  final String subcounty;
  final String contact;

  const PopularProducts(
      {super.key,
      required this.customerAccount,
      required this.accounttype,
      required this.lastname,
      required this.firstname,
      required this.county,
      required this.subcounty,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    //print(customerAccount);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Categories",
              account: customerAccount,
              press: () {
                Navigator.pushNamed(context, SellerScreen.routeName,
                    arguments: {
                      'barTitle': 'Product List',
                      'customerAccount': customerAccount,
                      'sortKey': 'hometoallproductslist',
                      'firstname': firstname,
                      'lastname': lastname,
                      'contact': contact,
                      'accounttype': accounttype,
                      'county': county,
                      'subcounty': subcounty,
                    });
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoCategories.length,
                (index) {
                  if (demoCategories[index].isPopular) {
                    return ProductCard(
                      product: demoCategories[index],
                      county: county,
                      firstname: firstname,
                      lastname: lastname,
                      contact: contact,
                      subcounty: subcounty,
                    );
                  }

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
