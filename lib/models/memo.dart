import 'package:json_annotation/json_annotation.dart';

part 'memo.g.dart';

/**
 * json 파싱하는법
 * part 'task.g.dart';
 * @JsonSerializable()
 * flutter pub run build_runner build
 * flutter pub run build_runner build --delete-conflicting-outputs

 * */
@JsonSerializable()
class Memo {
  final int seq;
  int userSeq;
  String contents;
  String date;
  bool isPublic;

  Memo({
    this.seq = -1,
    this.userSeq = -1,
    this.contents = '',
    this.date = '',
    this.isPublic = true,
  });

  Memo.insert(
    this.userSeq,
    this.contents,
    this.date,
  {
    this.seq = -1,
    this.isPublic = true
  });

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

  Map<String, dynamic> toJson() => _$MemoToJson(this);

  @override
  String toString() {
    return 'Memo{seq: $seq, contents: $contents, date: $date}';
  }
}
