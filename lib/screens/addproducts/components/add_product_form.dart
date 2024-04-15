import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tkconnect/screens/addproducts/components/form_section.dart';

class AddProductDetails extends StatefulWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;
  const AddProductDetails({
    Key? key, required this.firstname, required this.accounttype, required this.lastname, required this.county, required this.subcounty, required this.contact,
  }) : super(key: key);

  @override
  State<AddProductDetails> createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  String chatText = 'Chat', orderText = 'Order';

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(64),
        //   ),
        //   child: Text(
        //     'widget.product.description',
        //     maxLines: 3,
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: getProportionateScreenWidth(20),
        //     vertical: 10,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             _show_details = !_show_details;
        //           });
        //         },
        //         child: const Row(
        //           children: [
        //             Text(
        //               "See seller details",
        //               style: TextStyle(
        //                   fontWeight: FontWeight.w600, color: kPrimaryColor),
        //             ),
        //             SizedBox(width: 5),
        //             Icon(
        //               Icons.arrow_forward_ios,
        //               size: 12,
        //               color: kPrimaryColor,
        //             ),
        //           ],
        //         ),
        //       ),
        //       Visibility(
        //         visible: _show_details,
        //         maintainAnimation: true,
        //         maintainState: true,
        //         child: AnimatedOpacity(
        //           duration: const Duration(milliseconds: 500),
        //           curve: Curves.fastOutSlowIn,
        //           opacity: _show_details ? 1 : 0,
        //           child: const Padding(
        //             padding: EdgeInsets.only(
        //               top: 10,
        //             ),
        //             child: Column(
        //               children: [
        //                 Text(
        //                     'This section will hold the sellers basic information...'),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        AddProductForm(firstname: widget.firstname,
          lastname: widget.lastname,
          contact:widget.contact,
          county: widget.county,
          subcounty: widget.subcounty,
          accounttype: widget.accounttype,),
      ],
    );
  }
}
