import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/models/memo.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_and_memo.g.dart';


@JsonSerializable()
class TaskAndMemo {
  List<Task>? taskList;

  List<Memo>? memoList;

  TaskAndMemo({
    this.taskList = null,
    this.memoList = null,
  });

  factory TaskAndMemo.fromJson(Map<String, dynamic> json) => _$TaskAndMemoFromJson(json);

}
