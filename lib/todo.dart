import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/DBHelper.dart';
import 'list.dart';
import 'item.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:intl/intl.dart' as intl;
import 'DBHelper.dart';
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
        onPressed: () => {Navigator.pushNamed(context, '/insert')},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  String title = '';
  List<Item> items = <Item>[
    Item(seq: 1, isCheck: true, title: '출근하기'),
    Item(seq: 2, title: '점심먹기'),
    Item(seq: 3, title: '퇴근하기'),
    Item(seq: 4, isCheck: true, title: '아무것도안하기'),
  ];
  Future _countRecord() async {
    print('call _countRecord2');
    var items = await DBHelper().getItems();

    print(items);
    setState(() {
      this.items = items;
    });
  }

  // final List<int> colorCodes = <int>[600, 500, 100];

  Widget _buildListComposer() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () async {
              print('call _countRecord');
              await _countRecord();
            },
            leading: AspectRatio(
              aspectRatio: 0.5,
              child: Checkbox(
                value: items[index].isCheck,
                onChanged: (checked) {
                  setState(() {
                    items[index].isCheck = !items[index].isCheck;
                  });
                },
              ),
            ),
            title: Text(items[index].title,
                style: Theme.of(context).textTheme.headline6),
            trailing: IconButton(
                icon: Icon(Icons.note),
                onPressed: () => {
                      //Navigator.pushNamed(context, '/memo')
                    }),
          );

          // return Container(
          //   height: 50,
          //   color: Colors.amber[colorCodes[index%3]],
          //   child: Center(child: Text(entries[index])),
          // );
        });
  }
}

class TodoInsertScreen extends StatefulWidget {
  const TodoInsertScreen({Key? key}) : super(key: key);

  @override
  _TodoInsertScreenState createState() => _TodoInsertScreenState();
}

class _TodoInsertScreenState extends State<TodoInsertScreen> {

  bool isRepeat = false;
  final values = List.filled(7, true);
  final importanceValues = ['낮음','보통','중요','매우중요'];
  String importance = '보통';
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewChildren;
    listViewChildren = [
      const SizedBox(height: 12),
      // _Title(title: '필수입력사항'),
      _NormalInput(title: '할일'),
      const SizedBox(height: 20),
      _Title(title: '선택입력사항'),
      _NormalInput(title: '카테고리'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('중요도', style: Theme.of(context).textTheme.bodyText1),
          DropdownButton(
            value: importance,
            items: [
                for (int index = 0; index < importanceValues.length; index++)
                  DropdownMenuItem(
                  value: importanceValues[index],
                  child: Text(importanceValues[index]),
                  )
            ],
            onChanged: (value) {
              setState(() {
                importance = value.toString();
              });
            },
          ),
        ],
      ),
      _NormalInput(title: '세부사항'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('반복유무', style: Theme.of(context).textTheme.bodyText1),
          Switch(
            value: isRepeat,
            onChanged: (enabled) {
              setState(() {
                isRepeat = enabled;
              });
            },
          ),
        ],
      ),
      if (isRepeat)
         WeekdaySelector(
          shortWeekdays: <String>['일','월','화','수','목','금','토',],
          onChanged: (int day) {
            setState(() {
              final index = day % 7;
              values[index] = !values[index];
            });
          },
          values: values,
        ),
      _FormDatePicker<DateTime>(
        date: date,
        onChanged: (value) {
          setState(() {
            date = value;
          });
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('할일 등록'),
      ),
      body: SafeArea(
        child: Column(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, '/todo')},
        tooltip: 'Save',
        child: Text('저장'),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          constraints: BoxConstraints(),
          child: Text(this.title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
    );
  }
}

class _NormalInput extends StatelessWidget {
  final String title;

  const _NormalInput({
    Key? key,
    this.title = '',
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
            labelText: this.title,
          ),
        ),
      ),
    );
  }
}

class _TextAreaInput extends StatelessWidget {
  final String title;

  const _TextAreaInput({
    Key? key,
    this.title = '',
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
            labelText: this.title,
          ),
          maxLines: 5,
        ),
      ),
    );
  }
}
//
// class _CheckInput extends StatelessWidget {
//   final String title;
//   const _CheckInput({
//     Key? key,
//     this.title = '',
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         constraints: BoxConstraints(),
//         child: Checkbox(
//           value: items[index].isCheck,
//           onChanged: (checked) {
//             setState(() {
//               items[index].isCheck = !items[index].isCheck;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

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

class _FormDatePicker<T> extends StatefulWidget {
  final DateTime date;
  final ValueChanged<T> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  final format = intl.DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '마감일',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              format.format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('수정'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
