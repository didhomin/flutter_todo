import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';



class AuthRepository {
  Client client = Client();

  Future<User> logIn(String id,String password) async {
    User loginData = User.login(id,password);

    final _authority = "192.168.1.3:9094";
    final _path = "/api/auth/login";
    final _params = { };

    var body = json.encode(loginData.toLoginJson());

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    final response = await client.post(Uri.http(_authority,_path),headers: headers, body: body);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body)['response']);
    } else {
      throw Exception('Failed LogIn');
    }
  }

  Future<User> logOut() async {
    // User loginData = User.empty;

    // final _authority = "192.168.1.3:9094";
    // final _path = "/api/auth/login";
    // final _params = { };
    // print("body json : ${loginData.toLoginJson()}");
    // final response = await client.post(Uri.http(_authority,_path),body: loginData.toLoginJson());

    // if (response.statusCode == 200) {
    //   print("res data : ${User.fromJson(json.decode(response.body))}");
      return User.empty;
    // } else {
    //   throw Exception('Failed LogOut ');
    // }
  }


}
