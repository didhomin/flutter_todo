import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
            ()=>AuthRepository()
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(Get.find()),
    );
  }
}
