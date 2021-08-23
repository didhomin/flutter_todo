import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/services/auth_service.dart';
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

  Map<String, String> getHeader() {
    return {"Authorization": "Bearer ${AuthService.to.user.value.tokenId}"};
  }

  Future<ResponseData> getListByDtm(int userSeq, String dtm) async {

    final response = await get('/api/task/list/$userSeq/$dtm'
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }

  Future<ResponseData> getDetail(String todoSeq) async {

    final response = await get('/api/task/detail/$todoSeq'
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }

  Future<ResponseData> insert(Task task) async {
    final body = task.toJoinJson();
    final response = await post('/api/task/insert', body
        ,headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo insert ');
    }
  }

  Future<ResponseData> update(Task task) async {
    final body = task.toJson();
    final response = await put('/api/task/update/${task.seq}'
        , body
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo update ');
    }
  }

  Future<ResponseData> copy(int userSeq,String dateDtm,{String checkYn = '-1' }) async {
    final body = <String, dynamic>{
      'userSeq': userSeq,
      'checkYn': checkYn,
      'dateDtm': dateDtm,
    };

    final response = await post('/api/task/copy'
        , body
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo copy ');
    }
  }

  Future<ResponseData> remove(int todoSeq) async {

    final response = await delete('/api/task/delete/$todoSeq'
        , headers: getHeader());

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo delete ');
    }
  }

  Future<ResponseData> getTodoAndMemoList(int userSeq,String startDate, String endDate) async {


    final response = await get('/api/todo-and-memo/list/$userSeq'
        , headers: getHeader()
        , query: <String, dynamic>{
    'startDate': startDate,
    'endDate': endDate,} );

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }
}
