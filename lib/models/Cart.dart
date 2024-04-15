import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tkconnect/utils/http_strings.dart';

class ProductOrdersService {
  ///////////////////////////////////////////////////////////////-------------MOMBASA
  Future<ListOfProductOrders> getMombasaProductOrders(
      String county, String subcounty, String accounttype) async {

    var path;
    
    if (county == 'Mombasa') {
      //works
      path = accounttype == 'Buyer'?mombasaBuyerUrl:mombasaRecyclerUrl;
    }
    if (county == 'Lamu') {
      //works
      path = accounttype == 'Buyer'?lamuBuyerUrl:lamuRecyclerUrl;
    }
    if (county == 'Kwale') {
      //works
      path = accounttype == 'Buyer'?kwaleBuyerUrl:kwaleRecyclerUrl;
    }
    if (county == 'Kilifi') {
      //works
      path = accounttype == 'Buyer'?kilifiBuyerUrl:kilifiRecyclerUrl;
    }
    if (county == 'Tana River') {
      //works
      path = accounttype == 'Buyer'?tanariverBuyerUrl:tanariverRecyclerUrl;
    }
    if (county == 'Taita Taveta') {
      //works
      path = accounttype == 'Buyer'?taitatavetaBuyerUrl:taitatavetaRecyclerUrl;
    }

    // print(county);
    // print(subcounty);
    // print(accounttype);
    // print(path);

    var response = await http.get(Uri.parse(path));
    //print(jsonDecode(response.body));
    return ListOfProductOrders.fromJson(jsonDecode(response.body));
  }
}


class ListOfProductOrders {
  List<Orders> productOrders = [];

  ListOfProductOrders({required this.productOrders});

  factory ListOfProductOrders.fromJson(List list) {
    List<Orders> _productOrders = [];

    list.forEach((element) {
      _productOrders.add(Orders.fromJson(element));
    });
    //print(_productOrders[1].description);
    return ListOfProductOrders(productOrders: _productOrders);
  }
}
//
// ///////////////////////////////////////////////////////////////-------------TanaRiver
// class ListOfTanaRiverProductOrders {
//   List<Orders> productOrders = [];
//
//   ListOfTanaRiverProductOrders({required this.productOrders});
//
//   factory ListOfTanaRiverProductOrders.fromJson(List list) {
//     List<Orders> _productOrders = [];
//
//     list.forEach((element) {
//       _productOrders.add(Orders.fromJson(element));
//     });
//     //print(_productOrders[1].description);
//     return ListOfTanaRiverProductOrders(productOrders: _productOrders);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Kilifi
// class ListOfKilifiProductOrders {
//   List<Orders> productOrders = [];
//
//   ListOfKilifiProductOrders({required this.productOrders});
//
//   factory ListOfKilifiProductOrders.fromJson(List list) {
//     List<Orders> _productOrders = [];
//
//     list.forEach((element) {
//       _productOrders.add(Orders.fromJson(element));
//     });
//     //print(_productOrders[1].description);
//     return ListOfKilifiProductOrders(productOrders: _productOrders);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Lamu
// class ListOfLamuProductOrders {
//   List<Orders> productOrders = [];
//
//   ListOfLamuProductOrders({required this.productOrders});
//
//   factory ListOfLamuProductOrders.fromJson(List list) {
//     List<Orders> _productOrders = [];
//
//     list.forEach((element) {
//       _productOrders.add(Orders.fromJson(element));
//     });
//     //print(_productOrders[1].description);
//     return ListOfLamuProductOrders(productOrders: _productOrders);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Kwale
// class ListOfKwaleProductOrders {
//   List<Orders> productOrders = [];
//
//   ListOfKwaleProductOrders({required this.productOrders});
//
//   factory ListOfKwaleProductOrders.fromJson(List list) {
//     List<Orders> _productOrders = [];
//
//     list.forEach((element) {
//       _productOrders.add(Orders.fromJson(element));
//     });
//     //print(_productOrders[1].description);
//     return ListOfKwaleProductOrders(productOrders: _productOrders);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------TaitaTaveta
// class ListOfTaitaTavetaProductOrders {
//   List<Orders> productOrders = [];
//
//   ListOfTaitaTavetaProductOrders({required this.productOrders});
//
//   factory ListOfTaitaTavetaProductOrders.fromJson(List list) {
//     List<Orders> _productOrders = [];
//
//     list.forEach((element) {
//       _productOrders.add(Orders.fromJson(element));
//     });
//     //print(_productOrders[1].description);
//     return ListOfTaitaTavetaProductOrders(productOrders: _productOrders);
//   }
// }

class Orders {
  final int id;
  final String image;
  final String productname;
  final String buyer;
  final String recycler;
  final String buyercontact;
  final String recyclercontact;
  final String buyerlocation;
  final String recyclerlocation;
  final int quantity;
  final String seller;
  final String sellercontact;
  final String sellerlocation;
  final String orderstatus;

  Orders({
    required this.id,
    required this.image,
    required this.productname,
    required this.buyer,
    required this.recycler,
    required this.buyercontact,
    required this.recyclercontact,
    required this.buyerlocation,
    required this.recyclerlocation,
    required this.quantity,
    required this.seller,
    required this.sellercontact,
    required this.sellerlocation,
    required this.orderstatus,
  });

  factory Orders.fromJson(mapOfBody) {
    //print(mapOfBody["recyclerlocation"]);
    //print(mapOfBody["id"]);

    return Orders(
      id: mapOfBody["id"],
      image: mapOfBody["image"] ?? '',
      productname: mapOfBody["productname"] ?? '',
      buyer: mapOfBody["buyer"] ?? '',
      recycler: mapOfBody["recycler"] ?? '',
      buyercontact: mapOfBody["buyercontact"] ?? '',
      recyclercontact: mapOfBody["recyclercontact"] ?? '',
      buyerlocation: mapOfBody["buyerlocation"] ?? '',
      recyclerlocation: mapOfBody["recyclerlocation"] ?? '',
      quantity: mapOfBody["quantity"] ?? 0,
      seller: mapOfBody["seller"] ?? '',
      sellercontact: mapOfBody["sellercontact"] ?? '',
      sellerlocation: mapOfBody["sellerlocation"] ?? '',
      orderstatus: mapOfBody["orderstatus"] ?? '',
    );
  }
}
