import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tkconnect/utils/http_strings.dart';

class UserListService {
  ///////////////////////////////////////////////////////////////-------------MOMBASA
  Future<ListOfUsers> getUserList(String county) async {
    var path;

    if (county == 'Mombasa') {
      //works
      path = mombasaUserListUrl;
    }
    if (county == 'Lamu') {
      //works
      path = lamuUserListUrl;
    }
    if (county == 'Kwale') {
      //works
      path = kwaleUserListUrl;
    }
    if (county == 'Kilifi') {
      //works
      path = kilifiUserListUrl;
    }
    if (county == 'Tana River') {
      //works
      path = tanariverUserListUrl;
    }
    if (county == 'Taita Taveta') {
      //works
      path = taitatavetaUserListUrl;
    }

    //print(path);
    
    var response = await http.get(Uri.parse(path),
    );
    //print(jsonDecode(response.body));
    return ListOfUsers.fromJson(jsonDecode(response.body));
  }}

class ListOfUsers {
  List<UserList> userList = [];

  ListOfUsers({required this.userList});

  factory ListOfUsers.fromJson(List list) {
    List<UserList> _UserList = [];

    list.forEach((element) {
      _UserList.add(UserList.fromJson(element));
    });
    //print(_UserList[1].description);
    return ListOfUsers(userList: _UserList);
  }
}

///////////////////////////////////////////////////////////////-------------TanaRiver
// class ListOfTanaRiverUserList {
//   List<UserList> userList = [];
//
//   ListOfTanaRiverUserList({required this.userList});
//
//   factory ListOfTanaRiverUserList.fromJson(List list) {
//     List<UserList> _UserList = [];
//
//     list.forEach((element) {
//       _UserList.add(UserList.fromJson(element));
//     });
//     //print(_UserList[1].description);
//     return ListOfTanaRiverUserList(userList: _UserList);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Kilifi
// class ListOfKilifiUserList {
//   List<UserList> userList = [];
//
//   ListOfKilifiUserList({required this.userList});
//
//   factory ListOfKilifiUserList.fromJson(List list) {
//     List<UserList> _UserList = [];
//
//     list.forEach((element) {
//       _UserList.add(UserList.fromJson(element));
//     });
//     //print(_UserList[1].description);
//     return ListOfKilifiUserList(userList: _UserList);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Lamu
// class ListOfLamuUserList {
//   List<UserList> userList = [];
//
//   ListOfLamuUserList({required this.userList});
//
//   factory ListOfLamuUserList.fromJson(List list) {
//     List<UserList> _UserList = [];
//
//     list.forEach((element) {
//       _UserList.add(UserList.fromJson(element));
//     });
//     //print(_UserList[1].description);
//     return ListOfLamuUserList(userList: _UserList);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------Kwale
// class ListOfKwaleUserList {
//   List<UserList> userList = [];
//
//   ListOfKwaleUserList({required this.userList});
//
//   factory ListOfKwaleUserList.fromJson(List list) {
//     List<UserList> _UserList = [];
//
//     list.forEach((element) {
//       _UserList.add(UserList.fromJson(element));
//     });
//     //print(_UserList[1].description);
//     return ListOfKwaleUserList(userList: _UserList);
//   }
// }
//
// ///////////////////////////////////////////////////////////////-------------TaitaTaveta
// class ListOfTaitaTavetaUserList {
//   List<UserList> userList = [];
//
//   ListOfTaitaTavetaUserList({required this.userList});
//
//   factory ListOfTaitaTavetaUserList.fromJson(List list) {
//     List<UserList> _UserList = [];
//
//     list.forEach((element) {
//       _UserList.add(UserList.fromJson(element));
//     });
//     //print(_UserList[1].description);
//     return ListOfTaitaTavetaUserList(userList: _UserList);
//   }
// }





class UserList {
  int id;
  String firstname;
  String lastname;
  String contact;
  String accounttype;
  String county;
  String subcounty;
  String gender;

  UserList({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.contact,
    required this.accounttype,
    required this.county,
    required this.subcounty,
    required this.gender,
  });

  factory UserList.fromJson(mapOfBody) {
    // print(mapOfBody["key"]);
    //print(mapOfBody["county"]);

    return UserList(
        id: mapOfBody["id"],
        firstname: mapOfBody["firstname"],
        lastname: mapOfBody["lastname"],
        contact: mapOfBody["contact"],
        accounttype: mapOfBody["accounttype"],
        county: mapOfBody["county"],
        subcounty: mapOfBody["subcounty"],
        gender: mapOfBody["gender"],
    );
  }
}




