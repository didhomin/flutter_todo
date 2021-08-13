import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  final int seq;
  final String id;
  final String? password;
  final String? nickname;
  final int? todayTodoTotalCount;
  final int? todayTodoCheckedCount;

  const User(
    this.seq,
    this.id,
    this.nickname,
  {
    this.password = '',
    this.todayTodoTotalCount = 0,
    this.todayTodoCheckedCount = 0,
  });

  const User.join(
      this.id,
      this.password,{
      this.nickname = ''
  }) : this.seq = -1, this.todayTodoTotalCount = 0, this.todayTodoCheckedCount =0;

  const User.login(
      this.id,
      this.password) : this.seq = -1,this.nickname = '', this.todayTodoTotalCount = 0, this.todayTodoCheckedCount =0;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static const empty = User(-1,'','');

  @override
  String toString() {
    return 'User{seq: $seq, id: $id, nickname: $nickname}';
  }
}
