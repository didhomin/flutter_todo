part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.user = User.empty,
  });


  const AuthenticationState._({
    this.user = User.empty,
  });

  const AuthenticationState.authenticated(User user)
      : this._(user: user);

  final User user;

  @override
  List<Object> get props => [user];
}
