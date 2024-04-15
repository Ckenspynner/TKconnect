import 'package:flutter/material.dart';
import 'package:tkconnect/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);
  static String routeName = "/contactus";

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool _flag1 = false;
  bool _flag2 = false;
  bool _flag3 = false;

  _makingPhoneCall() async {
    var url = Uri.parse("tel:0712003853");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.countyID);
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
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
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(right: 25),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              )),
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: const Text(
            'Contact Us',
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F6F9),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Align(
                    alignment: AlignmentDirectional.center,
                    child: Image(
                      width: 300,
                      image: AssetImage(
                        'assets/images/talktous.png',
                        // width: MediaQuery.of(context).size.width ,
                        // height:MediaQuery.of(context).size.width  ,
                      ),
                    )),
                const Text('Talk to us',style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.bold,
                  //color: Colors.black,
                ),),
                const Text('We are ready to listen'),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _flag1 = !_flag1;
                        _flag2 = false;
                        _flag3 = false;
                      });

                      String email = Uri.encodeComponent("tkconnect@kmfri.go.ke");
                      String subject = Uri.encodeComponent("I need Help");
                      String body = Uri.encodeComponent("Hello");
                      print(subject); //output: Hello%20Flutter
                      Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                      if (await launchUrl(mail)) {
                      //email app opened
                      }else{
                      //email app is not opened
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: _flag1 ? kPrimaryColor : Colors.white,
                      foregroundColor: _flag1 ? Colors.white : kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Text(
                        'Send An Email to (tkconnect@kmfri.go.ke)',overflow: TextOverflow.ellipsis,

                      softWrap: false,style: TextStyle(fontSize: 12 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * ffem / fem,)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _flag2 = !_flag2;
                        _flag1 = false;
                        _flag3 = false;
                      });


                      Uri sms = Uri.parse(
                          'sms:0712003853?body=Hello');
                      if (await launchUrl(sms)) {
                      //app opened
                      } else {
                      //app is not opened
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: _flag2 ? kPrimaryColor : Colors.white,
                      foregroundColor: _flag2 ? Colors.white : kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Text('Send A Message (0712003853)',overflow: TextOverflow.ellipsis,

                        softWrap: false,style: TextStyle(fontSize: 12 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * ffem / fem,)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _flag3 = !_flag3;
                        _flag1 = false;
                        _flag2 = false;
                      });

                      _makingPhoneCall();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: _flag3 ? kPrimaryColor : Colors.white,
                      foregroundColor: _flag3 ? Colors.white : kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Text('Call Us (0712003853)',overflow: TextOverflow.ellipsis,

                        softWrap: false,style: TextStyle(fontSize: 12 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * ffem / fem,)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
