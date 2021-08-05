import 'package:flutter_app/app/modules/todo/controllers/todo_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/todo_details_controller.dart';

class TodoDetailsView extends GetWidget<TodoDetailsController> {


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ProductDetailsView is working',
              style: TextStyle(fontSize: 20),
            ),
            Text('todo seq: ${controller.todoSeq}'),
          ],
        ),
      ),
    );
  }
}
