import 'package:flutter_app/models/code.dart';
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

  final optionList = [Code('-1','전체'),Code('1','완료'),Code('0','미완')];
  final selectedOption = '-1'.obs;
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
    loadMemoList();
  }

  void loadTodoList() async {
    final response = await todoRepository.getListByDtm(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq , todayDateServerFormatted);

    if (response.success == 'true') {
      todoList.value = List<Rx<Task>>.from(response.response.map((x) => Task.fromJson(x).obs));
    }
  }

  void loadMemoList() async {
    final response = await memoRepository.getListByDtm(AuthService.to.user.value.seq, todayDateServerFormatted);

    if (response.success == 'true') {
      memoList.value = List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
    }
  }


  todoRegister() async {
    final todo = Task.insert(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    await todoRepository.insert(todo);
    titleEditingController.clear();
    Get.back();

    todoList.add(todo.obs);
  }


  todoModify(Task todo) async {
    todo.title = titleEditingController.text;

    await todoRepository.update(todo);

    titleEditingController.clear();

    Get.back();
    todoList.forEach((element) {
      if(todo.seq == element.value.seq) {
        element.value.title = todo.title;
      }
    });
    todoList.refresh();

  }

  todoCopy() {
    todoRepository.copy(AuthService.to.user.value.seq,todayDateServerFormatted,checkYn: selectedOption.value);
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
    this.editModeIndex = index;
    todoList.refresh();
  }

  memoRegister() async {
    final memo = Memo.insert(AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    await memoRepository.insert(memo);
    titleEditingController.clear();
    Get.back();

    memoList.add(memo.obs);
  }

  memoModify(Memo memo) async {
    memo.contents = titleEditingController.text;

    await memoRepository.update(memo);

    titleEditingController.clear();

    Get.back();
    memoList.forEach((element) {
      if(memo.seq == element.value.seq) {
        element.value.contents = memo.contents;
      }
    });
    memoList.refresh();

  }

  memoRemove(int index) async {

    await memoRepository.remove(memoList[index].value.seq);

    memoList.removeAt(index);

  }
}
