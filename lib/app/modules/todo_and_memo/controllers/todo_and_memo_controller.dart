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

  String get todayDtm => '${now.value.year}년 ${now.value.month}월 ${now.value.day}일';
  String get todayDateServerFormatted => DateFormat('yyyyMMdd').format(now.value);

  @override
  void onInit() async {
    super.onInit();
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

  void loadTodoAndMemoList() async {

    var startDate = DateTime(now.value.year, now.value.month - 1, now.value.day);

    final response = await todoRepository.getTodoAndMemoList(userSeq.isNum ? int.parse(userSeq) : AuthService.to.user.value.seq,DateFormat('yyyyMMdd').format(startDate),todayDateServerFormatted);

    if (response.success == 'true') {
      print('response.response!!!!');
      print(response.response);

      // List<Rx<Memo>>.from(response.response.map((x) => Memo.fromJson(x).obs));
      // Map<String,dynamic>
      map.value = (response.response as Map<String, dynamic>).obs;

      // map.forEach((key, value) {
      //   print('key  ${key}');
      //   print('value  ${value}');
      //   print('TaskAndMemo ${TaskAndMemo.fromJson(value)}');
      // });
      map.value.forEach((key, value) {
        map.value[key] = TaskAndMemo.fromJson(value);
      });
      map.refresh();
      //TaskAndMemo.fromJson(response.response)
      // todoList.value = List<Rx<Task>>.from(response.response.map((x) => Task.fromJson(x).obs));
    }
  }

}
