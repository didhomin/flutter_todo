import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/auth/authentication_bloc.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

Future<void> main() async {

  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(authRepository: AuthRepository());
      },
      child: TodoApp(),
    ),

  );
}
