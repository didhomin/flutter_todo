import 'package:flutter/material.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'services/auth_service.dart';

void main() {
  runApp(
    GetMaterialApp.router(
      title: "TODO",
      initialBinding: BindingsBuilder(
            () {
          Get.put(AuthRepository());
          Get.put(AuthService(authRepository:Get.find()));
        },
      ),
      getPages: AppPages.routes,
      // routeInformationParser: GetInformationParser(
      //     // initialRoute: Routes.HOME,
      //     ),
      // routerDelegate: GetDelegate(
      //   backButtonPopMode: PopMode.History,
      //   preventDuplicateHandlingMode:
      //       PreventDuplicateHandlingMode.ReorderRoutes,
      // ),
    ),
  );
}
