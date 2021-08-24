// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_and_memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskAndMemo _$TaskAndMemoFromJson(Map<String, dynamic> json) {
  return TaskAndMemo(
    // taskList: json['todoList'] == null ? null : List<Task>.from(json['todoList'].map((x) => Task.fromJson(x))),
    // memoList: json['memoList'] == null ? null : List<Memo>.from(json['memoList'].map((x) => Memo.fromJson(x))),
    taskList: json['todoList'] == null ? null : List<Rx<Task>>.from(json['todoList'].map((x) => Task.fromJson(x).obs)),
    memoList: json['memoList'] == null ? null : List<Rx<Memo>>.from(json['memoList'].map((x) => Memo.fromJson(x).obs)),
  );
}

