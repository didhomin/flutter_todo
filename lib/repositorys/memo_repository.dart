import 'dart:convert';
import 'package:flutter_app/models/memo.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/util/http_helper.dart';
import 'package:get/get_connect/connect.dart';
// import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';
import 'package:flutter_app/models/response_data.dart';
import 'package:get/get.dart';
class MemoRepository extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = Constants.BASE_URL;

  }

  Future<ResponseData> getListByDtm(int userSeq, String dtm) async {

    final response = await get('/api/memo/list/$userSeq/$dtm');

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo getListByDtm  ');
    }
  }

  Future<ResponseData> insert(Memo memo) async {
    final body = memo.toJson();
    final response = await post('/api/memo/insert', body);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo insert ');
    }
  }

  Future<ResponseData> update(Memo memo) async {
    final body = memo.toJson();
    final response = await put('/api/memo/update/${memo.seq}', body);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      throw Exception('Failed Http request todo update ');
    }
  }

  Future<ResponseData> remove(int memoSeq) async {

    final response = await delete('/api/memo/delete/$memoSeq');

    if (response.statusCode == 200) {
      return ResponseData.fromJson(response.body);
    } else {
      // Get.snackbar('Error !!','Failed Http request login. errorMsg : ${response.body}');
      throw Exception('Failed Http request todo delete ');
    }
  }
}
