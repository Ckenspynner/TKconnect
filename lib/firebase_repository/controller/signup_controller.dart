
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../authentication_repository/authentication_repository.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final phoneNo = TextEditingController();

  ///Phone Authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }


}