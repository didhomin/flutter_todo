import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'list.dart';
class TodoScreen extends StatefulWidget {
  @override
  State createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("할일"),
      ),
      body: _buildListComposer(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  List<String> entries = <String>['출근하기', '점심먹기', '퇴근하기', '아무것도안하기' ];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget _buildListComposer() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: AspectRatio(
              aspectRatio: 0.5,
              child: Checkbox(
                value: index%3 == 0,
                onChanged: (checked) {
                  setState(() {

                  });
                },
              ),
            ),
            title: Text(entries[index], style: Theme.of(context).textTheme.headline6),
            trailing: IconButton(
                icon: Icon(Icons.note),
                onPressed: () => {}),
          );


          // return Container(
          //   height: 50,
          //   color: Colors.amber[colorCodes[index%3]],
          //   child: Center(child: Text(entries[index])),
          // );
        }
    );
  }


}

// return Dismissible(
// key: Key(entries[index]),
// onDismissed: (direction) {
// setState(() {
// entries.removeAt(index);
// });
// Scaffold.of(context)
//     .showSnackBar(SnackBar(content: Text("dismissed")));
// },
// background: Container(
// color: Colors.red,
// child: Icon(Icons.delete),
// ),
// child: Card(
// margin: EdgeInsets.all(20),
// child: Text(entries[index]),
// ));