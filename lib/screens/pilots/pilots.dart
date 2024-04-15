
import 'package:flutter/material.dart';
import 'package:tkconnect/main.dart';
import 'package:tkconnect/screens/pilots/pilotstats.dart';
import 'package:http/http.dart' as http;
import '../../components/default_button.dart';
import '../../utils/http_strings.dart';

class PilotsScreen extends StatefulWidget {
  const PilotsScreen({Key? key}) : super(key: key);
  static String routeName = "/pilots";

  @override
  State<PilotsScreen> createState() => _PilotsScreenState();
}

class _PilotsScreenState extends State<PilotsScreen> {
  String selectedValue = "Select Week";

  TextEditingController recyclableController = TextEditingController();
  TextEditingController organicController = TextEditingController();
  TextEditingController landfillController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Select Week", child: Text("Select Week")),
      const DropdownMenuItem(value: "Week 1", child: Text("Week 1")),
      const DropdownMenuItem(value: "Week 2", child: Text("Week 2")),
      const DropdownMenuItem(value: "Week 3", child: Text("Week 3")),
      const DropdownMenuItem(value: "Week 4", child: Text("Week 4")),
      const DropdownMenuItem(value: "Week 5", child: Text("Week 5")),
      const DropdownMenuItem(value: "Week 6", child: Text("Week 6")),
      const DropdownMenuItem(value: "Week 7", child: Text("Week 7")),
      const DropdownMenuItem(value: "Week 8", child: Text("Week 8")),
    ];
    return menuItems;
  }

  final _dropdownFormKey = GlobalKey<FormState>();

  Future<void> submitData(
      company, collector, week, recyclable, organic, landfill) async {
    var response = await http.post(Uri.parse(createpilotUrl), body: {
      'company': company,
      'collector': collector,
      'week': week,
      'recyclable': recyclable,
      'organic': organic,
      'landfill': landfill,
    });

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Submitted Successfully'),
        action: SnackBarAction(
          textColor: Colors.white,
          label: '',
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
        content: const Text('Submission was unsuccessfully'),
        action: SnackBarAction(
          textColor: Colors.white,
          label: '',
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Warning'),
        content: const Text(
            'Are you sure you want to leave this page all unsaved entries will be lost.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                "This string will be passed back to the parent",
              );
              Navigator.pop(context, 'Yes');
            },
            //Navigator.pop(context, 'Yes'),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              // onTap: () {
              //   Navigator.pop(context);
              // },
              onTap:  () => showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Warning'),
                      content: const Text(
                          'Are you sure you want to leave this page all unsaved entries will be lost.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              "This string will be passed back to the parent",
                            );
                            Navigator.pop(context, 'Yes');
                          },
                          //Navigator.pop(context, 'Yes'),
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
              ),
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
                    Navigator.pushNamed(context, PilotStatScreen.routeName,arguments: {
                      'company': arguments['company'],
                    },);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 25),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  )),
            ],
            // title: Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 50,
            //   ),
            //   child: const Text(
            //     'Submission form',
            //   ),
            // ),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
          body: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Form(
                    key: _dropdownFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset(
                            'assets/images/appLogo.png',
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                        Text(
                          arguments['company'],
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold,
                            //color: Colors.black,
                          ),
                        ),
                        const Text('Data submission form'),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            validator: (value) =>
                                value == "Select Week" ? "Select a Week" : null,
                            //dropdownColor: Colors.blueAccent,
                            value: selectedValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: dropdownItems),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: recyclableController,
                          //obscureText: true,
                          //readOnly: true,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? 'Weight cannot be blank' : null,
                          decoration: InputDecoration(
                            //labelText: 'Credentials',
                            hintText: 'Recyclable Waste Weight (kg)',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.recycling,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: organicController,
                          //obscureText: true,
                          //readOnly: true,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? 'Weight cannot be blank' : null,
                          decoration: InputDecoration(
                            //labelText: 'Credentials',
                            hintText: 'Organic Waste Weight (kg)',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.breakfast_dining,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: landfillController,
                          //obscureText: true,
                          //readOnly: true,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? 'Weight cannot be blank' : null,
                          decoration: InputDecoration(
                            //labelText: 'Credentials',
                            hintText: 'Landfill Waste Weight (kg)',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.landscape,
                              ),
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
                                  if (_dropdownFormKey.currentState!.validate()) {
                                    //Navigator.pushNamed(context, PilotsScreen.routeName);
                                    submitData(
                                      '${arguments['company']}'.toTitleCase(),
                                      '${arguments['collector']}'.toTitleCase(),
                                      selectedValue.toTitleCase(),
                                      recyclableController.text,
                                      organicController.text,
                                      landfillController.text,
                                    );

                                    recyclableController.clear();
                                    organicController.clear();
                                    landfillController.clear();

                                    setState(() {
                                      selectedValue = 'Select Week';
                                    });

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
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
    );

  }
}
