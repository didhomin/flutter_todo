part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}
class AuthenticationLogInRequested extends AuthenticationEvent {
  const AuthenticationLogInRequested(this.id,this.password);

  final String id;
  final String password;

  @override
  List<Object> get props => [id,password];

}
class AuthenticationLogOutRequested extends AuthenticationEvent {}
