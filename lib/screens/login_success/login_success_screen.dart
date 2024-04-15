import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkconnect/components/default_button.dart';
import 'package:tkconnect/data_service/products/userservice.dart';
import 'package:tkconnect/main.dart';
import 'package:tkconnect/screens/home/home_screen.dart';
import 'package:tkconnect/utils/constants.dart';
import 'package:tkconnect/utils/http_strings.dart';
import 'package:tkconnect/utils/size_config.dart';
import 'package:http/http.dart' as http;

class LoginSuccessScreen extends StatefulWidget {
  final String? PhoneNumber;
  final String? CountyName;
  static String routeName = "/login_success";

  const LoginSuccessScreen({
    Key? key,
    this.PhoneNumber,
    this.CountyName,
  }) : super(key: key);

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  UserListService listOfUserService = UserListService();
  late List<UserList> userList;
  var arguments;

  late int id;
  late String firstname,
      lastname,
      contact,
      accounttype,
      county,
      subcounty,
      gender;

  Future<void> loggedAcountNumber(contact, county) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('loggedAccNumber', contact);
    pref.setString('loggedAccCounty', county);
  }

  bool terms = false;

// By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;
  int changerValue = 1;
  String welcomeName = '';

  // This function is triggered when the button is clicked
  ///---------------------------------------------------------------SAVE USER TO DJANGO------------------

  registerUser(token, firstname, lastname, contact, accounttype, county,
      subcounty, gender) async {
    //print(arguments['gender']);
    var path;

    if (county == 'Mombasa') {
      //works
      path = createmombasaUserListUrl;
    }
    if (county == 'Lamu') {
      //works
      path = createlamuUserListUrl;
    }
    if (county == 'Kwale') {
      //works
      path = createkwaleUserListUrl;
    }
    if (county == 'Kilifi') {
      //works
      path = createkilifiUserListUrl;
    }
    if (county == 'Tana River') {
      //works
      path = createtanariverUserListUrl;
    }
    if (county == 'Taita Taveta') {
      //works
      path = createtaitatavetaUserListUrl;
    }

    //print(path);

    var uri = Uri.parse(path);

    ///--------------------create mombasa produce seller
    Map data = {
      'firstname': '$firstname'.toTitleCase(),
      'lastname': '$lastname'.toTitleCase(),
      'contact': '$contact',
      'accounttype': '$accounttype',
      'county': '$county',
      'subcounty': '$subcounty',
      'gender': '$gender',
    };

    var response = await http.post(uri, body: data, headers: {
      'Authorization': ' Token $token',
    });
    //print(response.body.length);
    // if (error != null) {
    //   Get.showSnackbar(GetSnackBar(message: error.toString(),));
    // }

    if (response.statusCode == 200) {
      setState(() {
        terms = true;
      });
      loggedAcountNumber(contact, county);
    } else {
      final snackBar = SnackBar(
        content: const Text(
          'Something went wrong\n\n1. Make sure you have an internet connection\n2. The number your provided already have an account.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        backgroundColor: Colors.redAccent,
        elevation: 1000,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 155,
            left: 10,
            right: 10),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  ///---------------------------------------------------------------END OF SAVE CODE---------------------

  @override
  Widget build(BuildContext context) {
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: terms == false
              ? Text(arguments['appBarTitle'] ?? '')
              : const Text('Registration Successful'),
          centerTitle: true,
        ),
        //body: Body(),
        body: terms != arguments['term']
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Image.asset(
                      //"assets/images/successpic.png",
                      "assets/images/SuccessLoggedIn.png",
                      height: SizeConfig.screenHeight * 0.4, //40%
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Text(
                      //"Login Success",
                      arguments['welcomeTitle'] ?? 'Welcome Back', //
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(30),
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Visibility(
                      visible: widget.PhoneNumber == null ? true : false,
                      child: const Spacer(),
                    ),
                    arguments['county'] == 'Guest Account'
                        ? SizedBox(
                            width: SizeConfig.screenWidth * 0.6,
                            child: DefaultButton(
                              text: "Back to home",
                              press: () {
                                //loggedAcountNumber();
                                Navigator.pushNamed(
                                  context,
                                  HomeScreen.routeName,
                                  arguments: {
                                    'id': '1',
                                    'firstname': 'Guest',
                                    'lastname': 'Account',
                                    'contact': '0780091858',
                                    'accounttype': 'Seller',
                                    'county': 'Mombasa',
                                    'subcounty': 'Kisauni',
                                    'gender': 'Private'
                                  },
                                );
                              },
                            ),
                          )
                        : FutureBuilder<ListOfUsers>(
                            future: listOfUserService.getUserList(
                                arguments['county'] ?? widget.CountyName),
                            builder: (context, snapshot) {
                              List<UserList>? userList =
                                  snapshot.data?.userList;

                              if (snapshot.hasError) {
                                //print('${arguments['county']} ${widget.CountyName}');
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
                                          width:
                                              getProportionateScreenWidth(100),
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
                                return Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      ...?userList?.map((user) {
                                        if (arguments['contact'] != null
                                            ? user.contact ==
                                                arguments['contact']
                                            : user.contact ==
                                                widget.PhoneNumber) {
                                          id = user.id;
                                          firstname = user.firstname;
                                          lastname = user.lastname;
                                          contact = user.contact;
                                          accounttype = user.accounttype;
                                          county = user.county;
                                          subcounty = user.subcounty;
                                          gender = user.gender;
                                        } //print(user.id);

                                        // if (arguments['contact'] == null) {
                                        //   return Text(
                                        //     //"Login Success",
                                        //     user.firstname,
                                        //     style: TextStyle(
                                        //       fontSize: getProportionateScreenWidth(10),
                                        //       fontWeight: FontWeight.bold,
                                        //       color: Colors.black,
                                        //     ),
                                        //   );
                                        // }

                                        if (arguments['contact'] != null) {
                                          return user.contact ==
                                                  arguments['contact']
                                              ? SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.6,
                                                  child: DefaultButton(
                                                    text: "Back to home",
                                                    press: () {
                                                      //loggedAcountNumber();
                                                      Navigator.pushNamed(
                                                        context,
                                                        HomeScreen.routeName,
                                                        arguments: {
                                                          'id': '$id',
                                                          'firstname':
                                                              firstname,
                                                          'lastname': lastname,
                                                          'contact': contact,
                                                          'accounttype':
                                                              accounttype,
                                                          'county': county,
                                                          'subcounty':
                                                              subcounty,
                                                          'gender': gender
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        } else {
                                          return user.contact ==
                                                  widget.PhoneNumber
                                              ? SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.6,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        //"Login Success",
                                                        user.firstname,
                                                        style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  30),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              getProportionateScreenWidth(
                                                                  60)),
                                                      DefaultButton(
                                                        text: "Back to home",
                                                        press: () {
                                                          //loggedAcountNumber();
                                                          Navigator.pushNamed(
                                                            context,
                                                            HomeScreen
                                                                .routeName,
                                                            arguments: {
                                                              'id': '$id',
                                                              'firstname':
                                                                  firstname,
                                                              'lastname':
                                                                  lastname,
                                                              'contact':
                                                                  contact,
                                                              'accounttype':
                                                                  accounttype,
                                                              'county': county,
                                                              'subcounty':
                                                                  subcounty,
                                                              'gender': gender
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        }
                                      }).toList(),
                                    ]);
                              } else {
                                return Column(
                                  children: [
                                    const Text('Finalizing...'),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: const Center(
                                          child: LinearProgressIndicator(
                                        backgroundColor: Color(0xFFB4B4B4),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                      )),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                    const Spacer(),
                  ],
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      'Our Privacy Policy\n\nIntroduction\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'Our privacy policy will help you understand what information we collect and what choices you have. Kenya Marine and Fisheries Research Institute built this as a free app. This service is provided by KMFRI at no cost and is intended for use as is. If you choose to use our Service, then you agree to the collection and use of information in relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible in our website, unless otherwise defined in this Privacy Policy.\n\n'),
                                    Text(
                                      'Information Collection and Use\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The information that we request will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you.\n\n'),
                                    Text(
                                      'Cookies\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory. This Services does not uses these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collection information and to improve their services. You have the option to either accept or refuse these cookies, and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\n'),
                                    Text(
                                      'Location Information\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'Some of the services may use location information transmitted from user mobile phones. We only use this information within the scope necessary for the designated service.\n\n'),
                                    Text(
                                      'Device Information\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'We collect information from your device in some cases. The information will be utilized for the provision of better service and to prevent fraudulent acts. Additionally, such information will not include that which will identify the individual user.\n\n'),
                                    Text(
                                      'Service Providers\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n\n'),
                                    Text(
                                      'Security\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n\n'),
                                    Text(
                                      'Children’s Privacy\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'This Services do not address anyone under the age of 13. We do not knowingly collect personal identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.\n\n'),
                                    Text(
                                      'Changes to This Privacy Policy\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page.\n\n'),
                                    Text(
                                      'Contact Us\n\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.\n\n'
                                      '\n\n',
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: getProportionateScreenWidth(20),
                            ),
                            Row(
                              children: [
                                Material(
                                  child: Checkbox(
                                    activeColor: kPrimaryColor,
                                    //The color to use when this checkbox is checked.
                                    checkColor: Colors.white,
                                    value: agree,
                                    onChanged: (value) {
                                      setState(() {
                                        agree = value ?? false;
                                        //print(value);
                                      });
                                    },
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    'I have read and accepted terms and conditions',
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                ),
                                onPressed: agree
                                    ? () {
                                        registerUser(
                                            auth_token,
                                            arguments['firstname'],
                                            arguments['lastname'],
                                            arguments['contact'],
                                            arguments['accounttype'],
                                            arguments['county'],
                                            arguments['subcounty'],
                                            arguments['gender']);
                                      }
                                    : null,
                                child: const Text('Continue')),
                            SizedBox(
                              height: getProportionateScreenWidth(50),
                            ),
                          ]),
                          // DefaultButton(
                          //   text: "Accept",
                          //   press: agree ? _doSomething : null,
                          // ),
                        ]),
                  ),
                ),
              ),
      ),
    );
  }
}
