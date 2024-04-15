import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tkconnect/utils/http_strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/size_config.dart';
import 'package:http/http.dart' as http;

class OrderDetails extends StatefulWidget {
  final String imageurl;
  final String productname;
  final String buyername;
  final String buyercontact;
  final String buyerlocation;
  final String buyercounty;
  final int quantity;
  final int sellerid;
  final String sellername;
  final String sellerContact;
  final String sellerlocation;
  final String orderstatus;

  final String categorytype;
  final String category;
  final String customerAccount;

  const OrderDetails({
    Key? key,
    required this.sellerContact,
    required this.categorytype,
    required this.category,
    required this.buyercontact,
    required this.buyerlocation,
    required this.quantity,
    required this.sellername,
    required this.sellerlocation,
    required this.orderstatus,
    required this.imageurl,
    required this.productname,
    required this.buyername,
    required this.sellerid,
    required this.customerAccount,
    required this.buyercounty,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _show_order_panel = false;
  String chatText = 'Chat', orderText = 'Order';
  final _dropdownFormKey = GlobalKey<FormState>();
  var controllerQuantity = TextEditingController();

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  placeOrder(token, id, image, productname, buyer, buyercontact, buyerlocation,
      quantity, seller, sellercontact, sellerlocation, orderstatus) async {
    var path;

    if (widget.buyercounty == 'Mombasa') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createmombasaBuyerUrl
          : createmombasaRecyclerUrl;
    }
    if (widget.buyercounty == 'Lamu') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createlamuBuyerUrl
          : createlamuRecyclerUrl;
    }
    if (widget.buyercounty == 'Kwale') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createkwaleBuyerUrl
          : createkwaleRecyclerUrl;
    }
    if (widget.buyercounty == 'Kilifi') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createkilifiBuyerUrl
          : createkilifiRecyclerUrl;
    }
    if (widget.buyercounty == 'Tana River') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createtanariverBuyerUrl
          : createtanariverRecyclerUrl;
    }
    if (widget.buyercounty == 'Taita Taveta') {
      //works
      path = widget.customerAccount == 'Buyer'
          ? createtaitatavetaBuyerUrl
          : createtaitatavetaRecyclerUrl;
    }

    // print(path);
    // print(widget.buyercounty);
    // print(buyerlocation);
    var uri = Uri.parse(path);

    ///--------------------create mombasa produce seller
    Map data = {
      'image': '$image',
      'id': '$id',
      'productname': '$productname',
      widget.customerAccount == 'Buyer' ? 'buyer' : 'recycler': '$buyer',
      widget.customerAccount == 'Buyer' ? 'buyercontact' : 'recyclercontact':
          '$buyercontact',
      widget.customerAccount == 'Buyer' ? 'buyerlocation' : 'recyclerlocation':
          '$buyerlocation',
      'quantity': '$quantity',
      'seller': '$seller',
      'sellercontact': '$sellercontact',
      'sellerlocation': '$sellerlocation',
      'orderstatus': '$orderstatus',
    };

    var response = await http.post(uri, body: data, headers: {
      'Authorization': ' Token $token',
    });
    // print(response.body.length);
    // if (error != null) {
    //   Get.showSnackbar(GetSnackBar(message: error.toString(),));
    // }

    if (response.statusCode == 200) {
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Ordered Successfully'),
        // action: SnackBarAction(
        //   textColor: Colors.white,
        //   label: 'Undo',
        //   onPressed: () {
        //     // Some code to undo the change.
        //   },
        // ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: const Text('Order Unsuccessfully'),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.quantity);
    // if (widget.sellerContact == widget.buyercontact) {
    //   orderText = 'Add Stock';
    // } else {
    //   orderText == 'Order';
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center(
        // child: ElevatedButton(
        // onPressed: () {
        //   final snackBar = SnackBar(
        //     backgroundColor: Colors.green,
        //     content: const Text('Ordered Successfully'),
        //     action: SnackBarAction(
        //       textColor: Colors.white,
        //       label: 'Undo',
        //       onPressed: () {
        //         // Some code to undo the change.
        //       },
        //     ),
        //   );
        //
        //   // Find the ScaffoldMessenger in the widget tree
        //   // and use it to show a SnackBar.
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // },
        // child: const Text('Show SnackBar'),
        // ),
        // ),
        Visibility(
          visible: _show_order_panel,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: _show_order_panel ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _dropdownFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerQuantity,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Quantity',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.category,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Quantity Counts";
                        } else {
                          if (int.parse(controllerQuantity.text) <= 0 ) {
                            return "Total Counts can't be 0 or Less than 0";
                          } else {
                            if (widget.quantity == 0) {
                              return "This product is out of stock";
                            } else {
                              if (int.parse(controllerQuantity.text)>widget.quantity) {
                                return "Only ${widget.quantity} items available";
                              } else {
                                return null;
                              }
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (chatText == 'Chat') {
                      //print('${random(100000000, 999999999)}');
                      Uri sms = Uri.parse(
                          'sms:${widget.sellerContact}?body=Hello, Are ${widget.categorytype} still available.');
                      if (await launchUrl(sms)) {
                        //app opened
                      } else {
                        //app is not opened
                      }
                    } else {}
                    setState(() {
                      _show_order_panel = false;
                      chatText = 'Chat';
                      orderText = 'Order';
                    });
                  },
                  child: Container(
                    color: _show_order_panel
                        ? Colors.red
                        : const Color(0xFFC4DFB4),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chatText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ), //color: kPrimaryColor),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          _show_order_panel
                              ? Icons.close_outlined
                              : Icons.message,
                          size: 12,
                          color: Colors.white,
                          //color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      //if (orderText == 'Order' || orderText == 'Add Stock') {
                      if (orderText == 'Order') {
                        _show_order_panel = !_show_order_panel;
                        chatText = 'Close';
                        orderText = 'Submit';
                      } else {
                        if (_dropdownFormKey.currentState!.validate()) {
                          _show_order_panel = !_show_order_panel;
                          chatText = 'Chat';
                          orderText = 'Order';

                          placeOrder(
                              auth_token,
                              widget.sellerid,
                              widget.imageurl,
                              widget.productname,
                              widget.buyername,
                              widget.buyercontact,
                              widget.buyerlocation,
                              controllerQuantity.text,
                              //orderText == 'Add Stock'?'-${controllerQuantity.text}':controllerQuantity.text,
                              widget.sellername,
                              widget.sellerContact,
                              widget.sellerlocation,
                              widget.orderstatus);
                        }
                      }
                    });
                  },
                  child: Container(
                    color: _show_order_panel
                        ? Colors.green
                        : const Color(0xFFC4DFB4),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ), //color: kPrimaryColor),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          //Icons.shopping_cart_checkout_sharp,
                          _show_order_panel
                              ? Icons.arrow_forward
                              : Icons.shopping_cart_checkout_sharp,
                          size: 12,
                          color: Colors.white,
                          //color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
