import 'package:flutter/material.dart';
import 'package:tkconnect/components/seller_card.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';
import 'package:tkconnect/models/Product.dart';
import 'package:tkconnect/utils/size_config.dart';

class PopularSeller extends StatelessWidget {

  const PopularSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding:
        //   EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        //   child: SectionTitle(title: "Categories", press: () {}),
        // ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              ...List.generate(
                demoCategories.length,
                    (index) {
                      //print('${demoProducts[index].title},${demoProducts[index].materialType},${demoProducts[index].subcounty}');
                  //if (demoProducts[index].isPopular) {
                    return SellerCard(product: demoCategories[index], customerAccount: '', firstname: '', lastname: '', county: '', subcounty: '', contact: '',);
                  //}

                  //return const SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              //SizedBox(width: getProportionateScreenWidth(20)),
              SizedBox(height: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
