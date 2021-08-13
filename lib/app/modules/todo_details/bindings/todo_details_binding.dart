import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:get/get.dart';

import '../controllers/todo_details_controller.dart';

class TodoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRepository>(
            ()=>TodoRepository()
    );
    Get.create<TodoDetailsController>(
      () => TodoDetailsController(
        Get.parameters['todoSeq'] ?? '',
        Get.find()
      ),
    );
  }
}
