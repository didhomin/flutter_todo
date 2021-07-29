import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthenticationState());

  final AuthRepository _authRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationLogInRequested) {
      User user = await _authRepository.logIn(event.id,event.password);
      yield AuthenticationState(user: user);
    } else if (event is AuthenticationLogOutRequested) {
      await _authRepository.logOut();
      yield AuthenticationState();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

}
