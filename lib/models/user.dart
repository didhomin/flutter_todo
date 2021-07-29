import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  final num seq;
  final String id;
  final String password;
  final String nickname;

  const User(
    this.seq,
    this.id,
    this.nickname,
  {
    this.password = '',
  });

  const User.login(
      this.id,
      this.password) : this.seq = -1,this.nickname = '';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  Map<String, dynamic> toLoginJson() => _$UserToLoginJson(this);

  static const empty = User(-1,'','');

  @override
  String toString() {
    return 'User{seq: $seq, id: $id, nickname: $nickname}';
  }
}
