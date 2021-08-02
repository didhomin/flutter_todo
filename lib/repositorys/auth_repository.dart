import 'dart:convert';
import 'package:flutter_app/util/http_helper.dart';
import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';

class AuthRepository {

  Future<User> join(User user) async {

    var body = json.encode(user.toJson());

    final responseDto = await HttpHelper.post('/api/auth/register',body: body);

    if (responseDto.success == 'true') {
      return User.fromJson(responseDto.response);
    } else {
      throw Exception('Failed Register');
    }
  }


  Future<User> logIn(String id,String password) async {
    print('login');
    User loginData = User.login(id,password);

    var body = json.encode(loginData.toJson());

    final responseDto = await HttpHelper.post('/api/auth/login',body: body);

    if (responseDto.success == 'true') {
      return User.fromJson(responseDto.response);
    } else {
      throw Exception('Failed LogIn');
    }
  }

  Future<bool> logOut() async {

    final responseDto = await HttpHelper.post('/api/auth/logout');

    if (responseDto.success == 'true') {
      // responseDto.response;
      return true;
    } else {
      throw Exception('Failed LogOut ');
    }
  }


}
