import 'package:flutter/material.dart';
import 'package:tkconnect/screens/product_sellers/components/popular_sellers.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: getProportionateScreenHeight(20)),
            //const SellerHeader(),
            PopularSeller(),
          ],
        ),
      ),
    );
  }
}


// I/flutter (10016): Organics,Saw Dust,Kisauni
// I/flutter (10016): Metals,Heavy,Bamburi
// I/flutter (10016): Plastics,PET,Nyali
// I/flutter (10016): Glass,Broken Glass,Mkomani
// I/flutter (10016): Organics,Saw Dust,Kisauni
// I/flutter (10016): Metals,Heavy,Bamburi
// I/flutter (10016): Plastics,PET,Nyali
// I/flutter (10016): Glass,Broken Glass,Mkomani


