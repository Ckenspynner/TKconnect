import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tkconnect/screens/cart/cart_screen.dart';
import 'package:tkconnect/screens/home/components/icon_btn_with_counter.dart';
import 'package:tkconnect/utils/constants.dart';
import '../../../models/Cart.dart';
import '../../../utils/size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String contact;
  final String accounttype;
  final String county;
  final String subcounty;
  final String gender;

  const Body({
    super.key,
    required this.contact,
    required this.county,
    required this.subcounty,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.accounttype,
    required this.gender,
    //required this.accounttype
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProductOrdersService productOrderService = ProductOrdersService();
  late List<Orders> productOrders;

  String buyerorders = '';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    //print(arguments['accounttypecart']);

    arguments['accounttypecart'] == null
        ? buyerorders = 'Buyer'
        : buyerorders = arguments['accounttypecart'];

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              //"Your Cart",
              "Your Orders",
              style: TextStyle(color: Colors.black),
            ),
            // Text(
            //   "${demoCarts.length} items",
            //   style: Theme.of(context).textTheme.caption,
            // ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SearchField(firstname: firstname,
                // accounttype: accounttype,),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/buyer.svg",
                  press: () => Navigator.pushReplacementNamed(
                    context,
                    CartScreen.routeName,
                    arguments: {
                      'contact': widget.contact,
                      'county': widget.county,
                      'subcounty': widget.subcounty,
                      'accounttype': widget.accounttype,
                      'firstname': widget.firstname,
                      'lastname': widget.lastname,
                      'gender': widget.gender,
                      'id': widget.id,
                      'accounttypecart': 'Buyer',
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                IconBtnWithCounter(
                    //svgSrc: "assets/icons/Bell.svg",
                    svgSrc: "assets/icons/recycle.svg",
                    //numOfitem: 3,
                    press: () => Navigator.pushReplacementNamed(
                          context,
                          CartScreen.routeName,
                          arguments: {
                            'contact': widget.contact,
                            'county': widget.county,
                            'subcounty': widget.subcounty,
                            'accounttype': widget.accounttype,
                            'firstname': widget.firstname,
                            'lastname': widget.lastname,
                            'gender': widget.gender,
                            'id': widget.id,
                            'accounttypecart': 'Recycler',
                          },
                        )),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<ListOfProductOrders>(
        future: productOrderService.getMombasaProductOrders(
            widget.county, widget.subcounty, buyerorders),
        builder: (context, snapshot) {
          List<Orders>? productOrders = snapshot.data?.productOrders;

          if (snapshot.hasError) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/error404.png',
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(100),
                    ),
                    const Text(
                      '\nSomething went wrong\n\nMake sure you are having an\ninternet connection',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ));
          }
          if (snapshot.hasData) {
            //print('${productOrders?.length} Okobo');
            if (productOrders!.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: ListView.builder(
                    itemCount: productOrders.length,
                    itemBuilder: (context, index) => productOrders[index].sellercontact == widget.contact ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: Key(productOrders[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                productOrders.removeAt(index);
                              });
                            },
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                //color: const Color(0xFFFFE6E6),
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: CartCard(order: productOrders[index]),
                          ),
                        ):const SizedBox
                        .shrink(),
                ),
              );
            } else {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/norecord.png',
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(100),
                      ),
                      const Text(
                        '\nNo record found',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ));
            }
            // return const SizedBox
            //     .shrink(); // here by default width and height is 0
          } else {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: const LinearProgressIndicator(
                  backgroundColor: Color(0xFFB4B4B4),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ));
          }
        },
      ),
    );
  }
}
