import 'package:flutter_app/app/modules/todo_and_memo/controllers/todo_and_memo_controller.dart';
import 'package:flutter_app/repositorys/memo_repository.dart';
import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:get/get.dart';

import '../controllers/todo_and_memo_controller.dart';

class TodoAndMemoBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<TodoRepository>(
        ()=>TodoRepository()
    );
    Get.lazyPut<MemoRepository>(
            ()=>MemoRepository()
    );

    // Get.delete<TodoController>();
    Get.create<TodoAndMemoController>(
          () => TodoAndMemoController(
              Get.parameters['userSeq'] ?? '',
              Get.find(),
              Get.find()),
    );
    // Get.put<TodoController>(
    //   TodoController(
    //       Get.parameters['userSeq'] ?? '',
    //       Get.find(),
    //       Get.find()),
    // );
  }
}
