import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class SearchField extends StatefulWidget {
  final String firstname;
  final String accounttype;
  const SearchField({Key? key, required this.firstname, required this.accounttype}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      // decoration: BoxDecoration(
      //   color: kSecondaryColor.withOpacity(0.1),
      //   borderRadius: BorderRadius.circular(15),
      // ),

      // child: TextField(
      //   onChanged: (value) => print(value),
      //   decoration: InputDecoration(
      //       contentPadding: EdgeInsets.symmetric(
      //           horizontal: getProportionateScreenWidth(20),
      //           vertical: getProportionateScreenWidth(9)),
      //       border: InputBorder.none,
      //       focusedBorder: InputBorder.none,
      //       enabledBorder: InputBorder.none,
      //       hintText: "Search product",
      //       prefixIcon: const Icon(Icons.search)),
      // ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SearchField(),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Cart Icon.svg",
          //   press: () => Navigator.pushNamed(context, CartScreen.routeName),
          // ),

          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Menu.svg",
          //   //numOfitem: 3,
          //   press: () {},          // ),
          Image.asset(
            "assets/images/appLogo.png",
            //"assets/images/success.png",
            height: SizeConfig.screenHeight * 0.1, //40%
          ),
          const SizedBox(width: 10),
          Text('Welcome Back,\n${widget.firstname}',
              maxLines: 2, textAlign: TextAlign.start)
        ],
      ),
    );
  }
}
