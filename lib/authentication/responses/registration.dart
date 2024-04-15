

class RegistrationResponse {
  List<dynamic>? non_field_error;
  List<dynamic>? password1;
  List<dynamic>? username;
  List<dynamic>? email;
  dynamic key;

  RegistrationResponse({
    this.email,
    this.username,
    this.non_field_error,
    this.key,
    this.password1,
  });

  factory RegistrationResponse.fromJson(mapOfBody) {
    // print(mapOfBody["key"]);
    // print(mapOfBody["password1"]);
    return RegistrationResponse(
      email: mapOfBody["email"],
      key: mapOfBody["key"],
      username: mapOfBody["username"],
      password1: mapOfBody["password1"],
      non_field_error: mapOfBody["non_field_error"],
    );
  }
}