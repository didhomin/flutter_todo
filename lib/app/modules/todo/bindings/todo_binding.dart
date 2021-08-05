import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRepository>(
        ()=>TodoRepository()
    );
    Get.put<TodoController>(
      TodoController(Get.find())
    );
  }
}
