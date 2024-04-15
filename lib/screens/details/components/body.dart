import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';
import '../../../utils/size_config.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final String customerAccount;
  final String firstname;
  final String lastname;
  final String county;
  final String contact;
  final String subcounty;

  const Body(
      {Key? key,
      required this.product,
      required this.customerAccount,
      required this.firstname,
      required this.lastname,
      required this.county,
      required this.contact,
      required this.subcounty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                customerAccount: customerAccount,
                firstname: firstname,
                lastname: lastname,
                contact: contact,
                county: county,
                subcounty: subcounty,
                pressOnSeeMore: () {},
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
                            const Text('TakaConnect'),
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
