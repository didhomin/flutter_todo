part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const HISTORY = _Paths.HOME + _Paths.HISTORY;

  static const SETTINGS = _Paths.SETTINGS;

  static const TODO_LIST = _Paths.HOME + _Paths.TODO + _Paths.LIST;
  static const TODO = _Paths.HOME + _Paths.TODO;
  static const TODO_INSERT = _Paths.HOME + _Paths.TODO + _Paths.INSERT;
  static String TODO_DETAILS(String todoSeq) => '$TODO/$todoSeq';
  static const LOGIN = _Paths.LOGIN;
  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static const DASHBOARD = _Paths.HOME + _Paths.DASHBOARD;
  static String TODO_USER(String userSeq) => '$DASHBOARD/$userSeq';
}

abstract class _Paths {
  static const HOME = '/home';
  static const TODO = '/todo';
  static const LIST = '/list';
  static const INSERT = '/insert';
  static const HISTORY = '/history';
  static const SETTINGS = '/settings';
  static const TODO_DETAILS = '/:todoSeq';
  static const TODO_USER = '/:userSeq';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
}
