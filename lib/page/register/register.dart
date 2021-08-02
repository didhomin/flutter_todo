
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/blocs/auth/authentication_bloc.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/util/routes_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/repositorys/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


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
    User user = User.empty;

    List<Widget> listViewChildren;
    listViewChildren = [
      _NormalInput('아이디'),
      const SizedBox(height: 12),
      _NormalInput('닉네임'),
      const SizedBox(height: 12),
      _PasswordInput(),
      ElevatedButton(
        child: Text('회원가입'),
        onPressed: () {
          // loginServices.getUser();
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogInRequested('didhomin', 'qwer1234'));
          // Navigator.pushReplacementNamed(context, RoutesPaths.todoListPage);
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

class _NormalInput extends StatelessWidget {

  final String title;

  const _NormalInput(this.title,{
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
            labelText: title,
          ),
          onChanged: (value) {

          },
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
