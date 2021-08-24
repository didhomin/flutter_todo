import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SettingsController extends GetxController {

  late TextEditingController idEditingController, passwordEditingController, nicknameEditingController;
  @override
  void onInit() {
    super.onInit();

    idEditingController = TextEditingController();
    idEditingController.text = AuthService.to.user.value.id;

    passwordEditingController = TextEditingController();
    passwordEditingController.text;

    nicknameEditingController = TextEditingController();
    nicknameEditingController.text = AuthService.to.user.value.nickname??'';

  }

  updateNickname() async {
    AuthService.to.update(User(nickname: nicknameEditingController.text));
  }

  updatePassword() async {
    AuthService.to.update(User(password: passwordEditingController.text));
    passwordEditingController.clear();
  }
}
