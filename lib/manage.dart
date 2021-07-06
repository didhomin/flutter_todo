import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'list.dart';
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
      body: Column( // 컬럼으로 교체
        // 자식들을 추가
        children: <Widget>[
          _buildTextComposer(),
          _buildListComposer(),
        ],
      ),
    );
  }
  List<String> entries = <String>['메일 확인', '일감 확인', '인강 30분', '운동 30분', '독서 30분' ];
  final List<int> colorCodes = <int>[600, 500, 100];
  Widget _buildListComposer() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
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
            title: Text(entries[index], style: Theme.of(context).textTheme.headline6),
            trailing: IconButton(
                icon: Icon(Icons.highlight_off_outlined),
                onPressed: () =>
                    _handleRemoved(entries[index])),
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
                        onPressed: () =>
                            _handleSubmitted(_textController.text)),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _handleSubmitted(String text) {
    if(text == '') {
      return;
    }
    entries.add(text);
    _textController.clear();
    setState(() {});
  }

  void _handleRemoved(String text) {
    entries.remove(text);
    setState(() {});
  }
}
