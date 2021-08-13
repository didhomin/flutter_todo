import 'dart:convert';
import 'package:flutter_app/models/response_data.dart';
import 'package:http/http.dart';
import 'package:flutter_app/models/user.dart';
// import 'package:shared/shared.dart';

class HttpHelper {
  static Client _client = Client();
  static String _host = "192.168.0.28:9094";

  static Map<String,String> _headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  static Future<ResponseData> post(String path,{Object? body,Map<String, dynamic>? queryParameters }) async {

    final response = await _client.post(Uri.http(_host,path,queryParameters),headers: _headers, body: body);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Http request Post method // path : $path');
    }
  }

  static Future<ResponseData> get(String path, Map<String, dynamic>? queryParameters ) async {

    final response = await _client.get(Uri.http(_host,path,queryParameters),headers: _headers);

    if (response.statusCode == 200) {
      return ResponseData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Http request Get method // path : $path');
    }
  }

}
