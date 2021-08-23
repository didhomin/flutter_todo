// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['seq'] as int,
    json['id'] as String,
    json['nickname'] as String?,
    password: json['password'] as String?,
    todayTodoTotalCount : json['todayTodoTotalCount'] as int?,
    todayTodoCheckedCount : json['todayTodoCheckedCount'] as int?,
    tokenId: json['tokenId'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'seq': instance.seq,
      'id': instance.id,
      'password': instance.password,
      'nickname': instance.nickname,
    };
