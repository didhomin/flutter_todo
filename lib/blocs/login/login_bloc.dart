import 'dart:async';

import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState());

  final AuthRepository _authRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      print('LoginUsernameChanged');
      print(event);
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = event.username;
    return state.copyWith(
      username: username,
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = event.password;
    return state.copyWith(
      password: password,
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    print('_mapLoginSubmittedToState');
    // if (state.status == LoginStatus.success) {
      // yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authRepository.logIn(
          state.username,
          state.password,
        );
        yield state.copyWith(status: LoginStatus.success);
      } on Exception catch (_) {
        print(_.toString());
        // yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    // }
  }
}
