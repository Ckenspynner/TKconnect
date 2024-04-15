import 'package:flutter/material.dart';

import '../../../models/Cart.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(order.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${order.quantity} ${order.productname} items',
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            // Text.rich(
            //   TextSpan(
            //     text: "${cart.product.price} Kshs",
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600, color: kPrimaryColor),
            //     children: [
            //       TextSpan(
            //           text: " x${cart.numOfItem}",
            //           style: Theme.of(context).textTheme.bodyText1),
            //     ],
            //   ),
            // ),
            order.buyer != ''? Text.rich(
              TextSpan(
                text: "Location: ${order.sellerlocation}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: "\nBuyer: ${order.buyer}\nContact: ${order.buyercontact}",)
                ],
              ),
            ):
            Text.rich(
              TextSpan(
                text: "Location: ${order.sellerlocation}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                    text: "\nRecycler: ${order.recycler}\nContact: ${order.recyclercontact}",)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
