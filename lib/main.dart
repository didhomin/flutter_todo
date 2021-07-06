import 'package:flutter/material.dart';
import 'manage.dart';
import 'list.dart';
import 'todo.dart';
void main() {
  runApp(MaterialApp(
    title: 'HOMIN',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/manage': (context) => ManageScreen(),
      '/todo': (context) => TodoScreen(),
      '/history': (context) => ListDemo(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homin\'s todo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Text('manage'),
            onPressed: () {
              // Named route를 사용하여 두 번째 화면으로 전환합니다.
              Navigator.pushNamed(context, '/manage');
            },
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            child: Text('todo'),
            onPressed: () {
              // Named route를 사용하여 두 번째 화면으로 전환합니다.
              Navigator.pushNamed(context, '/todo');
            },
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            child: Text('history'),
            onPressed: () {
              // Named route를 사용하여 두 번째 화면으로 전환합니다.
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
    );
  }
}

// class TodoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("TODO"),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               child: Text('TODO'),
//               onPressed: () {
//                 // Named route를 사용하여 두 번째 화면으로 전환합니다.
//                 Navigator.pushNamed(context, '/todo');
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
