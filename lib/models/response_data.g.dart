// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData(
    json['success'] as String,
    json['response'] as Map<String, dynamic>,
    json['errorCode'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'response': instance.response,
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
