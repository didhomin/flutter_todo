import 'dart:async';

import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  DashboardController(this.authRepository);

  AuthRepository authRepository;


  final accountList = <User>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadAccountList();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'DashboardController: onClose');
    super.onClose();
  }

  void loadAccountList() async {
    final response = await authRepository.getAccountList();

    print('responseData ${response.toString()}');
    if (response.success == 'true') {
      print('response.response ::: ${response.response}');

      accountList.value = List<User>.from(response.response.map((x) => User.fromJson(x)));

      // todoList.value  = Task.fromJson(response.response!);

    }
  }

}
