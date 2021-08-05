import 'package:get/get.dart';

import '../controllers/todo_details_controller.dart';

class TodoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoDetailsController>(
      () => TodoDetailsController(
        Get.parameters['todoSeq'] ?? '',
      ),
    );
  }
}
