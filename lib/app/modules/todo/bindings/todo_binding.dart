import 'package:flutter_app/repositorys/memo_repository.dart';
import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {

    print('asdasdasd');
    print(Get.parameters['userSeq']);
    print(Get.parameters);
    Get.lazyPut<TodoRepository>(
        ()=>TodoRepository()
    );
    Get.lazyPut<MemoRepository>(
            ()=>MemoRepository()
    );


    if(Get.parameters['userSeq'] == null) {

      Get.put<TodoController>(
          TodoController(
              Get.parameters['userSeq'] ?? '',
              Get.find(),
              Get.find()),
      );
    } else {
      Get.delete<TodoController>();
      Get.put<TodoController>(
        TodoController(
            Get.parameters['userSeq'] ?? '',
            Get.find(),
            Get.find()),
      );
    }
  }
}
