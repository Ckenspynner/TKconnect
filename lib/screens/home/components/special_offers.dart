import 'package:flutter/material.dart';
import 'package:tkconnect/screens/addproducts/addproducts.dart';
import 'package:tkconnect/screens/home/components/icon_btn_with_counter.dart';
import 'package:tkconnect/screens/product_sellers/sellers.dart';
import '../../../utils/size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  final String accounttype;
  final String lastname;
  final String firstname;
  final String county;
  final String subcounty;
  final String contact;

  const SpecialOffers({
    Key? key,
    required this.accounttype,
    required this.lastname,
    required this.county,
    required this.subcounty,
    required this.contact,
    required this.firstname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Product Management",
            press: () {},
            account: '',
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/Image Banner 4.png",
                //image: "assets/images/seeproducts.png",
                category: "See Your Products",
                numOfBrands: 18,
                press: () {
                  Navigator.pushNamed(
                    context,
                    SellerScreen.routeName,
                    arguments: {
                      'barTitle': 'Your Products',
                      'sortKey': 'hometosellerproductslist',
                      'firstname': firstname,
                      'lastname': lastname,
                      'contact': contact,
                      'accounttype': accounttype,
                      'county': county,
                      'subcounty': subcounty,
                    },
                  );
                },
              ),
              SpecialOfferCard(
                image: "assets/images/Image Banner 5.png",
                //image: "assets/images/Image Banner 3.png",
                category: "Add Products",
                //numOfBrands: 24,
                press: () {
                  Navigator.pushNamed(
                    context,
                    AddProductScreen.routeName,
                    arguments: {
                      'barTitle': 'Add Products',
                      'firstname': firstname,
                      'lastname': lastname,
                      'contact': contact,
                      'accounttype': accounttype,
                      'county': county,
                      'subcounty': subcounty,
                    },
                  );
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int? numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(
                        //     text: numOfBrands == null
                        //         ? ''
                        //         : "$numOfBrands Products"),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: numOfBrands != null
                        ? null
                        : IconBtnWithCounter(
                            svgSrc: "assets/icons/add.svg",
                            //numOfitem: 3,
                            press: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   AddProductScreen.routeName,
                              //   arguments: {'barTitle': 'Add Products','firstname': firstname,
                              //     'lastname': lastname,
                              //     'contact': contact,
                              //     'accounttype': accounttype,
                              //     'county': county,
                              //     'subcounty': subcounty,},
                              // );
                            },
                          ),
                    // Container(
                    //   color: Colors.greenAccent,
                    //   child: IconBtnWithCounter(
                    //     svgSrc: "assets/icons/add.svg",
                    //     //numOfitem: 3,
                    //     press: () {},
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
