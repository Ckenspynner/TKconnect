import 'package:flutter/material.dart';
import 'package:tkconnect/components/seller_card.dart';
import 'package:tkconnect/components/seller_product_card.dart';
import 'package:tkconnect/data_service/products/productsellerservice.dart';

//import 'package:tkconnect/models/Product.dart';
import 'package:tkconnect/screens/filter_by/filter_screen.dart';
import 'package:tkconnect/utils/size_config.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({Key? key}) : super(key: key);
  static String routeName = "/sellers";

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  ProductSellersService productSellersService = ProductSellersService();
  late List<Product> productSellers;

//  String arguments['county'] = 'Taita Taveta';
  // String arguments['contact'] = '0702407935';

  @override
  void initState() {
    // TODO: implement initState
    //productSellers = productSellersService.getProductSellers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    // print(arguments['firstname']);
    // print(arguments['lastname']);
    // print(arguments['contact']);
    // print(arguments['subcounty']);
    // print(arguments['contact']);
    //print(arguments['county']);
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
              Navigator.pushNamed(
                context,
                FilterScreen.routeName,
                arguments: {
                  'firstname': arguments['firstname'],
                  'lastname': arguments['lastname'],
                  'contact': arguments['contact'],
                  'county': arguments['county'],
                  'subcounty': arguments['subcounty'],
                },
              );
            },
            child: arguments['barTitle'] != 'Your Products'
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: getProportionateScreenWidth(20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, //ListOfTanaRiverProductSellers
              child: arguments['county'] == 'Mombasa'
                  ? FutureBuilder<ListOfMombasaProductSellers>(
                      future: productSellersService.getMombasaProductSellers(),
                      builder: (context, snapshot) {
                        List<Product>? productSellers =
                            snapshot.data?.productSellers;

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
                          if (productSellers!.isNotEmpty) {
                            return Wrap(direction: Axis.vertical, children: [
                              //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                              ...List.generate(
                                productSellers.length,
                                (index) {
                                  //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                  //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                  //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                  if (arguments['barTitle'] ==
                                          '${arguments['filterTitle']} Sellers' &&
                                      arguments['sortKey'] ==
                                          'hometospecific') {
                                    return productSellers[index].category !=
                                            arguments['filterTitle']
                                        ? const SizedBox.shrink()
                                        : SellerCard(
                                            firstname: arguments['firstname'],
                                            lastname: arguments['lastname'],
                                            contact: arguments['contact'],
                                            county: arguments['county'],
                                            subcounty: arguments['subcounty'],
                                            product: productSellers[index],
                                            customerAccount:
                                                '${arguments['customerAccount']}',
                                          );
                                  }

                                  ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                  ///
                                  if (arguments['barTitle'] ==
                                          '${arguments['filterTitle']} Sellers' &&
                                      arguments['filterType'] !=
                                          'All Categories Types' &&
                                      arguments['filterCounty'] !=
                                          'All Sub-County') {
                                    return productSellers[index].location !=
                                            arguments['filterCounty']
                                        ? const SizedBox.shrink()
                                        : SellerCard(
                                            firstname: arguments['firstname'],
                                            lastname: arguments['lastname'],
                                            contact: arguments['contact'],
                                            county: arguments['county'],
                                            subcounty: arguments['subcounty'],
                                            product: productSellers[index],
                                            customerAccount:
                                                '${arguments['customerAccount']}',
                                          );
                                  }

                                  ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                  if (arguments['barTitle'] == 'Product List' &&
                                      arguments['filterType'] ==
                                          'All Categories Types' &&
                                      arguments['filterCounty'] ==
                                          'All Sub-County') {
                                    //print('Okobo');
                                    return SellerCard(
                                      firstname: arguments['firstname'],
                                      lastname: arguments['lastname'],
                                      contact: arguments['contact'],
                                      county: arguments['county'],
                                      subcounty: arguments['subcounty'],
                                      product: productSellers[index],
                                      customerAccount:
                                          '${arguments['customerAccount']}',
                                    );
                                  }

                                  ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                  if (arguments['barTitle'] ==
                                          '${arguments['filterTitle']} Sellers' &&
                                      arguments['filterType'] ==
                                          'All Categories Types' &&
                                      arguments['filterCounty'] ==
                                          'All Sub-County') {
                                    //print('Okobo');
                                    return productSellers[index].category !=
                                            arguments['filterTitle']
                                        ? const SizedBox.shrink()
                                        : SellerCard(
                                            firstname: arguments['firstname'],
                                            lastname: arguments['lastname'],
                                            contact: arguments['contact'],
                                            county: arguments['county'],
                                            subcounty: arguments['subcounty'],
                                            product: productSellers[index],
                                            customerAccount:
                                                '${arguments['customerAccount']}',
                                          );
                                  }

                                  ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                  if (arguments['barTitle'] == 'Product List' &&
                                      arguments['filterType'] ==
                                          'All Categories Types' &&
                                      arguments['filterCounty'] !=
                                          'All Sub-County') {
                                    return productSellers[index].location !=
                                            arguments['filterCounty']
                                        ? const SizedBox.shrink()
                                        : SellerCard(
                                            firstname: arguments['firstname'],
                                            lastname: arguments['lastname'],
                                            contact: arguments['contact'],
                                            county: arguments['county'],
                                            subcounty: arguments['subcounty'],
                                            product: productSellers[index],
                                            customerAccount:
                                                '${arguments['customerAccount']}',
                                          );
                                  }

                                  ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                  if (arguments['barTitle'] ==
                                          '${arguments['filterTitle']} Sellers' &&
                                      arguments['filterType'] ==
                                          'All Categories Types' &&
                                      arguments['filterCounty'] !=
                                          'All Sub-County') {
                                    return productSellers[index].location !=
                                            arguments['filterCounty']
                                        ? const SizedBox.shrink()
                                        : SellerCard(
                                            firstname: arguments['firstname'],
                                            lastname: arguments['lastname'],
                                            contact: arguments['contact'],
                                            county: arguments['county'],
                                            subcounty: arguments['subcounty'],
                                            product: productSellers[index],
                                            customerAccount:
                                                '${arguments['customerAccount']}',
                                          );
                                  }

                                  ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                  if (arguments['barTitle'] != 'Product List' &&
                                      arguments['filterType'] !=
                                          'All Categories Types' &&
                                      arguments['filterCounty'] ==
                                          'All Sub-County' &&
                                      arguments['sortKey'] ==
                                          'Paper Seller, Cardboard, All Sub-County') {
                                    return //productSellers[index].category !=arguments['filterTitle'] &&
                                        productSellers[index].categorytype !=
                                                arguments['filterType']
                                            ? const SizedBox.shrink()
                                            : SellerCard(
                                                firstname:
                                                    arguments['firstname'],
                                                lastname: arguments['lastname'],
                                                contact: arguments['contact'],
                                                county: arguments['county'],
                                                subcounty:
                                                    arguments['subcounty'],
                                                product: productSellers[index],
                                                customerAccount:
                                                    '${arguments['customerAccount']}',
                                              );
                                  }

                                  ///-----------------------------------//CASE : Your Products ,null ,null
                                  if (arguments['barTitle'] ==
                                          'Your Products' &&
                                      arguments['filterType'] !=
                                          'All Categories Types' &&
                                      arguments['filterCounty'] !=
                                          'All Sub-County' &&
                                      arguments['sortKey'] ==
                                          'hometosellerproductslist') {
                                    return arguments['contact'] ==
                                            productSellers[index].contact
                                        ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                            product: productSellers[index])
                                        : const SizedBox.shrink();
                                  }

                                  ///---------------------------------------- //CASE : Product List ,null ,null

                                  if (arguments['barTitle'] == 'Product List' &&
                                      arguments['filterType'] !=
                                          'All Categories Types' &&
                                      arguments['filterCounty'] !=
                                          'All Sub-County' &&
                                      arguments['sortKey'] ==
                                          'hometoallproductslist') {
                                    return SellerCard(
                                      firstname: arguments['firstname'],
                                      lastname: arguments['lastname'],
                                      contact: arguments['contact'],
                                      county: arguments['county'],
                                      subcounty: arguments['subcounty'],
                                      product: productSellers[index],
                                      customerAccount:
                                          arguments['customerAccount'],
                                    );
                                  }

                                  return const SizedBox
                                      .shrink(); // here by default width and height is 0
                                },
                              ),
                              SizedBox(height: getProportionateScreenWidth(20)),
                            ]);
                          } else {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
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
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: LinearProgressIndicator(
                              backgroundColor: Color(0xFFB4B4B4),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            )),
                          );
                        }
                      },
                    )
                  : arguments['county'] == 'Tana River'
                      ? FutureBuilder<ListOfTanaRiverProductSellers>(
                          future: productSellersService
                              .getTanaRiverProductSellers(),
                          builder: (context, snapshot) {
                            List<Product>? productSellers =
                                snapshot.data?.productSellers;

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
                              if (productSellers!.isNotEmpty) {
                                return Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                                      ...List.generate(
                                        productSellers!.length,
                                        (index) {
                                          //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                          //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                          //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                          if (arguments['barTitle'] ==
                                                  '${arguments['filterTitle']} Sellers' &&
                                              arguments['sortKey'] ==
                                                  'hometospecific') {
                                            return productSellers[index]
                                                        .category !=
                                                    arguments['filterTitle']
                                                ? const SizedBox.shrink()
                                                : SellerCard(
                                                    firstname:
                                                        arguments['firstname'],
                                                    lastname:
                                                        arguments['lastname'],
                                                    contact:
                                                        arguments['contact'],
                                                    county: arguments['county'],
                                                    subcounty:
                                                        arguments['subcounty'],
                                                    product:
                                                        productSellers[index],
                                                    customerAccount:
                                                        '${arguments['customerAccount']}',
                                                  );
                                          }

                                          ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                          ///
                                          if (arguments['barTitle'] ==
                                                  '${arguments['filterTitle']} Sellers' &&
                                              arguments['filterType'] !=
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] !=
                                                  'All Sub-County') {
                                            return productSellers[index]
                                                        .location !=
                                                    arguments['filterCounty']
                                                ? const SizedBox.shrink()
                                                : SellerCard(
                                                    firstname:
                                                        arguments['firstname'],
                                                    lastname:
                                                        arguments['lastname'],
                                                    contact:
                                                        arguments['contact'],
                                                    county: arguments['county'],
                                                    subcounty:
                                                        arguments['subcounty'],
                                                    product:
                                                        productSellers[index],
                                                    customerAccount:
                                                        '${arguments['customerAccount']}',
                                                  );
                                          }

                                          ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                          if (arguments['barTitle'] ==
                                                  'Product List' &&
                                              arguments['filterType'] ==
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] ==
                                                  'All Sub-County') {
                                            //print('Okobo');
                                            return SellerCard(
                                              firstname: arguments['firstname'],
                                              lastname: arguments['lastname'],
                                              contact: arguments['contact'],
                                              county: arguments['county'],
                                              subcounty: arguments['subcounty'],
                                              product: productSellers[index],
                                              customerAccount:
                                                  '${arguments['customerAccount']}',
                                            );
                                          }

                                          ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                          if (arguments['barTitle'] ==
                                                  '${arguments['filterTitle']} Sellers' &&
                                              arguments['filterType'] ==
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] ==
                                                  'All Sub-County') {
                                            //print('Okobo');
                                            return productSellers[index]
                                                        .category !=
                                                    arguments['filterTitle']
                                                ? const SizedBox.shrink()
                                                : SellerCard(
                                                    firstname:
                                                        arguments['firstname'],
                                                    lastname:
                                                        arguments['lastname'],
                                                    contact:
                                                        arguments['contact'],
                                                    county: arguments['county'],
                                                    subcounty:
                                                        arguments['subcounty'],
                                                    product:
                                                        productSellers[index],
                                                    customerAccount:
                                                        '${arguments['customerAccount']}',
                                                  );
                                          }

                                          ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                          if (arguments['barTitle'] ==
                                                  'Product List' &&
                                              arguments['filterType'] ==
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] !=
                                                  'All Sub-County') {
                                            return productSellers[index]
                                                        .location !=
                                                    arguments['filterCounty']
                                                ? const SizedBox.shrink()
                                                : SellerCard(
                                                    firstname:
                                                        arguments['firstname'],
                                                    lastname:
                                                        arguments['lastname'],
                                                    contact:
                                                        arguments['contact'],
                                                    county: arguments['county'],
                                                    subcounty:
                                                        arguments['subcounty'],
                                                    product:
                                                        productSellers[index],
                                                    customerAccount:
                                                        '${arguments['customerAccount']}',
                                                  );
                                          }

                                          ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                          if (arguments['barTitle'] ==
                                                  '${arguments['filterTitle']} Sellers' &&
                                              arguments['filterType'] ==
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] !=
                                                  'All Sub-County') {
                                            return productSellers[index]
                                                        .location !=
                                                    arguments['filterCounty']
                                                ? const SizedBox.shrink()
                                                : SellerCard(
                                                    firstname:
                                                        arguments['firstname'],
                                                    lastname:
                                                        arguments['lastname'],
                                                    contact:
                                                        arguments['contact'],
                                                    county: arguments['county'],
                                                    subcounty:
                                                        arguments['subcounty'],
                                                    product:
                                                        productSellers[index],
                                                    customerAccount:
                                                        '${arguments['customerAccount']}',
                                                  );
                                          }

                                          ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                          if (arguments['barTitle'] !=
                                                  'Product List' &&
                                              arguments['filterType'] !=
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] ==
                                                  'All Sub-County' &&
                                              arguments['sortKey'] ==
                                                  'Paper Seller, Cardboard, All Sub-County') {
                                            return //productSellers[index].category !=arguments['filterTitle'] &&
                                                productSellers[index]
                                                            .categorytype !=
                                                        arguments['filterType']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                          }

                                          ///-----------------------------------//CASE : Your Products ,null ,null
                                          if (arguments['barTitle'] ==
                                                  'Your Products' &&
                                              arguments['filterType'] !=
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] !=
                                                  'All Sub-County' &&
                                              arguments['sortKey'] ==
                                                  'hometosellerproductslist') {
                                            return arguments['contact'] ==
                                                    productSellers[index]
                                                        .contact
                                                ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                    product:
                                                        productSellers[index])
                                                : const SizedBox.shrink();
                                          }

                                          ///---------------------------------------- //CASE : Product List ,null ,null

                                          if (arguments['barTitle'] ==
                                                  'Product List' &&
                                              arguments['filterType'] !=
                                                  'All Categories Types' &&
                                              arguments['filterCounty'] !=
                                                  'All Sub-County' &&
                                              arguments['sortKey'] ==
                                                  'hometoallproductslist') {
                                            return SellerCard(
                                              firstname: arguments['firstname'],
                                              lastname: arguments['lastname'],
                                              contact: arguments['contact'],
                                              county: arguments['county'],
                                              subcounty: arguments['subcounty'],
                                              product: productSellers[index],
                                              customerAccount:
                                                  arguments['customerAccount'],
                                            );
                                          }

                                          return const SizedBox
                                              .shrink(); // here by default width and height is 0
                                        },
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenWidth(20)),
                                    ]);
                              } else {
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            'assets/images/norecord.png',
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(100),
                                        ),
                                        const Text(
                                          '\nNo record found',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ));
                              }
                            } else {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                    child: LinearProgressIndicator(
                                  backgroundColor: Color(0xFFB4B4B4),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                )),
                              );
                            }
                          },
                        )
                      : arguments['county'] == 'Kwale'
                          ? FutureBuilder<ListOfKwaleProductSellers>(
                              future: productSellersService
                                  .getKwaleProductSellers(),
                              builder: (context, snapshot) {
                                List<Product>? productSellers =
                                    snapshot.data?.productSellers;

                                if (snapshot.hasError) {
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/images/error404.png',
                                            ),
                                          ),
                                          SizedBox(
                                            width: getProportionateScreenWidth(
                                                100),
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
                                  if (productSellers!.isNotEmpty) {
                                    return Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                                          ...List.generate(
                                            productSellers!.length,
                                            (index) {
                                              //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                              //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                              //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                              if (arguments['barTitle'] ==
                                                      '${arguments['filterTitle']} Sellers' &&
                                                  arguments['sortKey'] ==
                                                      'hometospecific') {
                                                return productSellers[index]
                                                            .category !=
                                                        arguments['filterTitle']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                              }

                                              ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                              ///
                                              if (arguments['barTitle'] ==
                                                      '${arguments['filterTitle']} Sellers' &&
                                                  arguments['filterType'] !=
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] !=
                                                      'All Sub-County') {
                                                return productSellers[index]
                                                            .location !=
                                                        arguments[
                                                            'filterCounty']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                              }

                                              ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                              if (arguments['barTitle'] ==
                                                      'Product List' &&
                                                  arguments['filterType'] ==
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] ==
                                                      'All Sub-County') {
                                                //print('Okobo');
                                                return SellerCard(
                                                  firstname:
                                                      arguments['firstname'],
                                                  lastname:
                                                      arguments['lastname'],
                                                  contact: arguments['contact'],
                                                  county: arguments['county'],
                                                  subcounty:
                                                      arguments['subcounty'],
                                                  product:
                                                      productSellers[index],
                                                  customerAccount:
                                                      '${arguments['customerAccount']}',
                                                );
                                              }

                                              ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                              if (arguments['barTitle'] ==
                                                      '${arguments['filterTitle']} Sellers' &&
                                                  arguments['filterType'] ==
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] ==
                                                      'All Sub-County') {
                                                //print('Okobo');
                                                return productSellers[index]
                                                            .category !=
                                                        arguments['filterTitle']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                              }

                                              ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                              if (arguments['barTitle'] ==
                                                      'Product List' &&
                                                  arguments['filterType'] ==
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] !=
                                                      'All Sub-County') {
                                                return productSellers[index]
                                                            .location !=
                                                        arguments[
                                                            'filterCounty']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                              }

                                              ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                              if (arguments['barTitle'] ==
                                                      '${arguments['filterTitle']} Sellers' &&
                                                  arguments['filterType'] ==
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] !=
                                                      'All Sub-County') {
                                                return productSellers[index]
                                                            .location !=
                                                        arguments[
                                                            'filterCounty']
                                                    ? const SizedBox.shrink()
                                                    : SellerCard(
                                                        firstname: arguments[
                                                            'firstname'],
                                                        lastname: arguments[
                                                            'lastname'],
                                                        contact: arguments[
                                                            'contact'],
                                                        county:
                                                            arguments['county'],
                                                        subcounty: arguments[
                                                            'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index],
                                                        customerAccount:
                                                            '${arguments['customerAccount']}',
                                                      );
                                              }

                                              ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                              if (arguments['barTitle'] !=
                                                      'Product List' &&
                                                  arguments['filterType'] !=
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] ==
                                                      'All Sub-County' &&
                                                  arguments['sortKey'] ==
                                                      'Paper Seller, Cardboard, All Sub-County') {
                                                return //productSellers[index].category !=arguments['filterTitle'] &&
                                                    productSellers[index]
                                                                .categorytype !=
                                                            arguments[
                                                                'filterType']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                              }

                                              ///-----------------------------------//CASE : Your Products ,null ,null
                                              if (arguments['barTitle'] ==
                                                      'Your Products' &&
                                                  arguments['filterType'] !=
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] !=
                                                      'All Sub-County' &&
                                                  arguments['sortKey'] ==
                                                      'hometosellerproductslist') {
                                                return arguments['contact'] ==
                                                        productSellers[index]
                                                            .contact
                                                    ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                        product:
                                                            productSellers![
                                                                index])
                                                    : const SizedBox.shrink();
                                              }

                                              ///---------------------------------------- //CASE : Product List ,null ,null

                                              if (arguments['barTitle'] ==
                                                      'Product List' &&
                                                  arguments['filterType'] !=
                                                      'All Categories Types' &&
                                                  arguments['filterCounty'] !=
                                                      'All Sub-County' &&
                                                  arguments['sortKey'] ==
                                                      'hometoallproductslist') {
                                                return SellerCard(
                                                  firstname:
                                                      arguments['firstname'],
                                                  lastname:
                                                      arguments['lastname'],
                                                  contact: arguments['contact'],
                                                  county: arguments['county'],
                                                  subcounty:
                                                      arguments['subcounty'],
                                                  product:
                                                      productSellers[index],
                                                  customerAccount: arguments[
                                                      'customerAccount'],
                                                );
                                              }

                                              return const SizedBox
                                                  .shrink(); // here by default width and height is 0
                                            },
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      20)),
                                        ]);
                                  } else {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/images/norecord.png',
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      100),
                                            ),
                                            const Text(
                                              '\nNo record found',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ));
                                  }
                                } else {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                        child: LinearProgressIndicator(
                                      backgroundColor: Color(0xFFB4B4B4),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                    )),
                                  );
                                }
                              },
                            )
                          : arguments['county'] == 'Kilifi'
                              ? FutureBuilder<ListOfKilifiProductSellers>(
                                  future: productSellersService
                                      .getKilifiProductSellers(),
                                  builder: (context, snapshot) {
                                    List<Product>? productSellers =
                                        snapshot.data?.productSellers;

                                    if (snapshot.hasError) {
                                      return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Image.asset(
                                                  'assets/images/error404.png',
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        100),
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
                                      if (productSellers!.isNotEmpty) {
                                        return Wrap(
                                            direction: Axis.vertical,
                                            children: [
                                              //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                                              ...List.generate(
                                                productSellers!.length,
                                                (index) {
                                                  //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                                  //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                                  //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                                  if (arguments['barTitle'] ==
                                                          '${arguments['filterTitle']} Sellers' &&
                                                      arguments['sortKey'] ==
                                                          'hometospecific') {
                                                    return productSellers![
                                                                    index]
                                                                .category !=
                                                            arguments[
                                                                'filterTitle']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                                  }

                                                  ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                                  ///
                                                  if (arguments['barTitle'] ==
                                                          '${arguments['filterTitle']} Sellers' &&
                                                      arguments['filterType'] !=
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] !=
                                                          'All Sub-County') {
                                                    return productSellers![
                                                                    index]
                                                                .location !=
                                                            arguments[
                                                                'filterCounty']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                                  }

                                                  ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                                  if (arguments['barTitle'] ==
                                                          'Product List' &&
                                                      arguments['filterType'] ==
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] ==
                                                          'All Sub-County') {
                                                    //print('Okobo');
                                                    return SellerCard(
                                                      firstname: arguments[
                                                          'firstname'],
                                                      lastname:
                                                          arguments['lastname'],
                                                      contact:
                                                          arguments['contact'],
                                                      county:
                                                          arguments['county'],
                                                      subcounty: arguments[
                                                          'subcounty'],
                                                      product: productSellers![
                                                          index],
                                                      customerAccount:
                                                          '${arguments['customerAccount']}',
                                                    );
                                                  }

                                                  ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                                  if (arguments['barTitle'] ==
                                                          '${arguments['filterTitle']} Sellers' &&
                                                      arguments['filterType'] ==
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] ==
                                                          'All Sub-County') {
                                                    //print('Okobo');
                                                    return productSellers![
                                                                    index]
                                                                .category !=
                                                            arguments[
                                                                'filterTitle']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                                  }

                                                  ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                                  if (arguments['barTitle'] ==
                                                          'Product List' &&
                                                      arguments['filterType'] ==
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] !=
                                                          'All Sub-County') {
                                                    return productSellers![
                                                                    index]
                                                                .location !=
                                                            arguments[
                                                                'filterCounty']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                                  }

                                                  ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                                  if (arguments['barTitle'] ==
                                                          '${arguments['filterTitle']} Sellers' &&
                                                      arguments['filterType'] ==
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] !=
                                                          'All Sub-County') {
                                                    return productSellers![
                                                                    index]
                                                                .location !=
                                                            arguments[
                                                                'filterCounty']
                                                        ? const SizedBox
                                                            .shrink()
                                                        : SellerCard(
                                                            firstname: arguments[
                                                                'firstname'],
                                                            lastname: arguments[
                                                                'lastname'],
                                                            contact: arguments[
                                                                'contact'],
                                                            county: arguments[
                                                                'county'],
                                                            subcounty: arguments[
                                                                'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index],
                                                            customerAccount:
                                                                '${arguments['customerAccount']}',
                                                          );
                                                  }

                                                  ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                                  if (arguments['barTitle'] !=
                                                          'Product List' &&
                                                      arguments['filterType'] !=
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] ==
                                                          'All Sub-County' &&
                                                      arguments['sortKey'] ==
                                                          'Paper Seller, Cardboard, All Sub-County') {
                                                    return //productSellers[index].category !=arguments['filterTitle'] &&
                                                        productSellers[index]
                                                                    .categorytype !=
                                                                arguments[
                                                                    'filterType']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                  }

                                                  ///-----------------------------------//CASE : Your Products ,null ,null
                                                  if (arguments['barTitle'] ==
                                                          'Your Products' &&
                                                      arguments['filterType'] !=
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] !=
                                                          'All Sub-County' &&
                                                      arguments['sortKey'] ==
                                                          'hometosellerproductslist') {
                                                    return arguments[
                                                                'contact'] ==
                                                            productSellers![
                                                                    index]
                                                                .contact
                                                        ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                            product:
                                                                productSellers![
                                                                    index])
                                                        : const SizedBox
                                                            .shrink();
                                                  }

                                                  ///---------------------------------------- //CASE : Product List ,null ,null

                                                  if (arguments['barTitle'] ==
                                                          'Product List' &&
                                                      arguments['filterType'] !=
                                                          'All Categories Types' &&
                                                      arguments[
                                                              'filterCounty'] !=
                                                          'All Sub-County' &&
                                                      arguments['sortKey'] ==
                                                          'hometoallproductslist') {
                                                    return SellerCard(
                                                      firstname: arguments[
                                                          'firstname'],
                                                      lastname:
                                                          arguments['lastname'],
                                                      contact:
                                                          arguments['contact'],
                                                      county:
                                                          arguments['county'],
                                                      subcounty: arguments[
                                                          'subcounty'],
                                                      product: productSellers![
                                                          index],
                                                      customerAccount: arguments[
                                                          'customerAccount'],
                                                    );
                                                  }

                                                  return const SizedBox
                                                      .shrink(); // here by default width and height is 0
                                                },
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenWidth(
                                                          20)),
                                            ]);
                                      } else {
                                        return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Image.asset(
                                                    'assets/images/norecord.png',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      getProportionateScreenWidth(
                                                          100),
                                                ),
                                                const Text(
                                                  '\nNo record found',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ));
                                      }
                                    } else {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                            child: LinearProgressIndicator(
                                          backgroundColor: Color(0xFFB4B4B4),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.green),
                                        )),
                                      );
                                    }
                                  },
                                )
                              : arguments['county'] == 'Lamu'
                                  ? FutureBuilder<ListOfLamuProductSellers>(
                                      future: productSellersService
                                          .getLamuProductSellers(),
                                      builder: (context, snapshot) {
                                        List<Product>? productSellers =
                                            snapshot.data?.productSellers;

                                        if (snapshot.hasError) {
                                          return SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Image.asset(
                                                      'assets/images/error404.png',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            100),
                                                  ),
                                                  const Text(
                                                    '\nSomething went wrong\n\nMake sure you are having an\ninternet connection',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ));
                                        }
                                        if (snapshot.hasData) {
                                          //print(productSellers);
                                          if (productSellers!.isNotEmpty) {
                                            return Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                                                  ...List.generate(
                                                    productSellers!.length,
                                                    (index) {
                                                      // print(
                                                      //     '${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                                      // print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                                      //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometospecific') {
                                                        return productSellers![
                                                                        index]
                                                                    .category !=
                                                                arguments[
                                                                    'filterTitle']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                                      ///
                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County') {
                                                        //print('Okobo');
                                                        return SellerCard(
                                                          firstname: arguments[
                                                              'firstname'],
                                                          lastname: arguments[
                                                              'lastname'],
                                                          contact: arguments[
                                                              'contact'],
                                                          county: arguments[
                                                              'county'],
                                                          subcounty: arguments[
                                                              'subcounty'],
                                                          product:
                                                              productSellers![
                                                                  index],
                                                          customerAccount:
                                                              '${arguments['customerAccount']}',
                                                        );
                                                      }

                                                      ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County') {
                                                        //print('Okobo');
                                                        return productSellers![
                                                                        index]
                                                                    .category !=
                                                                arguments[
                                                                    'filterTitle']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                                      if (arguments[
                                                                  'barTitle'] !=
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'Paper Seller, Cardboard, All Sub-County') {
                                                        return //productSellers[index].category !=arguments['filterTitle'] &&
                                                            productSellers[index]
                                                                        .categorytype !=
                                                                    arguments[
                                                                        'filterType']
                                                                ? const SizedBox
                                                                    .shrink()
                                                                : SellerCard(
                                                                    firstname:
                                                                        arguments[
                                                                            'firstname'],
                                                                    lastname:
                                                                        arguments[
                                                                            'lastname'],
                                                                    contact:
                                                                        arguments[
                                                                            'contact'],
                                                                    county: arguments[
                                                                        'county'],
                                                                    subcounty:
                                                                        arguments[
                                                                            'subcounty'],
                                                                    product:
                                                                        productSellers![
                                                                            index],
                                                                    customerAccount:
                                                                        '${arguments['customerAccount']}',
                                                                  );
                                                      }

                                                      ///-----------------------------------//CASE : Your Products ,null ,null
                                                      if (arguments['barTitle'] == 'Your Products' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometosellerproductslist') {
                                                        return arguments[
                                                                    'contact'] ==
                                                                productSellers![
                                                                        index]
                                                                    .contact
                                                            ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index])
                                                            : const SizedBox
                                                                .shrink();
                                                      }

                                                      ///---------------------------------------- //CASE : Product List ,null ,null

                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometoallproductslist') {
                                                        return SellerCard(
                                                          firstname: arguments[
                                                              'firstname'],
                                                          lastname: arguments[
                                                              'lastname'],
                                                          contact: arguments[
                                                              'contact'],
                                                          county: arguments[
                                                              'county'],
                                                          subcounty: arguments[
                                                              'subcounty'],
                                                          product:
                                                              productSellers![
                                                                  index],
                                                          customerAccount:
                                                              arguments[
                                                                  'customerAccount'],
                                                        );
                                                      }

                                                      return const SizedBox
                                                          .shrink(); // here by default width and height is 0
                                                    },
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          getProportionateScreenWidth(
                                                              20)),
                                                ]);
                                          } else {
                                            return SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Image.asset(
                                                        'assets/images/norecord.png',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              100),
                                                    ),
                                                    const Text(
                                                      '\nNo record found',
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ));
                                          }
                                        } else {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Center(
                                                child: LinearProgressIndicator(
                                              backgroundColor:
                                                  Color(0xFFB4B4B4),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.green),
                                            )),
                                          );
                                        }
                                      },
                                    )
                                  : FutureBuilder<
                                      ListOfTaitaTavetaProductSellers>(
                                      future: productSellersService
                                          .getTaitaTavetaProductSellers(),
                                      builder: (context, snapshot) {
                                        List<Product>? productSellers =
                                            snapshot.data?.productSellers;

                                        if (snapshot.hasError) {
                                          return SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Image.asset(
                                                      'assets/images/error404.png',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            100),
                                                  ),
                                                  const Text(
                                                    '\nSomething went wrong\n\nMake sure you are having an\ninternet connection',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ));
                                        }
                                        if (snapshot.hasData) {
                                          if (productSellers!.isNotEmpty) {
                                            return Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  //...?productSellers?.map((product) {return Text(product.seller);}).toList(),
                                                  ...List.generate(
                                                    productSellers!.length,
                                                    (index) {
                                                      //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
                                                      //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');

                                                      //CASE : Paper Sellers ,All Categories Types ,All Sub-County
                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometospecific') {
                                                        return productSellers![
                                                                        index]
                                                                    .category !=
                                                                arguments[
                                                                    'filterTitle']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///----------------------------------------------//CASE : Rubber Sellers ,Tyre ,Kisauni
                                                      ///
                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///------------------------------------------//CASE : Product List ,All Categories Types ,All Sub-County

                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County') {
                                                        //print('Okobo');
                                                        return SellerCard(
                                                          firstname: arguments[
                                                              'firstname'],
                                                          lastname: arguments[
                                                              'lastname'],
                                                          contact: arguments[
                                                              'contact'],
                                                          county: arguments[
                                                              'county'],
                                                          subcounty: arguments[
                                                              'subcounty'],
                                                          product:
                                                              productSellers![
                                                                  index],
                                                          customerAccount:
                                                              '${arguments['customerAccount']}',
                                                        );
                                                      }

                                                      ///------------------------------------------//CASE : Plastics Sellers ,All Categories Types ,All Sub-County

                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County') {
                                                        //print('Okobo');
                                                        return productSellers![
                                                                        index]
                                                                    .category !=
                                                                arguments[
                                                                    'filterTitle']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///---------------------------------------//CASE : Product List ,All Categories Types ,Changamwe
                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///---------------------------------------//CASE : Plastics Sellers ,All Categories Types ,Changamwe
                                                      if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers' &&
                                                          arguments[
                                                                  'filterType'] ==
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County') {
                                                        return productSellers![
                                                                        index]
                                                                    .location !=
                                                                arguments[
                                                                    'filterCounty']
                                                            ? const SizedBox
                                                                .shrink()
                                                            : SellerCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index],
                                                                customerAccount:
                                                                    '${arguments['customerAccount']}',
                                                              );
                                                      }

                                                      ///-------------------------------------//Paper Sellers ,Cardboard ,All Sub-County
                                                      if (arguments[
                                                                  'barTitle'] !=
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] ==
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'Paper Seller, Cardboard, All Sub-County') {
                                                        return //productSellers[index].category !=arguments['filterTitle'] &&
                                                            productSellers[index]
                                                                        .categorytype !=
                                                                    arguments[
                                                                        'filterType']
                                                                ? const SizedBox
                                                                    .shrink()
                                                                : SellerCard(
                                                                    firstname:
                                                                        arguments[
                                                                            'firstname'],
                                                                    lastname:
                                                                        arguments[
                                                                            'lastname'],
                                                                    contact:
                                                                        arguments[
                                                                            'contact'],
                                                                    county: arguments[
                                                                        'county'],
                                                                    subcounty:
                                                                        arguments[
                                                                            'subcounty'],
                                                                    product:
                                                                        productSellers![
                                                                            index],
                                                                    customerAccount:
                                                                        '${arguments['customerAccount']}',
                                                                  );
                                                      }

                                                      ///-----------------------------------//CASE : Your Products ,null ,null
                                                      if (arguments['barTitle'] == 'Your Products' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometosellerproductslist') {
                                                        return arguments[
                                                                    'contact'] ==
                                                                productSellers![
                                                                        index]
                                                                    .contact
                                                            ? SellerProductCard(
                                                                firstname:
                                                                    arguments[
                                                                        'firstname'],
                                                                lastname: arguments[
                                                                    'lastname'],
                                                                contact: arguments[
                                                                    'contact'],
                                                                county: arguments[
                                                                    'county'],
                                                                subcounty:
                                                                    arguments[
                                                                        'subcounty'],
                                                                product:
                                                                    productSellers![
                                                                        index]
                                                              )
                                                            : const SizedBox
                                                                .shrink();
                                                      }

                                                      ///---------------------------------------- //CASE : Product List ,null ,null

                                                      if (arguments[
                                                                  'barTitle'] ==
                                                              'Product List' &&
                                                          arguments[
                                                                  'filterType'] !=
                                                              'All Categories Types' &&
                                                          arguments[
                                                                  'filterCounty'] !=
                                                              'All Sub-County' &&
                                                          arguments[
                                                                  'sortKey'] ==
                                                              'hometoallproductslist') {
                                                        return SellerCard(
                                                          firstname: arguments[
                                                              'firstname'],
                                                          lastname: arguments[
                                                              'lastname'],
                                                          contact: arguments[
                                                              'contact'],
                                                          county: arguments[
                                                              'county'],
                                                          subcounty: arguments[
                                                              'subcounty'],
                                                          product:
                                                              productSellers![
                                                                  index],
                                                          customerAccount:
                                                              arguments[
                                                                  'customerAccount'],
                                                        );
                                                      }

                                                      return const SizedBox
                                                          .shrink(); // here by default width and height is 0
                                                    },
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          getProportionateScreenWidth(
                                                              20)),
                                                ]);
                                          } else {
                                            return SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Image.asset(
                                                        'assets/images/norecord.png',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              100),
                                                    ),
                                                    const Text(
                                                      '\nNo record found',
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ));
                                          }
                                        } else {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Center(
                                                child: LinearProgressIndicator(
                                              backgroundColor:
                                                  Color(0xFFB4B4B4),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.green),
                                            )),
                                          );
                                        }
                                      },
                                    ),
            )
          ],
        ),
      ),
    );
  }
}

