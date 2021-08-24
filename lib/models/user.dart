import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  int seq;
  String id;
  String? password;
  String? nickname;
  int? todayTodoTotalCount;
  int? todayTodoCheckedCount;
  String? tokenId;

  User(
  {
    this.seq = -1,
    this.id = '',
    this.nickname = null,
    this.password = null,
    this.todayTodoTotalCount = 0,
    this.todayTodoCheckedCount = 0,
    this.tokenId = null
  });

  User.join(
      this.id,
      this.password,{
      this.nickname = ''
  }) : this.seq = -1, this.todayTodoTotalCount = 0, this.todayTodoCheckedCount =0, this.tokenId = null;

  User.login(
      this.id,
      this.password) : this.seq = -1,this.nickname = '', this.todayTodoTotalCount = 0, this.todayTodoCheckedCount =0, this.tokenId = null;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{seq: $seq, id: $id, nickname: $nickname}';
  }
}
