import 'dart:convert';
import 'package:flutter_app/services/auth_service.dart';
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

  Map<String, String> getHeader() {
    return {"Authorization": "Bearer ${AuthService.to.user.value.tokenId}"};
  }

  Future<ResponseData> join(User user) async {

    var body = json.encode(user.toJson());

    final response = await post('/api/auth/join', body);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request join ');
    }
  }


  Future<ResponseData> logIn(String id,String password) async {

    User loginData = User.login(id,password);
    var body = json.encode(loginData.toJson());

    final response = await post('/api/auth/login', body);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request login ');
    }
  }

  Future<ResponseData> logOut() async {

    final response = await post('/api/auth/logout',null
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request logout ');
    }
  }

  Future<ResponseData> getAccountList() async {

    final response = await get('/api/account/list'
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request getAccountList ');
    }
  }

}
