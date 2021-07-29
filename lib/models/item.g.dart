// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    seq: json['seq'] as int,
    isCheck: json['isCheck'] as bool,
    title: json['title'] as String,
    contents: json['contents'] as String,
    memo: json['memo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'seq': instance.seq,
      'isCheck': instance.isCheck,
      'title': instance.title,
      'contents': instance.contents,
      'memo': instance.memo,
    };
