import 'dart:convert';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/util/http_helper.dart';
import 'package:get/get_connect/connect.dart';
// import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';
import 'package:flutter_app/models/response_data.dart';
import 'package:get/get.dart';
class TodoRepository extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = Constants.BASE_URL;

  }

  Future<ResponseData> getListByDtm(int userSeq, String dtm) async {

    print('httpClient.baseUrl :: $httpClient.baseUrl');


    final response = await get('/api/task/list/$userSeq/$dtm');

    print('response :: $response');
    print('response.statusCode :: ${response.statusCode}');
    print('response.body :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }

  Future<ResponseData> getDetail(String todoSeq) async {

    final response = await get('/api/task/detail/$todoSeq');

    print('response :: $response');
    print('response.statusCode :: ${response.statusCode}');
    print('response.body :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }

  Future<ResponseData> insert(Task task) async {
    final body = task.toJoinJson();
    print('insert body :: $body');
    final response = await post('/api/task/insert', body);
    print('response :: ${response.statusCode}');
    print('response :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo insert ');
    }
  }

  Future<ResponseData> copy(int userSeq,String dateDtm,{int checkYn = -1 }) async {
    final body = <String, dynamic>{
      'userSeq': userSeq,
      'checkYn': checkYn,
      'dateDtm': dateDtm,
    };
    print('task copy body :: $body');
    final response = await post('/api/task/copy', body);
    print('response :: ${response.statusCode}');
    print('response :: ${response.body}');
    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo copy ');
    }
  }


}
