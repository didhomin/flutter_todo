import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current?.currentPage!.title;
        return Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            title: Text(title ?? ''),
            centerTitle: true,
          ),
          body: GetRouterOutlet(
            initialRoute: AppPages.INITIAL,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
          ),
        );
      },
    );
  }
}
