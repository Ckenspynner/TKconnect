import 'package:flutter/material.dart';
import 'package:tkconnect/screens/addproducts/components/body.dart';
import 'package:tkconnect/screens/filter_by/filter_screen.dart';

class AddProductScreen extends StatelessWidget {
  static String routeName = "/addproducts";

  // final String firstname;
  // final String accounttype;
  // final String lastname;
  // final String county;
  // final String subcounty;
  // final String contact;

  const AddProductScreen(
      {super.key,
      // required this.firstname,
      // required this.accounttype,
      // required this.lastname,
      // required this.county,
      // required this.subcounty,
      // required this.contact
      });

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    //print(arguments['barTitle']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, FilterScreen.routeName);
            },
            child: arguments['barTitle'] != 'Add Products'
                ? Container(
                    padding: const EdgeInsets.only(right: 25),
                    child: const Icon(
                      Icons.sort,
                      color: Colors.black,
                    ),
                  )
                : Container(),
          ),
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            arguments['barTitle'],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F6F9),
      body: Body(
        firstname: arguments['firstname'],
        lastname: arguments['lastname'],
        contact: arguments['contact'],
        county: arguments['county'],
        subcounty: arguments['subcounty'],
        accounttype: arguments['accounttype'],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(height: getProportionateScreenWidth(20)),
      //       SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: Column(
      //           children: [
      //             SizedBox(height: getProportionateScreenWidth(20)),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