// // child: Column(
// // children: [
// // ...List.generate(
// // productSellers!.length,
// // (index) {
// // //print(productSellers[index].title);
// // return Text(productSellers[index].title);
// // return const SizedBox
// //     .shrink(); // here by default width and height is 0
// // },
// // ),
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// // // ...List.generate(
// // //   productSellers!.length,
// // //   (index) {
// // //     //print('${arguments['barTitle']} ,${arguments['filterType']} ,${arguments['filterCounty']}');
// // //     //print('${arguments['barTitle']},${arguments['filterType']},${arguments['filterCounty']},${arguments['filterCounty']},${demoCategories[_iterateSellers].subcounty},$_iterateSellers');
// // //
// // //     //CASE : Paper Sellers ,All Categories Types ,All Sub-County
// // //     if (arguments['barTitle'] == '${arguments['filterTitle']} Sellers') {
// // //       return productSellers[index].title !=
// // //               arguments['filterTitle']
// // //           ? const SizedBox.shrink()
// // //           : SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     //CASE : Product List ,All Categories Types ,All Sub-County
// // //     if (arguments['barTitle'] == 'Product List' &&
// // //         arguments['filterType'] == 'All Categories Types' &&
// // //         arguments['filterCounty'] == 'All Sub-County') {
// // //       return SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     //CASE : Product List ,All Categories Types ,Changamwe
// // //     if (arguments['barTitle'] == 'Product List' &&
// // //         arguments['filterType'] == 'All Categories Types' &&
// // //         arguments['filterCounty'] != 'All Sub-County') {
// // //       return productSellers[index].subcounty !=
// // //               arguments['filterCounty']
// // //           ? const SizedBox.shrink()
// // //           : SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     //Paper Sellers ,Cardboard ,All Sub-County
// // //     if (arguments['barTitle'] != 'Product List' &&
// // //         arguments['filterType'] != 'All Categories Types' &&
// // //         arguments['filterCounty'] == 'All Sub-County') {
// // //       return productSellers[index].title !=
// // //                   arguments['filterTitle'] &&
// // //               productSellers[index].materialType !=
// // //                   arguments['filterType']
// // //           ? const SizedBox.shrink()
// // //           : SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     //CASE : Your Products ,null ,null
// // //     if (arguments['barTitle'] == 'Your Products' &&
// // //         arguments['filterType'] != 'All Categories Types' &&
// // //         arguments['filterCounty'] != 'All Sub-County') {
// // //       return SellerProductCard(
//                                                                 firstname:
//                                                                     arguments[
//                                                                         'firstname'],
//                                                                 lastname: arguments[
//                                                                     'lastname'],
//                                                                 contact: arguments[
//                                                                     'contact'],
//                                                                 county: arguments[
//                                                                     'county'],
//                                                                 subcounty:
//                                                                     arguments[
//                                                                         'subcounty'],product: productSellers[index], customerAccount: arguments['customerAccount'],);
// // // //     }
// // //
// // //     //CASE : Rubber Sellers ,Tyre ,Kisauni
// // //     if (arguments['barTitle'] != 'Product List' &&
// // //         arguments['filterType'] != 'All Categories Types' &&
// // //         arguments['filterCounty'] != 'All Sub-County') {
// // //       return productSellers[index].title !=
// // //                   arguments['filterTitle'] &&
// // //               productSellers[index].materialType !=
// // //                   arguments['filterType'] &&
// // //               productSellers[index].subcounty !=
// // //                   arguments['filterCounty']
// // //           ? const SizedBox.shrink()
// // //           : SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     //CASE : Product List ,null ,null
// // //     if (arguments['barTitle'] == 'Product List' &&
// // //         arguments['filterType'] != 'All Categories Types' &&
// // //         arguments['filterCounty'] != 'All Sub-County') {
// // //       return SellerCard(
// firstname: arguments['
// firstname
// '
// ]
// ,
// lastname: arguments['
// lastname
// '
// ]
// ,
// contact: arguments['
// contact
// '
// ]
// ,
// county: arguments['
// county
// '
// ]
// ,
// subcounty: arguments['
// subcounty
// '
// ]
// ,
// product: productSellers![
// index],
// customerAccount: arguments['
// customerAccount
// '
// ]
// ,
// );
// // //     }
// // //
// // //     return const SizedBox
// // //         .shrink(); // here by default width and height is 0
// // //   },
// // // ),
// // SizedBox(height: getProportionateScreenWidth(20)),
// // ],
// // ),
