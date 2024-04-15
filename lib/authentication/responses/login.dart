

class LoginResponse {
  List<dynamic>? non_field_error;
  dynamic key;

  LoginResponse({
    this.non_field_error,
    this.key,
  });

  factory LoginResponse.fromJson(mapOfBody) {
    //print(mapOfBody["key"]);
    // print(mapOfBody["password1"]);
    return LoginResponse(
      key: mapOfBody["key"],
      non_field_error: mapOfBody["non_field_error"],
    );
  }
}