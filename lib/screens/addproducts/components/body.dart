import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkconnect/screens/addproducts/components/add_product_form.dart';

import '../../../utils/size_config.dart';
import 'top_rounded_container.dart';
class Body extends StatelessWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;
  const Body({Key? key, required this.firstname, required this.accounttype, required this.lastname, required this.county, required this.subcounty, required this.contact, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              AddProductDetails(
                  firstname: firstname,
                  lastname: lastname,
                  contact: contact,
                  accounttype: accounttype,
                  county: county,
                  subcounty: subcounty,
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(product: product),

                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/taka_connect.png",
                              width: getProportionateScreenWidth(50),
                              height: getProportionateScreenWidth(50),
                            ),
                            const Text('--tkconnect--'),
                          ],
                        ),
                        // child: DefaultButton(
                        //   text: "Add To Cart",
                        //   press: () {},
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
