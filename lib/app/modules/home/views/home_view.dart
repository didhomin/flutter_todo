import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentLocation = currentRoute?.location;
        var currentIndex = 0;
        if (currentLocation?.startsWith(Routes.TODO) == true) {
          currentIndex = 1;
        }
        if (currentLocation?.startsWith(Routes.HISTORY) == true) {
          currentIndex = 2;
        }
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.DASHBOARD,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.toNamed(Routes.HOME);
                  break;
                case 1:
                  delegate.toNamed(Routes.TODO);
                  break;
                case 2:
                  delegate.toNamed(Routes.HISTORY);
                  break;
                default:
              }
            },
            items: [
              // _Paths.HOME + [Empty]
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // _Paths.HOME + Routes.PROFILE
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: 'TODO',
              ),
              // _Paths.HOME + _Paths.PRODUCTS
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.work_outlined),
              //   label: 'History',
              // ),
            ],
          ),
        );
      },
    );
  }
}
