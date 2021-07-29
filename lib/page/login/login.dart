
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/blocs/auth/authentication_bloc.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/util/routes_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state.user != User.empty) {
          Navigator.pushReplacementNamed(context,RoutesPaths.todoListPage);
        }
      },
      child: SafeArea(
        child: _MainView(),
      ),
    );
  }

}

class _MainView extends StatelessWidget {

  const _MainView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AuthServices authServices = AuthServices();
    List<Widget> listViewChildren;
    listViewChildren = [
      _UsernameInput(),
      const SizedBox(height: 12),
      _PasswordInput(),
      ElevatedButton(
        child: Text('로그인'),
        onPressed: () {
          // loginServices.getUser();
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogInRequested('didhomin', 'qwer1234'));
          // Navigator.pushReplacementNamed(context, RoutesPaths.todoListPage);
        },
      ),
      ElevatedButton(
        child: Text('회원가입'),
        onPressed: () {
          Navigator.pushNamed(context, RoutesPaths.registerPage);
        },
      ),
    ];

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              restorationId: 'login_list_view',
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: listViewChildren,
            ),
          ),
        ),
      ],
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(),
        child: TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: '아이디',
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(),
        child: TextField(
          decoration: InputDecoration(
            labelText: '비밀번호',
          ),
          obscureText: true,
        ),
      ),
    );
  }
}
