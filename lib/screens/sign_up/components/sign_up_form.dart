import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String selectedValue1 = "Select Acount Type";
  String selectedValue2 = "Select Your County";
  String selectedValue3 = "Select Your Sub-County";
  String selectedValue4 = "Select Your Gender";

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Acount Type", child: Text("Select Acount Type")),
      const DropdownMenuItem(value: "Seller", child: Text("Seller")),
      const DropdownMenuItem(value: "Buyer", child: Text("Buyer")),
      const DropdownMenuItem(value: "Recycler", child: Text("Recycler")),
    ];
    return menuItems;
  }


  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your County", child: Text("Select Your County")),
      const DropdownMenuItem(
          value: "Taita Taveta", child: Text("Taita Taveta")),
      const DropdownMenuItem(value: "Tana River", child: Text("Tana River")),
      const DropdownMenuItem(value: "Mombasa", child: Text("Mombasa")),
      const DropdownMenuItem(value: "Kwale", child: Text("Kwale")),
      const DropdownMenuItem(value: "Kilifi", child: Text("Kilifi")),
      const DropdownMenuItem(value: "Lamu", child: Text("Lamu")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(
          value: "All Sub-County", child: Text("All Sub-County")),
      const DropdownMenuItem(value: "Changamwe", child: Text("Changamwe")),
      const DropdownMenuItem(value: "Kisauni", child: Text("Kisauni")),
      const DropdownMenuItem(value: "Likoni", child: Text("Likoni")),
      const DropdownMenuItem(value: "Jomvu", child: Text("Jomvu")),
      const DropdownMenuItem(value: "Mvita", child: Text("Mvita")),
      const DropdownMenuItem(value: "Nyali", child: Text("Nyali")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Gender", child: Text("Select Your Gender")),
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }


  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownKilifi {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(
          value: "Kilifi North", child: Text("Kilifi North")),
      const DropdownMenuItem(
          value: "Kilifi South", child: Text("Kilifi South")),
      const DropdownMenuItem(value: "Magarini", child: Text("Magarini")),
      const DropdownMenuItem(value: "Kaloleni", child: Text("Kaloleni")),
      const DropdownMenuItem(value: "Malindi", child: Text("Malindi")),
      const DropdownMenuItem(value: "Ganze", child: Text("Ganze")),
      const DropdownMenuItem(value: "Rabai", child: Text("Rabai")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownKwale {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(value: "Lunga Lunga", child: Text("Lunga Lunga")),
      const DropdownMenuItem(value: "Msambweni", child: Text("Msambweni")),
      const DropdownMenuItem(value: "Kinango", child: Text("Kinango")),
      const DropdownMenuItem(value: "Matunga", child: Text("Matunga")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownTanaRiver {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(value: "Garsen", child: Text("Garsen")),
      const DropdownMenuItem(value: "Galole", child: Text("Galole")),
      const DropdownMenuItem(value: "Bura", child: Text("Bura")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownTaitaTaveta {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(value: "Wundanyi", child: Text("Wundanyi")),
      const DropdownMenuItem(value: "Mwatate", child: Text("Mwatate")),
      const DropdownMenuItem(value: "Taveta", child: Text("Taveta")),
      const DropdownMenuItem(value: "Voi", child: Text("Voi")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownMombasa {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(value: "Changamwe", child: Text("Changamwe")),
      const DropdownMenuItem(value: "Kisauni", child: Text("Kisauni")),
      const DropdownMenuItem(value: "Likoni", child: Text("Likoni")),
      const DropdownMenuItem(value: "Jomvu", child: Text("Jomvu")),
      const DropdownMenuItem(value: "Mvita", child: Text("Mvita")),
      const DropdownMenuItem(value: "Nyali", child: Text("Nyali")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownLamu {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
      const DropdownMenuItem(value: "Lamu East", child: Text("Lamu East")),
      const DropdownMenuItem(value: "Lamu West", child: Text("Lamu West")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownNull2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Your Sub-County",
          child: Text("Select Your Sub-County")),
    ];
    return menuItems;
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              validator: (value) =>
                  value == "Select Acount Type" ? "Must be selected" : null,
              //dropdownColor: Colors.blueAccent,
              value: selectedValue1,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue1 = newValue!;
                });
              },
              items: dropdownItems1),
          const SizedBox(
            height: 30,
          ),

          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            validator: (value) =>
                value == "Select Your County" ? "Must be selected" : null,
            //dropdownColor: Colors.blueAccent,
            value: selectedValue2,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue2 = newValue!;
                selectedValue3 = "Select Your Sub-County";
              });
            },
            items: dropdownItems2,
          ),
          const SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              validator: (value) => value == "Select Your Sub-County"
                  ? "Must be selected"
                  : null,
              //dropdownColor: Colors.blueAccent,
              value: selectedValue3,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue3 = newValue!;
                });
              },
              items: selectedValue2 == 'Kilifi'
                  ? dropdownKilifi
                  : selectedValue2 == 'Kwale'
                      ? dropdownKwale
                      : selectedValue2 == 'Mombasa'
                          ? dropdownMombasa
                          : selectedValue2 == 'Lamu'
                              ? dropdownLamu
                              : selectedValue2 == 'Tana River'
                                  ? dropdownTanaRiver
                                  : selectedValue2 == 'Taita Taveta'
                                      ? dropdownTaitaTaveta
                                      : dropdownNull2),
          const SizedBox(
            height: 30,
          ),
          DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: Color(0xFFC4DFB4), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
              validator: (value) =>
              value == "Select Your Gender" ? "Must be selected" : null,
              //dropdownColor: Colors.blueAccent,
              value: selectedValue4,
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue4 = newValue!;
                });
              },
              items: dropdownItems4),
          const SizedBox(
            height: 30,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(
                  context,
                  CompleteProfileScreen.routeName,
                  arguments: {
                    'accounttype': selectedValue1,
                    'county': selectedValue2,
                    'subcounty': selectedValue3,
                    'gender': selectedValue4,
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

}
