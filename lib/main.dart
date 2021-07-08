import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'manage.dart';
import 'list.dart';
import 'todo.dart';
import 'login.dart';
void main() {
  runApp(MaterialApp(
    title: 'HOMIN',
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('ko', 'KR'),

    ],
    // locale: Locale('ko'),
    theme: ThemeData(
      // primarySwatch: Colors.teal,
      // 상호작용 요소에 사용되는 색상
      // brightness: Brightness.light,
      //
      // 앱의 주요부분 배경 색 (앱바, 탭바 등)
      // primaryColor: Colors.greenAccent,
      //
      // 위젯의 전경색
      // accentColor: Colors.redAccent,

      // 앱에 기본으로 사용될 폰트
      // fontFamily: 'IBM-Sans'
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
      '/manage': (context) => ManageScreen(),
      '/todo': (context) => TodoScreen(),
      '/history': (context) => ListScreen(),
      '/insert': (context) => TodoInsertScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homin\'s todo'),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/manage');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '양호민',
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                ElevatedButton(
                  child: Text('todo'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/todo');
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  child: Text('history'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                ),
                const SizedBox(width: 5),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아이유',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                ElevatedButton(
                  child: Text('todo'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/todo');
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  child: Text('history'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}