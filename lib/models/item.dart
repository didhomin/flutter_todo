import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

/**
 * json 파싱하는법
 * part 'item.g.dart';
 * @JsonSerializable()
 * flutter pub run build_runner build
 * flutter pub run build_runner build --delete-conflicting-outputs

 * */
@JsonSerializable()
class Item {
  final int seq;
  bool isCheck;
  String title;
  String contents;
  String memo;

  Item({
    required this.seq,
    this.isCheck = false,
    required this.title,
    this.contents = '',
    this.memo = '',
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  String toString() {
    return 'ItemDto{seq: $seq, isCheck: $isCheck, title: $title, contents: $contents, memo: $memo}';
  }
}

//우선순위
//카테고리
//반복유무
//월화수목금토일선택하게