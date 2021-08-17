import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_app/util/http_helper.dart';
import 'dart:convert';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/models/response_data.dart';
class AuthService extends GetxService {

  AuthService({required this.authRepository});

  static AuthService get to => Get.find();

  AuthRepository authRepository;

  final isLoggedIn = false.obs;
  final user = User.empty.obs;

  bool get isLoggedInValue => isLoggedIn.value;

  Future<bool> join(User newUser) async {
    ResponseData responseData = await authRepository.join(newUser);

    if (responseData.success == 'true') {
      return true;
    }
    return false;
  }

  Future<bool> login(String id,String password) async {

    ResponseData responseData = await authRepository.logIn(id, password);

    if (responseData.success == 'true') {
      user.value  = User.fromJson(responseData.response!);
      if (user.value.seq > 0) {
        isLoggedIn.value = true;
        return isLoggedIn.value;
      }
    }
    return false;
  }

  void logout() async {
    ResponseData responseData = await authRepository.logOut();
    if (responseData.success == 'true') {
      isLoggedIn.value = false;
    }

  }
}
