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

class TodoAndMemoController extends GetxController {

  TodoAndMemoController(this.userSeq,this.todoRepository,this.memoRepository);

  TodoRepository todoRepository;

  MemoRepository memoRepository;

  String userSeq;

  var map = <String, dynamic>{}.obs;

  var now = DateTime.now().obs;

  String get todayDtm => '${now.value.year}년 ${now.value.month}월 ${now.value.day}일 ${DateFormat('EEEE').format(now.value)}';
  String get todayDateServerFormatted => DateFormat('yyyyMMdd').format(now.value);


  late TextEditingController titleEditingController;
  var isSecret = false.obs;

  var floatExtended = false.obs;

  var optionList = [Code('-1','전체'),Code('1','완료'),Code('0','미완')];
  var selectedOption = '-1'.obs;
  int editModeIndex = -1;
  
  @override
  void onInit() async {
    super.onInit();
    titleEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    Get.printInfo(info: 'onReady');
    loadTodoAndMemoList();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'TODO List: onClose');
    super.onClose();
  }

  void changeDtm(DateTime newDate) async {
    now.value = newDate;

    loadTodoAndMemoList();
  }

  // void loadTodoList() async {
  //   final response = await todoRepository.getListByDtm(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq , todayDateServerFormatted);
  //
  //   if (response.success == 'true') {
  //     todoList.value = List<Rx<Task>>.from(response.response.map((x) => Task.fromJson(x).obs));
  //   }
  // }
  //
  // void loadMemoList() async {
  //   final response = await memoRepository.getListByDtm(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq , todayDateServerFormatted);
  //
  //   if (response.success == 'true') {
  //     memoList.value = List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
  //   }
  // }


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
      if(map.value.containsKey(todayDateServerFormatted)) {
        if(map.value[todayDateServerFormatted].value.taskList == null) {
          map.value[todayDateServerFormatted].value.taskList = <Rx<Task>>[];
        }
        map.value[todayDateServerFormatted].value.taskList.add(Task.fromJson(response.response).obs);
      } else {
        map.value[todayDateServerFormatted] = TaskAndMemo(taskList: <Rx<Task>>[Task.fromJson(response.response).obs], memoList: <Rx<Memo>>[]).obs;
      }
      map.refresh();
    }
  }


  todoModify(Task todo) async {
    todo.title = titleEditingController.text;
    todo.isPublic = !isSecret.value;
    await todoRepository.update(todo);

    titleEditingController.clear();

    Get.back();
    map.value[todo.date].value.taskList.forEach((element) {
      if(todo.seq == element.value.seq) {
        element.value.title = todo.title;
      }
    });
    // todoList.refresh();
    // loadTodoAndMemoList();
    map.refresh();
  }

  todoCopy() {
    todoRepository.copy(AuthService.to.user.value.seq,todayDateServerFormatted,checkYn: selectedOption.value);
  }

  todoRemove(String key,int index) async {
    await todoRepository.remove(map.value[key].value.taskList[index].value.seq);

    map.value[key].value.taskList.removeAt(index);

  }

  toggleCheckYn(String key,int index) async {

    final item = map.value[key].value.taskList[index];
    item.value.isCheck = !item.value.isCheck;

    await todoRepository.update(item.value);

    map.value[key].value.taskList[index].value.isCheck = item.value.isCheck;

    map.refresh();
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
      if(map.value.containsKey(todayDateServerFormatted)) {
        if(map.value[todayDateServerFormatted].value.memoList == null) {
          map.value[todayDateServerFormatted].value.memoList = <Rx<Memo>>[];
        }
        map.value[todayDateServerFormatted].value.memoList.add(Memo.fromJson(response.response).obs);
      } else {
        map.value[todayDateServerFormatted] = TaskAndMemo(taskList: <Rx<Task>>[], memoList: <Rx<Memo>>[Memo.fromJson(response.response).obs]).obs;
      }
      map.refresh();
    }
  }

  memoModify(Memo memo) async {
    memo.contents = titleEditingController.text;
    memo.isPublic = !isSecret.value;
    await memoRepository.update(memo);

    titleEditingController.clear();

    Get.back();
    map.value[memo.date].value.memoList.forEach((element) {
      if(memo.seq == element.value.seq) {
        element.value.contents = memo.contents;
      }
    });
    map.refresh();

  }

  memoRemove(String key,int index) async {

    await memoRepository.remove(map.value[key].value.memoList[index].value.seq);
    map.value[key].value.memoList.removeAt(index);

  }
  
  void loadTodoAndMemoList() async {

    var startDate = DateTime(now.value.year, now.value.month - 1, now.value.day);

    final response = await todoRepository.getTodoAndMemoList(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq,DateFormat('yyyyMMdd').format(startDate),todayDateServerFormatted);

    if (response.success == 'true') {
      // print('response.response!!!!');
      // print(response.response);

      // List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
      // Map<String,dynamic>
      map.value = (response.response as Map<String, dynamic>).obs;

      // map.forEach((key, value) {
      //   print('key  ${key}');
      //   print('value  ${value}');
      //   print('TaskAndMemo ${TaskAndMemo.fromJson(value)}');
      // });
      map.value.forEach((key, value) {
        map.value[key] = TaskAndMemo.fromJson(value).obs;
      });
      map.refresh();
      //TaskAndMemo.fromJson(response.response)
      // todoList.value = List<Rx<Task>>.from(response.response.map((x) => Task.fromJson(x).obs));
    }
  }

}
