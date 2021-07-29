// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['seq'] as num,
    json['id'] as String,
    json['nickname'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
    };

Map<String, dynamic> _$UserToLoginJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'password': instance.password,
};
