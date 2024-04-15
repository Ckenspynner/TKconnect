import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tkconnect/authentication/responses/login.dart';
import 'package:tkconnect/authentication/responses/registration.dart';
import 'package:tkconnect/utils/http_strings.dart';

class AuthService {
  ///------------------------------------------------------------------------------------------Registration-----------------------
  //Registration
  Future<RegistrationResponse?> registration(
      String username, String email, String password1, String password2) async {
    var response = await http.post(Uri.parse(registrationUrl), body: {
      "username": username,
      "email": email,
      "password1": password1,
      "password2": password2,
    });
    //print(response.body);
    return RegistrationResponse.fromJson(jsonDecode(response.body));
    //return response.body;
  }

  ///------------------------------------------------------------------------------------------Login------------------------------
  //Login
  Future<LoginResponse?> login(String usernameOremail, String password) async {
    var response = await http.post(Uri.parse(loginUrl), body: {
      "username": usernameOremail,
      "password": password,
    });
    //print(response.body);
    return LoginResponse.fromJson(jsonDecode(response.body));
    //return response.body;
  }
}