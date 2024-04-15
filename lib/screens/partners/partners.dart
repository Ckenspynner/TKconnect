import 'package:flutter/material.dart';
import 'package:tkconnect/components/dev_name_text.dart';
import 'package:tkconnect/models/partners.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({Key? key}) : super(key: key);
  static String routeName = "/partners";

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  final partner = PartnerModel.partner;

  @override
  Widget build(BuildContext context) {
    //print(widget.countyID);
    final baseHeight = MediaQuery.of(context).size.height;

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

              },
              child: Container(
                padding: const EdgeInsets.only(right: 25),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              )
          ),
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: const Text(
            'Our Partners',
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: baseHeight*0.83,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: partner.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildCard(index);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0 / 1,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                ),
              ),
            ),
            SizedBox(height: baseHeight*0.02,),
            //const Text('Developed by Codespynner\nEmail: codespynner@gmail.com',textAlign: TextAlign.center,style: TextStyle(fontSize: 12.0,),),
            const DevText(),
          ]
          ),
        ),

      ),
    );
  }

  Widget buildCard(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.center,
            child: Image.asset(
              partner[index].pictures,
              width: MediaQuery.of(context).size.width / 3,
            ),
          ),
        ],
      ),
    );
  }
}

