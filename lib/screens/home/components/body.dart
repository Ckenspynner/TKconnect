import 'package:flutter/material.dart';
import 'package:tkconnect/screens/home/components/waste_player_map.dart';
import '../../../utils/size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;
  final String gender;
  final String id;

  const Body(
      {Key? key,
      required this.firstname,
      required this.accounttype,
      required this.lastname,
      required this.county,
      required this.subcounty,
      required this.contact, required this.gender, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(
              accounttype: accounttype,
              firstname: firstname,
              lastname: lastname,
              contact: contact,
              county: county,
              subcounty: subcounty,
              id: id,
              gender: gender,
            ),
            //SizedBox(height: getProportionateScreenWidth(10)),
            //DiscountBanner(),
            Categories(
              accounttype: accounttype,
                firstname: firstname,
                lastname: lastname,
                contact: contact,
                county: county,
                subcounty: subcounty,
            ),
            //SpecialOffers(),
            //SizedBox(height: getProportionateScreenWidth(30)),
            //const PopularProducts(),
            const WastePlayerMap(),
          ],
        ),
      ),
    );
  }
}
