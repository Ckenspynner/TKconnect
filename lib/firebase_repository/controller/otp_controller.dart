import 'package:get/get.dart';
import 'package:tkconnect/firebase_repository/authentication_repository/authentication_repository.dart';
import 'package:tkconnect/screens/login_success/login_success_screen.dart';
class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() {LoginSuccessScreen();}): Get.back();
  }
}