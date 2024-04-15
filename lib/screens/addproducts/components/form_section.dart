
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:tkconnect/components/default_button.dart';
import 'package:tkconnect/main.dart';
import 'package:tkconnect/utils/http_strings.dart';
import 'package:tkconnect/utils/size_config.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class AddProductForm extends StatefulWidget {
  final String firstname;
  final String accounttype;
  final String lastname;
  final String county;
  final String subcounty;
  final String contact;

  const AddProductForm({
    Key? key,
    required this.firstname,
    required this.accounttype,
    required this.lastname,
    required this.county,
    required this.subcounty,
    required this.contact,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _dropdownFormKey = GlobalKey<FormState>();
  int simpleIntInput = 0;

  String selectedValue1 = "Select Category";
  String selectedValue2 = "Select Category Type";
  String selectedValue3 = "Select Product Color";

  String sellerName = "Chrispine Odhiambo";
  String sellerContact = "0702407935";
  String sellerLocation = "Bamburi";
  String county = "Mombasa";

  int productQuantity = 0;
  TextEditingController controllercolor = TextEditingController();
  TextEditingController controllerdescription = TextEditingController();

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category", child: Text("Select Category")),
      const DropdownMenuItem(
          value: "All Categories", child: Text("All Categories")),
      const DropdownMenuItem(value: "Plastics", child: Text("Plastics")),
      const DropdownMenuItem(value: "Rubber", child: Text("Rubber")),
      const DropdownMenuItem(value: "Organics", child: Text("Organics")),
      const DropdownMenuItem(value: "Paper", child: Text("Paper")),
      const DropdownMenuItem(value: "Glass", child: Text("Glass")),
      const DropdownMenuItem(value: "Metal", child: Text("Metal")),
      const DropdownMenuItem(value: "Clothes", child: Text("Clothes")),
      const DropdownMenuItem(value: "E_waste", child: Text("E_waste")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "FP", child: Text("Food Product (FP)")),
      const DropdownMenuItem(
          value: "HP", child: Text("Household Product (HP)")),
      const DropdownMenuItem(value: "0", child: Text("Others (O)")),
      const DropdownMenuItem(value: "PC", child: Text("Personal Care (PC)")),
      const DropdownMenuItem(value: "SM", child: Text("Smoking Material (SM)")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownNull {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(
          value: "All Categories Types", child: Text("All Categories Types")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownClothes {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(
          value: "None synthetic (Cotton/Wool)",
          child: Text("None synthetic (Cotton/Wool)")),
      const DropdownMenuItem(value: "Synthetic", child: Text("Synthetic")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownEWaste {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(
          value: "Car Batteries", child: Text("Car Batteries")),
      const DropdownMenuItem(
          value: "Cooling Equipment", child: Text("Cooling Equipment")),
      const DropdownMenuItem(
          value: "Telecom Equipment", child: Text("Telecom Equipment")),
      const DropdownMenuItem(
          value: "Consumer Equipment", child: Text("Consumer Equipment")),
      const DropdownMenuItem(value: "Screens", child: Text("Screens")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownGlass {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(
          value: "Broken Glass", child: Text("Broken Glass")),
      const DropdownMenuItem(
          value: "Drinking Bottle", child: Text("Drinking Bottle")),
      const DropdownMenuItem(
          value: "Glassware/Jars", child: Text("Glassware/Jars")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownMetal {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "Heavy", child: Text("Heavy")),
      const DropdownMenuItem(value: "Light", child: Text("Light")),
      const DropdownMenuItem(value: "Medium", child: Text("Medium")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownOrganics {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "Bones", child: Text("Bones")),
      const DropdownMenuItem(
          value: "Coconut Husks", child: Text("Coconut Husks")),
      const DropdownMenuItem(
          value: "Kitchen Remains", child: Text("Kitchen Remains")),
      const DropdownMenuItem(value: "Saw Dust", child: Text("Saw Dust")),
      const DropdownMenuItem(value: "Manure", child: Text("Manure")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownPaper {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "Cardboard", child: Text("Cardboard")),
      const DropdownMenuItem(
          value: "Magazine/Newspaper", child: Text("Magazine/Newspaper")),
      const DropdownMenuItem(
          value: "Office Paper", child: Text("Office Paper")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownPlastic {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "HDPE", child: Text("HDPE")),
      const DropdownMenuItem(value: "LDPE", child: Text("LDPE")),
      const DropdownMenuItem(value: "PET", child: Text("PET")),
      const DropdownMenuItem(value: "PP", child: Text("PP")),
      const DropdownMenuItem(value: "PS", child: Text("PS")),
      const DropdownMenuItem(value: "PVC", child: Text("PVC")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownRubber {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category Type", child: Text("Select Category Type")),
      const DropdownMenuItem(value: "Flip-Flop", child: Text("Flip-Flop")),
      const DropdownMenuItem(value: "Shoes/Soles", child: Text("Shoes/Soles")),
      const DropdownMenuItem(value: "Tyre", child: Text("Tyre")),
    ];
    return menuItems;
  }

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Product Color", child: Text("Select Product Color")),
      const DropdownMenuItem(
          value: "All Sub-County", child: Text("All Sub-County")),
      const DropdownMenuItem(value: "Violet", child: Text("Violet")),
      const DropdownMenuItem(value: "Indigo", child: Text("Indigo")),
      const DropdownMenuItem(value: "Blue", child: Text("Blue")),
      const DropdownMenuItem(value: "Green", child: Text("Green")),
      const DropdownMenuItem(value: "Yellow", child: Text("Yellow")),
      const DropdownMenuItem(value: "Orange", child: Text("Orange")),
      const DropdownMenuItem(value: "Red", child: Text("Red")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownNull2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Product Color", child: Text("Select Product Color")),
    ];
    return menuItems;
  }

  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(
        source: media, maxWidth: 300.0, maxHeight: 300.0);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //SAVE PRODUCT
  // use this to send your image
  Future<void> uploadImage(token, seller, quantity, contact, category,
      categorytype, color, description, county, location) async {
    // print(seller);
    // print(description);
    // your token if needed

    var path;

    if (county == 'Mombasa') {
      path = createmombasaproductsellerUrl;
    }
    if (county == 'Lamu') {
      path = createlamuproductsellerUrl;
    }
    if (county == 'Kwale') {
      path = createkwaleproductsellerUrl;
    }
    if (county == 'Kilifi') {
      path = createkilifiproductsellerUrl;
    }
    if (county == 'Tana River') {
      path = createtanariverproductsellerUrl;
    }
    if (county == 'Taita Taveta') {
      path = createtaitatavetaproductsellerUrl;
    }

    try {
      var headers = {
        // 'Authorization': 'Bearer ' + "token",
        'Authorization': ' Token $token',
      };
      // your endpoint and request method
      var request = http.MultipartRequest('POST', Uri.parse(path));

      request.fields.addAll({
        'seller': '$seller'.toTitleCase(),
        'contact': '$contact',
        'quantity': '$quantity',
        'category': '$category',
        'categorytype': '$categorytype',
        'color': '$color'.toTitleCase(),
        'location': '$location'.toTitleCase(),
        'description': '$description',
        'county': '$county'.toTitleCase(),
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image', image!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: const Text('Added Successfully'),
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
        //Navigator.pop(context);
      } else {
        final snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: const Text('Request Unsuccessfully'),
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

    } catch (e) {
      print(e);
    }
  }

  bool addProduct = true;

  @override
  Widget build(BuildContext context) {
    print('${widget.firstname} ${widget.lastname}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _dropdownFormKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) => value == "Select Category"
                            ? "Select Category"
                            : null,
                        //dropdownColor: Colors.blueAccent,
                        value: selectedValue1,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue1 = newValue!;
                            selectedValue2 = "Select Category Type";
                          });
                        },
                        items: dropdownItems1),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) => value == "Select Category Type"
                            ? "Select Category Type"
                            : null,
                        //dropdownColor: Colors.blueAccent,
                        value: selectedValue2,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue2 = newValue!;
                          });
                        },
                        items: selectedValue1 == 'Plastics'
                            ? dropdownPlastic
                            : selectedValue1 == 'Rubber'
                                ? dropdownRubber
                                : selectedValue1 == 'Organics'
                                    ? dropdownOrganics
                                    : selectedValue1 == 'Paper'
                                        ? dropdownPaper
                                        : selectedValue1 == 'Glass'
                                            ? dropdownGlass
                                            : selectedValue1 == 'Metal'
                                                ? dropdownMetal
                                                : selectedValue1 == 'E_waste'
                                                    ? dropdownEWaste
                                                    : selectedValue1 ==
                                                            'Clothes'
                                                        ? dropdownClothes
                                                        : dropdownNull),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Quantity (QTY) in Kgs',
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(70),
                      width: double.infinity,
                      child: InputQty(
                        //color of the increase and decrease icon
                        maxVal: double.maxFinite,
                        //max val to go
                        initVal: 0,
                        decoration: QtyDecorationProps(
                          btnColor: Colors.green,
                          //contentPadding: EdgeInsets.all(18.0),
                          //border: InputBorder.none
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          width: 30,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Required field";
                          } else if (value <= 0) {
                            return "Quantity can not be less than 0";
                          }
                          return null;
                        },
                        //min starting val
                        onQtyChanged: (val) {
                          //on value changed we may set the value
                          //setstate could be called
                          setState(() {
                            productQuantity = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(40.0),
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFC4DFB4), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) => value == "Select Product Color"
                            ? "Select Product Color"
                            : null,
                        //dropdownColor: Colors.blueAccent,
                        value: selectedValue3,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue3 = newValue!;
                          });
                        },
                        items: dropdownItems3),
                    SizedBox(
                      height: getProportionateScreenWidth(40.0),
                    ),
                    TextFormField(
                      controller: controllerdescription,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        hintText: 'e.g Rusted building metal rod...',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_note,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Product Description";
                        }
                        return null;
                        // else {
                        //   if (value.length < 0 || value.length > 10) {
                        //     return "Total Counts can't be 0 or Less than 0";
                        //   } else {
                        //     return null;
                        //   }
                        // }
                      },
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          //if image not null show the image
                          //if image null show text
                          image != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      //to show image, you type like this.
                                      File(image!.path),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "No Image Uploaded",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.redAccent),
                                ),

                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: getProportionateScreenWidth(40.0),
                            child: ElevatedButton(
                              onPressed: () {
                                myAlert();
                              },
                              child: const Text('Upload/Take Photo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenWidth(30),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                  //vertical: 10,
                ),
                child: addProduct == true
                    ? DefaultButton(
                        text: "Add Product",
                        press: () {
                          setState(() {
                            addProduct = false;
                          });

                          Future.delayed(const Duration(seconds: 2), () {
                            //asynchronous delay
                            if (mounted) {
                              //checks if widget is still active and not disposed
                              setState(() {
                                //tells the widget builder to rebuild again because ui has updated
                                addProduct =
                                    true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                              });
                            }
                          });

                          uploadImage(
                              auth_token,
                              '${widget.firstname} ${widget.lastname}',
                              productQuantity,
                              widget.contact,
                              selectedValue1,
                              selectedValue2,
                              selectedValue3,
                              controllerdescription.text,
                              widget.county,
                              widget.subcounty);
                        },
                      )
                    : Column(
                        children: [
                          const Text('Saving...'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Center(
                                child: LinearProgressIndicator(
                              backgroundColor: Color(0xFFB4B4B4),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            )),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
