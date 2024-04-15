
import 'package:flutter/material.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';
import 'package:tkconnect/screens/product_sellers/sellers.dart';

import 'package:http/http.dart' as http;
import 'package:tkconnect/utils/http_strings.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';

class SellerProductCard extends StatefulWidget {
  SellerProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product, required this.firstname, required this.lastname, required this.county, required this.subcounty, required this.contact,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;final String firstname;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;

  @override
  State<SellerProductCard> createState() => _SellerProductCardState();
}

class _SellerProductCardState extends State<SellerProductCard> {

  //String widget.county = 'Taita Taveta';

  deleteSellerProduct(token, id) async {
    //,widget.county
    var path;

    //widget.county = 'Taita Taveta';

    if (widget.county == 'Mombasa') {//works
      path = deleteupdatemombasaproductsellerUrl;
    }
    if (widget.county == 'Lamu') {//works
      path = deleteupdatelamuproductsellerUrl;
    }
    if (widget.county == 'Kwale') {//works
      path = deleteupdatekwaleproductsellerUrl;
    }
    if (widget.county == 'Kilifi') {//works
      path = deleteupdatekilifiproductsellerUrl;
    }
    if (widget.county == 'Tana River') {//works
      path = deleteupdatetanariverproductsellerUrl;
    }
    if (widget.county == 'Taita Taveta') {//works
      path = deleteupdatetaitatavetaproductsellerUrl;
    }

    var uri = Uri.parse("$path/$id/");

    ///--------------------create mombasa produce seller

    await http.delete(uri, headers: {
      'Authorization': ' Token $token',
    });
    //print(response.body);

    // if (response.statusCode == 200) {
    //   final snackBar = SnackBar(
    //     backgroundColor: Colors.green,
    //     content: const Text('Deleted Successfully'),
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
    // }else{
    //   final snackBar = SnackBar(
    //     backgroundColor: Colors.redAccent,
    //     content: const Text('Delete Unsuccessfully'),
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
    // }
  }

  @override
  Widget build(BuildContext context) {
    //print(product.image);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    // print(arguments['firstname']);
    // print(arguments['lastname']);
    // print(arguments['contact']);
    // print(arguments['subcounty']);
    // print(arguments['contact']);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 147,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.greenAccent,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: ListView(
                    // This next line does the trick.
                    padding:
                        EdgeInsets.only(right: getProportionateScreenWidth(20)),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(widget.width),
                            child: AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(20)),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Hero(
                                  tag: widget.product.id.toString(),
                                  child: Image.network(widget.product.image),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: getProportionateScreenWidth(10)),
                              Text(
                                'Category: ${widget.product.category}',
                                style: const TextStyle(color: Colors.black),
                                maxLines: 2,
                              ),
                              Text(
                                'Type: ${widget.product.categorytype}\n',
                                style: const TextStyle(color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              Text(
                                "${widget.product.county} - ${widget.product.location}",
                                //style: const TextStyle(color: Colors.black),
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // IconButton(
                                  //   icon: const Icon(Icons.edit,
                                  //       color: kPrimaryColor
                                  //   ),
                                  //   onPressed: () {},
                                  // ),
                                  TextButton(
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                          'Warning',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to delete this product',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    //print(product.id);
                                                    deleteSellerProduct(
                                                        auth_token,
                                                        widget.product.id);
                                                    Navigator.pop(context);
                                                    //Navigator.pop(context);
                                                    Navigator.pushReplacementNamed(
                                                      context,
                                                      SellerScreen.routeName,
                                                      arguments: {
                                                        'barTitle':
                                                            'Your Products',
                                                        'firstname': arguments['firstname'],
                                                        'lastname': arguments['lastname'],
                                                        'contact': arguments['contact'],
                                                        'county': arguments['county'],
                                                        'subcounty': arguments['subcounty'],
                                                        'sortKey': 'hometosellerproductslist',
                                                      },
                                                    );
                                                  },
                                                  //Navigator.pop(context, 'Yes'),
                                                  child: const Text('Yes'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //   onPressed: (){
                                    //   print(product.id);
                                    // },
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Delete Product',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(5),
                                        ),
                                        Icon(
                                          Icons.delete_forever,
                                          color: Colors.redAccent,
                                          size: getProportionateScreenWidth(20),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // IconButton(
                                  //   icon: const Icon(Icons.delete_forever,
                                  //       color: Colors.redAccent
                                  //   ),
                                  //   onPressed: () {},
                                  // ),

                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       product.location,
                                  //       //style: const TextStyle(color: Colors.black),
                                  //       maxLines: 2,
                                  //     ),
                                  //     Text(
                                  //       product.county,
                                  //       //style: const TextStyle(color: Colors.black),
                                  //       maxLines: 2,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  //child:
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
