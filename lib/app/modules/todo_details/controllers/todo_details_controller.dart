import 'package:get/get.dart';

class TodoDetailsController extends GetxController {
  final String todoSeq;

  TodoDetailsController(this.todoSeq);
  @override
  void onInit() {
    super.onInit();
    Get.log('TodoDetailsController created with seq: $todoSeq');
  }

  @override
  void onClose() {
    Get.log('TodoDetailsController close with seq: $todoSeq');
    super.onClose();
  }
}
