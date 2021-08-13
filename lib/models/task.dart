import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

/**
 * json 파싱하는법
 * part 'task.g.dart';
 * @JsonSerializable()
 * flutter pub run build_runner build
 * flutter pub run build_runner build --delete-conflicting-outputs

 * */
@JsonSerializable()
class Task {
  final int seq;
  int userSeq;
  bool isCheck;
  String title;
  String date;
  // String contents;
  // String memo;

  Task({
    this.seq = -1,
    this.userSeq = -1,
    required this.title,
    this.date = '',
    this.isCheck = false
  });

  Task.insert(
    this.userSeq,
    this.title,
    this.date,
  {
    this.seq = -1,
    this.isCheck = false
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
  Map<String, dynamic> toJoinJson() => _$TaskToJoinJson(this);

  @override
  String toString() {
    return 'Task{seq: $seq, isCheck: $isCheck, title: $title, date: $date}';
  }
}

//우선순위
//카테고리
//반복유무
//월화수목금토일선택하게