import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';


class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   'Home Page',
            //   style: TextStyle(fontSize: 20),
            // ),
            Expanded(
              child: Obx(
                    () => RefreshIndicator(
                  onRefresh: () async {
                    controller.accountList.clear();
                    controller.loadAccountList();
                  },
                  child: ListView.builder(
                    itemCount: controller.accountList.length,
                    itemBuilder: (context, index) {
                      final item = controller.accountList[index];
                      return ListTile(
                        // onTap: () {
                        //   Get.rootDelegate
                        //       .toNamed(Routes.TODO_DETAILS(item.seq.toString()));
                        // },
                        title: Text(item.id),
                        subtitle: Text(item.nickname??''),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
