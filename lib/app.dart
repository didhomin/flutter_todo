import 'package:flutter/material.dart';
import 'package:flutter_app/page/login/login.dart';
import 'package:flutter_app/page/register/register.dart';
import 'package:flutter_app/page/todo/todo.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:flutter_app/util/routes_paths.dart';
import 'package:flutter_app/page/base/page_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login/login_bloc.dart';

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: RoutesPaths.loginPage,
      routes: {
        RoutesPaths.loginPage: (context) {
          return BlocProvider(
            create: (context) {
              return LoginBloc(
                authRepository: AuthRepository(),
              );
            },
            child: PageContainer(pageTitle: 'TODO',body:LoginScreen(),isMenu: false,),
          );
        },
        RoutesPaths.registerPage: (context) =>
            PageContainer(pageTitle: '회원가입',body: RegisterScreen(),isMenu: false,),
        RoutesPaths.rootPage: (context) =>
            PageContainer(pageTitle: 'title',body: Text('root')),
        RoutesPaths.todoListPage: (context) =>
            PageContainer(pageTitle: 'TODO List',body: TodoScreen()),

      },
    );
  }
}
