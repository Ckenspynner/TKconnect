import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/http_strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PilotStatScreen extends StatefulWidget {
  const PilotStatScreen({Key? key}) : super(key: key);
  static String routeName = "/pilotstats";

  @override
  State<PilotStatScreen> createState() => _PilotStatScreenState();
}

class _PilotStatScreenState extends State<PilotStatScreen> {
  String selectedValue = "Select Week";

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

  Map<String, double> dataMap = {};

  late Future<List<Data>> futureData;

  @override
  void initState() {
    futureData = fetchData();

    //getCollections();
    super.initState();
  }

  final colorList = <Color>[
    kPrimaryColor,
    kPrimaryLightColor,
    Colors.pinkAccent,
    Colors.purple,
    Colors.amber,
    Colors.orange,
    Colors.blueAccent,
    Colors.red,
  ];

  // Future<List> getData() async {
  //   var url = "http://$ipAddress/sdg/transect/getdata.php";
  //   final response = await http.post(Uri.parse(url), body: {
  //     'beachID': widget.beachID,
  //     'Dates': currentDate,
  //   });
  //
  //   //print(response.body);
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    // print(arguments['company']);
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
        // actions: [
        //   GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //         padding: const EdgeInsets.only(right: 25),
        //         child: const Icon(
        //           Icons.more_vert,
        //           color: Colors.black,
        //         ),
        //       )),
        // ],
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: const Text(
            'Statistic Board',
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F6F9),
      body: SafeArea(
        child: ListView(children: [
          // FutureBuilder<dynamic>(
          //   future: getCollections(), // function where you call your api
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     // AsyncSnapshot<Your object type>
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: Text('Please wait its loading...'));
          //     } else {
          //       if (snapshot.hasError) {
          //         return Center(child: Text('Error: ${snapshot.error}'));
          //       } else {
          //         // return Center(
          //         //     child: Text(
          //         //         '${snapshot.data}')); // snapshot.data  :- get your object which is pass from your downloadData() function
          //
          //         List<dynamic> collections = snapshot.data();
          //         return ListView.builder(
          //             itemCount: collections.length,
          //             itemBuilder: (context, index) {
          //               var category = collections[index];
          //               return Text(category.CategoryName);
          //             });
          //
          //       }
          //     }
          //   },
          // ),

          FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? list1 = snapshot.data;
                List list = [];


                list1?.forEach((element) {
                  //print(element.week);
                   if(element.company == arguments['company']) {
                   //  list = [{'week': element.week,'recyclable': element.recyclable,'organic': element.organic,'landfill': element.landfill}];
                     list.addAll([{'week': element.week,'recyclable': element.recyclable,'organic': element.organic,'landfill': element.landfill}]);
                   }else {
                     //list = {[]};
                   }
                });
                //print(list);
                if (list.isEmpty) {
                  dataMap.addAll(
                    {
                      "No record found": 0,
                    },
                  );
                }

                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  //child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      PieChart(
                        dataMap: dataMap,
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        animationDuration: const Duration(milliseconds: 1000),
                        chartLegendSpacing: 30,
                        // chartRadius: MediaQuery.of(context).size.width / 2.2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          //showChartValuesInPercentage: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                        centerText: "Your Weekly \nWaste Collections",
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          //showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            //fontSize: 20.0
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowHeight: 50,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => kPrimaryColor),
                            border: TableBorder(
                                borderRadius: BorderRadius.circular(100),
                                verticalInside: const BorderSide(
                                    width: 3,
                                    style: BorderStyle.solid,
                                    color: Colors.black),
                                horizontalInside: const BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: kPrimaryColor)),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Week',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Recyclable \n(kg)',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Organic \n(kg)',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Landfill \n(kg)',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Total \nWeek (kg)',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            rows: List.generate(
                              list.isEmpty ? 1 : list.length + 1,
                              (index) {
                                //Calculates Total weight
                                double TotalRecyclable = 0.0,
                                    TotalOrganic = 0.0,
                                    TotalLandfill = 0.0;
                                //print(list.length);
                                // if (index > 0 && index < 8) {
                                if (index < list.length) {

                                  dataMap.addAll(
                                    {
                                      "${list[index]['week']}": double.parse(
                                              list[index]['landfill']) +
                                          double.parse(list[index]['organic']) +
                                          double.parse(list[index]['recyclable']),
                                    },
                                  );
                                  return DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                        "${list[index]['week']}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                      DataCell(Text(
                                        '${list[index]['recyclable']} kgs',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                      DataCell(Text(
                                        '${list[index]['organic']} kgs',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                      DataCell(Text(
                                        '${list[index]['landfill']} kgs',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                      DataCell(Text(
                                        '${double.parse(list[index]['landfill']) + double.parse(list[index]['organic']) + double.parse(list[index]['recyclable'])} kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ],
                                  );
                                } else if (index == list.length + 1) {
                                  TotalRecyclable = list.fold(
                                      0, (sum, item) => sum + item['recyclable']);
                                  TotalOrganic = list.fold(
                                      0, (sum, item) => sum + item['organic']);
                                  TotalLandfill = list.fold(
                                      0, (sum, item) => sum + item['landfill']);

                                  return DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text(
                                        "Totals",
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalRecyclable kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalOrganic kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalLandfill kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '${TotalRecyclable + TotalOrganic + TotalLandfill} kgs',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ],
                                  );
                                } else {
                                  TotalRecyclable = list.fold(
                                      0,
                                      (sum, item) =>
                                          sum + double.parse(item['recyclable']));
                                  TotalOrganic = list.fold(
                                      0,
                                      (sum, item) =>
                                          sum + double.parse(item['organic']));
                                  TotalLandfill = list.fold(
                                      0,
                                      (sum, item) =>
                                          sum + double.parse(item['landfill']));

                                  return DataRow(
                                    cells: <DataCell>[
                                      const DataCell(Text(
                                        "Totals",
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalRecyclable kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalOrganic kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '$TotalLandfill kgs',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      DataCell(Text(
                                        '${TotalRecyclable + TotalOrganic + TotalLandfill} kgs',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ],
                                  );
                                }
                              },
                            ), //sangulo
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                // color: Colors.black38,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        size: 50,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const DefaultTextStyle(
                      style: TextStyle(decoration: TextDecoration.none),
                      child: Text(
                        'Please wait',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'ProximaNova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}

class DataList extends StatelessWidget {
  List list;

  DataList({
    Key? key,
    required this.list,
  }) : super(key: key);

  TextEditingController _inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    if (list.isEmpty) {
      return const Center(
        child: Text('Press the + button to add a transect'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              visualDensity: const VisualDensity(vertical: 4),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Center(
                    child: Text(
                  list[index][0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'ProximaNova',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                )),
              ),
              title: Text(
                'Transect ${list[index][0].substring(1, 2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'ProximaNova',
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
              trailing: Wrap(spacing: -5, children: [
                IconButton(
                    icon: const Icon(
                      Icons.wb_sunny_outlined,
                    ),
                    onPressed: () {}),
                IconButton(
                  icon: const Icon(
                    Icons.water_drop_outlined,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.blueAccent,
                  ),
                  // onPressed: () {
                  //
                  // },
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Warning',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        'Are you sure you want to delete \n${list[index][0]}',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Yes');
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Verify Action !',
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontFamily: 'ProximaNova',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.close_outlined,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Yes');
                                                  },
                                                ),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      _inputTextController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Confirm"),
                                                  onChanged: (value) {},
                                                ),
                                              ],
                                            ),
                                          ));
                                },
                                child: const Text('Yes'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            );
          },
        ),
      );
    }
  }
}

class Data {
  final int id;
  final week;
  final company;
  final collector;
  final recyclable;
  final organic;
  final landfill;

  Data(
      {this.week,
      this.company,
      this.collector,
      this.recyclable,
      this.organic,
      this.landfill,
      required this.id});

  @override
  String toString() {
    return '{id: $id,week: $week,company: $company,collector: $collector,recyclable: $recyclable,organic: $organic,landfill: $landfill}';
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      week: json['week'],
      company: json['company'],
      collector: json['collector'],
      recyclable: json['recyclable'],
      organic: json['organic'],
      landfill: json['landfill'],
    );
  }
}

Future<List<Data>> fetchData() async {
  final response = await http.get(Uri.parse(pilotUrl));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
