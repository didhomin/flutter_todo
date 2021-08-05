import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/models/user.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {

  late TextEditingController idEditingController, passwordEditingController;

  late TextEditingController joinIdEditingController, joinPasswordEditingController, joinNicknameEditingController;


  @override
  void onInit() async {
    super.onInit();

    idEditingController = TextEditingController();
    passwordEditingController = TextEditingController();

    joinIdEditingController = TextEditingController();
    joinPasswordEditingController = TextEditingController();
    joinNicknameEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();

  }

  login() async {
    await AuthService.to.login(idEditingController.text,passwordEditingController.text);
    final thenTo = Get.rootDelegate.currentConfiguration!
        .currentPage!.parameters?['then'];
    Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);

  }

  register() async {

    await AuthService.to.join(User.join(joinIdEditingController.text,joinPasswordEditingController.text,nickname:joinNicknameEditingController.text));
    // final thenTo = Get.rootDelegate.currentConfiguration!
    //     .currentPage!.parameters?['then'];
    // Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    Get.back();
  }
}
