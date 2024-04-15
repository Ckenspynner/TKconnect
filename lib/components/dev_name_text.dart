import 'package:flutter/material.dart';
import 'package:tkconnect/utils/constants.dart';
import 'package:tkconnect/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class DevText extends StatelessWidget {
  const DevText({
    Key? key,
  }) : super(key: key);

  _launchURL() async {
    const url = 'http://ec2-52-91-203-82.compute-1.amazonaws.com/codespynner/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Developed by ",
          style: TextStyle(fontSize: getProportionateScreenWidth(12)),
        ),
        GestureDetector(
          onTap: () =>  _launchURL(),
          child: Text(
            "Codespynner",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
