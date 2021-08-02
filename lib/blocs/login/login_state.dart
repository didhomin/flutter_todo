part of 'login_bloc.dart';

enum LoginStatus { unknown, error, success }


class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.unknown,
    this.username = '',
    this.password = '',
  });

  final LoginStatus status;
  final String username;
  final String password;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
