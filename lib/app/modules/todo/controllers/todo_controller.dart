import 'package:flutter_app/models/memo.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/repositorys/memo_repository.dart';
import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TodoController extends GetxController {

  TodoController(this.userSeq,this.todoRepository,this.memoRepository);

  TodoRepository todoRepository;

  MemoRepository memoRepository;

  String userSeq;

  late TextEditingController titleEditingController;

  final now = DateTime.now().obs;
  final floatExtended = false.obs;

  String get todayDtm => '${now.value.year}년 ${now.value.month}월 ${now.value.day}일';
  String get todayDateServerFormatted => DateFormat('yyyyMMdd').format(now.value);

  final todoList = <Rx<Task>>[].obs;
  final memoList = <Rx<Memo>>[].obs;

  int editModeIndex = -1;

  @override
  void onInit() async {
    super.onInit();

    titleEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    loadTodoList();
    loadMemoList();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'TODO List: onClose');
    super.onClose();
  }

  void changeDtm(DateTime newDate) async {
    now.value = newDate;

    loadTodoList();
  }

  void loadTodoList() async {
    final response = await todoRepository.getListByDtm(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq , todayDateServerFormatted);

    print('responseData ${response.toString()}');
    if (response.success == 'true') {
      print('response.response ::: ${response.response}');

      todoList.value = List<Rx<Task>>.from(response.response.map((x) => Task.fromJson(x).obs));

      // todoList.value  = Task.fromJson(response.response!);

    }
  }

  void loadMemoList() async {
    final response = await memoRepository.getListByDtm(AuthService.to.user.value.seq, todayDateServerFormatted);

    print('responseData ${response.toString()}');
    if (response.success == 'true') {
      print('response.response ::: ${response.response}');
      memoList.value = List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
    }
  }


  todoRegister() async {
    final todo = Task.insert(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    await todoRepository.insert(todo);
    titleEditingController.clear();
    // final thenTo = Get.rootDelegate.currentConfiguration!
    //     .currentPage!.parameters?['then'];
    // Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    Get.back();

    todoList.add(todo.obs);
    // loadTodoList();
  }

  todoCopy() {
    todoRepository.copy(AuthService.to.user.value.seq,todayDateServerFormatted);
  }

  todoRemove(int index) async {

    await todoRepository.remove(todoList[index].value.seq);

    todoList.removeAt(index);

  }

  toggleCheckYn(index) async {

    final item = todoList[index];
    item.value.isCheck = !item.value.isCheck;

    await todoRepository.update(item.value);

    todoList[index].value.isCheck = item.value.isCheck;
    todoList.refresh();
  }

  void setEditMode(int index) {
    print(index);
    this.editModeIndex = index;
    todoList.refresh();
  }

  memoRegister() async {
    final memo = Memo.insert(AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    await memoRepository.insert(memo);
    titleEditingController.clear();
    // final thenTo = Get.rootDelegate.currentConfiguration!
    //     .currentPage!.parameters?['then'];
    // Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    Get.back();

    memoList.add(memo.obs);
    // loadMemoList();
  }

  memoRemove(int index) async {

    await memoRepository.remove(memoList[index].value.seq);

    memoList.removeAt(index);

  }
}
