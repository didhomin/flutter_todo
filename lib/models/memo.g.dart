// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memo _$MemoFromJson(Map<String, dynamic> json) {
  return Memo(
    seq: json['seq'] as int,
    userSeq: json['userSeq'] as int,
    contents: json['contents'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$MemoToJson(Memo instance) => <String, dynamic>{
      'seq': instance.seq,
      'userSeq': instance.userSeq,
      'contents': instance.contents,
      'date': instance.date,
    };

Map<String, dynamic> _$MemoToJoinJson(Memo instance) => <String, dynamic>{
  'userSeq': instance.userSeq,
  'contents': instance.contents,
  'date': instance.date,
};