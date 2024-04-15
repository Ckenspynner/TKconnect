import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tkconnect/screens/contactus/contactus.dart';
import 'package:tkconnect/screens/home/components/popular_product.dart';
import 'package:tkconnect/screens/home/components/special_offers.dart';
import 'package:tkconnect/screens/partners/partners.dart';

import '../../../components/default_button.dart';
import '../../../utils/size_config.dart';
import '../../pilots/pilots.dart';

import 'package:http/http.dart' as http;
import 'package:tkconnect/utils/http_strings.dart';

class Categories extends StatefulWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;

  const Categories({
    Key? key,
    required this.accounttype,
    required this.firstname,
    required this.lastname,
    required this.county,
    required this.subcounty,
    required this.contact,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool sellerProfile = false;
  bool buyerProfile = false;
  String Account = '';

  String selectedValue = "Select Waste Player";
  final _dropdownFormKey = GlobalKey<FormState>();

  TextEditingController CredentialsController = TextEditingController();
  TextEditingController lengthCredentialsController = TextEditingController();
  TextEditingController lengthdryController = TextEditingController();

  List dropdownItems = [];

  Future getAllCategory() async {
    http.Response response = await http.get(Uri.parse(credUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dropdownItems = jsonData;
      });
    }
  }

  var dropdownvalue;
  bool toggleAuth = true;

  Future  verifyaccount(credential, company) async {
    var response = await http.get(Uri.parse(credUrl));
    //print(jsonDecode(response.body));
    var verify = jsonDecode(response.body);
    verify.forEach((element) {

      if (element["credential"].contains(credential) && element["company"].contains(company)) {
        Navigator.pushNamed(
          context,
          PilotsScreen.routeName,
          arguments: {
            'company': company,
            'collector': '${widget.firstname} ${widget.lastname}'
          },
        );

        CredentialsController.clear();

        setState(() {
          selectedValue = 'Select Waste Player';
        });

        setState(() {
          toggleAuth = true;
        });
      }else{
        setState(() {
          toggleAuth = false;
        });

      }
    });
  }

  void _show(BuildContext context) {
    getAllCategory();
    bool _passwordVisible = false;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          return Padding(
                padding: EdgeInsets.only(
                    top: 25,
                    left: 25,
                    right: 25,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                      key: _dropdownFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Center(
                              //child: toggleAuth==true?const Text(
                              child: Text(
                            'Authenticate',
                            style: TextStyle(
                                //color: Colors.white,
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.bold,
                                //fontStyle: FontStyle.italic,
                                fontSize: 20.0),
                          )
                              //   :const Text(
                              //   'Invalid',
                              //   style: TextStyle(
                              //       color: Colors.redAccent,
                              //       fontFamily: 'ProximaNova',
                              //       fontWeight: FontWeight.bold,
                              //       //fontStyle: FontStyle.italic,
                              //       fontSize: 20.0),
                              // )
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButtonFormField(
                            hint: const Text('Select Waste Player'),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              validator: (value) => value == "Select Waste Player"
                                  ? "Select a Waste Player"
                                  : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              // items: dropdownItems
                            items: dropdownItems.map((item) {
                              return DropdownMenuItem(
                                value: item['company'].toString(),
                                child: Text(item['company'].toString()),
                              );
          
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: CredentialsController,
                            obscureText: !_passwordVisible,
                            //readOnly: true,
                            keyboardType: TextInputType.text,
                            validator: (value) => value!.isEmpty
                                ? 'Credentials cannot be blank'
                                : null,
                            decoration: InputDecoration(
                              //labelText: 'Credentials',
                              hintText: 'Enter your Credentials',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible=!_passwordVisible;
                                  });
                                  },
                                icon: _passwordVisible==false?const Icon(
                                  Icons.visibility_off,):const Icon(
                                Icons.visibility,),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultButton(
                                  text: "Submit",
                                  press: () {
                                    if (_dropdownFormKey.currentState!
                                        .validate()) {
                                      verifyaccount(CredentialsController.text,
                                          selectedValue);

                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )),
                ),
              );}
        ));
  }


  @override
  void initState() {
    // TODO: implement initState
    widget.accounttype == 'Seller'
        ? sellerProfile = true
        : sellerProfile = false;
    widget.accounttype == 'Buyer' || widget.accounttype == 'Recycler'
        ? buyerProfile = true
        : buyerProfile = false;
    Account = widget.accounttype;

    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // {"icon": "assets/icons/Flash Icon.svg", "text": "Seller"},
      // {"icon": "assets/icons/Bill Icon.svg", "text": "Buyer"},
      // {"icon": "assets/icons/Game Icon.svg", "text": "Recycler"},
      // {"icon": "assets/icons/Gift Icon.svg", "text": "Partners"},
      // {"icon": "assets/icons/Discover.svg", "text": "Help"},

      {"icon": "assets/icons/seller.svg", "text": "Seller"},
      {"icon": "assets/icons/buyer.svg", "text": "Buyer"},
      {"icon": "assets/icons/recycle.svg", "text": "Recycler"},
      {"icon": "assets/icons/pilot1.svg", "text": "Pilots"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Partners"},
      {"icon": "assets/icons/help.svg", "text": "Help"},
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (index) => CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {
                    // print(categories[index]["text"]);
                    setState(() {
                      switch (categories[index]["text"]) {
                        case 'Seller':
                          sellerProfile = true;
                          buyerProfile = false;
                          Account = 'Seller';
                        case 'Buyer':
                          sellerProfile = false;
                          buyerProfile = true;
                          Account = 'Buyer';
                        case 'Recycler':
                          sellerProfile = false;
                          buyerProfile = true;
                          Account = 'Recycler';
                        case 'Partners':
                          Navigator.pushNamed(context, PartnerScreen.routeName);
                        case 'Help':
                          Navigator.pushNamed(context, ContactScreen.routeName);
                        case 'Pilots':
                          //Navigator.pushNamed(context, PilotsScreen.routeName);
                          _show(context);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: sellerProfile,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            opacity: sellerProfile ? 1 : 0,
            child: SpecialOffers(
              firstname: widget.firstname,
              lastname: widget.lastname,
              contact: widget.contact,
              county: widget.county,
              subcounty: widget.subcounty,
              accounttype: widget.accounttype,
            ),
          ),
        ),
        Visibility(
            visible: buyerProfile,
            maintainAnimation: true,
            maintainState: true,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                opacity: buyerProfile ? 1 : 0,
                child: PopularProducts(
                  customerAccount: Account,
                  firstname: widget.firstname,
                  lastname: widget.lastname,
                  contact: widget.contact,
                  county: widget.county,
                  subcounty: widget.subcounty,
                  accounttype: widget.accounttype,
                ))),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(110),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(30)),
              height: getProportionateScreenWidth(100),
              width: getProportionateScreenWidth(100),
              decoration: BoxDecoration(
                //color: Color(0xFFFFECDF),
                color: const Color(0xFFC4DFB4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.5 * ffem / fem,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard1 extends StatelessWidget {
  const CategoryCard1({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                //color: Color(0xFFFFECDF),
                color: const Color(0xFFC4DFB4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: 12 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.5 * ffem / fem,
              ),
            )
          ],
        ),
      ),
    );
  }
}
