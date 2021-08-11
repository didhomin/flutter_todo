import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TodoController extends GetxController {

  TodoController(this.todoRepository);

  TodoRepository todoRepository;

  late TextEditingController titleEditingController;

  final now = DateTime.now().obs;

  String get todayDtm => '${now.value.year}년 ${now.value.month}월 ${now.value.day}일';
  String get todayDateServerFormatted => DateFormat('yyyyMMdd').format(now.value);

  final todoList = <Task>[].obs;

  @override
  void onInit() async {
    super.onInit();

    titleEditingController = TextEditingController();
  }
  void changeDtm(DateTime newDate) async {
    now.value = newDate;

    loadTodoList();
  }

  void loadTodoList() async {
    final response = await todoRepository.getListByDtm(AuthService.to.user.value.seq, todayDateServerFormatted);

    print('responseData ${response.toString()}');
    if (response.success == 'true') {
      print('response.response ::: ${response.response}');

      todoList.value = List<Task>.from(response.response.map((x) => Task.fromJson(x)));

      // todoList.value  = Task.fromJson(response.response!);

    }
  }


  register() async {
    await todoRepository.insert(Task.insert(AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted));
    titleEditingController.clear();
    // final thenTo = Get.rootDelegate.currentConfiguration!
    //     .currentPage!.parameters?['then'];
    // Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    Get.back();

    loadTodoList();
  }

  copy() {
    todoRepository.copy(AuthService.to.user.value.seq,todayDateServerFormatted);
  }

  @override
  void onReady() {
    super.onReady();
    loadTodoList();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'TODO List: onClose');
    super.onClose();
  }

}
