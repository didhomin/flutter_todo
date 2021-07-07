// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('로그인'),
          automaticallyImplyLeading: false),
      body: SafeArea(
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
    List<Widget> listViewChildren;
    listViewChildren = [
      _UsernameInput(),
      const SizedBox(height: 12),
      _PasswordInput(),
      ElevatedButton(
        child: Text('로그인'),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
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
            labelText: '이름',
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
