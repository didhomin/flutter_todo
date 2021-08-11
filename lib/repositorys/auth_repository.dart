import 'dart:convert';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/util/http_helper.dart';
import 'package:get/get_connect/connect.dart';
// import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';
import 'package:flutter_app/models/response_data.dart';
import 'package:get/get.dart';
class AuthRepository extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = Constants.BASE_URL;

  }

  Future<ResponseData> join(User user) async {

    print('httpClient.baseUrl :: $httpClient.baseUrl');
    var body = json.encode(user.toJson());
    print('body :: $body');
    final response = await post('/api/auth/join', body);

    print('response :: $response');
    print('response.statusCode :: ${response.statusCode}');
    print('response.body :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request join ');
    }
  }


  Future<ResponseData> logIn(String id,String password) async {
    print('login');
    print('httpClient.baseUrl :: ${httpClient.baseUrl}');
    User loginData = User.login(id,password);
    var body = json.encode(loginData.toJson());

    final response = await post('/api/auth/login', body);
    print('response :: ${response.statusCode}');
    print('response :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request login ');
    }
  }

  Future<ResponseData> logOut() async {

    final response = await post('/api/auth/logout',null);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request logout ');
    }
  }

  Future<ResponseData> getAccountList() async {

    final response = await get('/api/account/list');

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request getAccountList ');
    }
  }

}
