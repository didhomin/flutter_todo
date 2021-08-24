// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    seq: json['seq'] as int,
    userSeq: json['userSeq'] as int,
    isCheck: json['checkYn'] as bool,
    isPublic: json['publicYn'] as bool,
    title: json['title'] as String,
    date: json['date'] as String,
    // contents: json['contents'] as String,
    // memo: json['memo'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'seq': instance.seq,
      'checkYn': instance.isCheck,
      'publicYn': instance.isPublic,
      'title': instance.title,
    };

Map<String, dynamic> _$TaskToJoinJson(Task instance) => <String, dynamic>{
  'userSeq': instance.userSeq,
  'title': instance.title,
  'date': instance.date,
  'publicYn': instance.isPublic,
};
