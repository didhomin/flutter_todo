import 'package:flutter_app/models/code.dart';
import 'package:flutter_app/models/memo.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/models/task_and_memo.dart';
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
  var isSecret = false.obs;

  var map = <String, dynamic>{}.obs;

  var now = DateTime.now().obs;
  var floatExtended = false.obs;

  String get todayDtm => '${now.value.year}년 ${now.value.month}월 ${now.value.day}일 ${DateFormat('EEEE').format(now.value)}';
  String get todayDateServerFormatted => DateFormat('yyyyMMdd').format(now.value);

  var todoList = <Rx<Task>>[].obs;
  var memoList = <Rx<Memo>>[].obs;

  var optionList = [Code('-1','전체'),Code('1','완료'),Code('0','미완')];
  var selectedOption = '-1'.obs;
  int editModeIndex = -1;

  @override
  void onInit() async {
    super.onInit();
    Get.printInfo(info: 'inInit');
    titleEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    Get.printInfo(info: 'onReady');
    loadTodoList();
    loadMemoList();
    //loadTodoAndMemoList();
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
    final response = await memoRepository.getListByDtm(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq , todayDateServerFormatted);

    if (response.success == 'true') {
      memoList.value = List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
    }
  }


  todoRegister() async {
    final todo = Task.insert(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    if(isSecret.isTrue) {
      todo.isPublic = false;
    }
    final response = await todoRepository.insert(todo);
    titleEditingController.clear();
    isSecret.value = false;
    Get.back();

    if (response.success == 'true') {
      todoList.add(Task.fromJson(response.response).obs);
    }
  }


  todoModify(Task todo) async {
    todo.title = titleEditingController.text;
    todo.isPublic = !isSecret.value;
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

  memoRegister() async {
    final memo = Memo.insert(AuthService.to.user.value.seq,titleEditingController.text,todayDateServerFormatted);
    if(isSecret.isTrue) {
      memo.isPublic = false;
    }
    final response = await memoRepository.insert(memo);
    titleEditingController.clear();
    isSecret.value = false;
    Get.back();
    if (response.success == 'true') {
      memoList.add(Memo.fromJson(response.response).obs);
    }
    // memoList.add(memo.obs);
  }

  memoModify(Memo memo) async {
    memo.contents = titleEditingController.text;
    memo.isPublic = !isSecret.value;
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

  @override
  void update([List<Object>? ids, bool condition = true]) {
    Get.printInfo(info: 'update  : ${ids}');
    print('update  : ${ids}');
  }
}
