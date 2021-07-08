import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'list.dart';
import 'item.dart';
import 'DBHelper.dart';
class ManageScreen extends StatefulWidget {
  @override
  State createState() => ManageScreenState();
}

class ManageScreenState extends State<ManageScreen> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("할일 관리"),
      ),
      body: Column(
        children: <Widget>[
          _buildTextComposer(),
          _buildListComposer(),
        ],
      ),
    );
  }
  List<Item> items = <Item>[
    Item(seq :1,isCheck: true, title:'출근하기'),
    Item(seq :2,title:'점심먹기'),
    Item(seq :3,title:'퇴근하기'),
    Item(seq :4,isCheck: true,title:'아무것도안하기'),
  ];
  Widget _buildListComposer() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            // leading: AspectRatio(
            //   aspectRatio: 0.5,
            //   child: Checkbox(
            //     value: true,
            //     onChanged: (checked) {
            //       setState(() {
            //
            //       });
            //     },
            //   ),
            // ),
            title: Text(items[index].title, style: Theme.of(context).textTheme.headline6),
            trailing: IconButton(
                icon: Icon(Icons.highlight_off_outlined),
                onPressed: () =>
                    _handleRemoved(index)),
          );

          // return Container(
          //   height: 50,
          //   color: Colors.amber[colorCodes[index%3]],
          //   child: Center(child: Text(entries[index])),
          // );
        }
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      decoration:
                          new InputDecoration.collapsed(hintText: "입력해 주세요."),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed:  () async =>
                            _handleSubmitted(_textController.text)),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Future _handleSubmitted (String text) async {
    if(text == '') {
      return;
    }
    items.add(Item(seq:items.length,title:text));
    await DBHelper().insertRow(text);
    _textController.clear();
    setState(() {});
  }

  void _handleRemoved(int index) {
    items.removeAt(index);
    setState(() {});
  }
}
