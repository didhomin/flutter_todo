import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';
@JsonSerializable()
class ResponseData {
  final String success;
  final Map<String, dynamic> response;
  final String errorCode;
  final String message;

  const ResponseData(
    this.success,
    this.response,
    this.errorCode,
    this.message,
  );

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  @override
  String toString() {
    return 'ResponseDto{success: $success, errorCode: $errorCode, message: $message, response: $response}';
  }
}