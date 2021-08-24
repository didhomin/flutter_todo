import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/modules/todo/controllers/todo_controller.dart';
import 'package:flutter_app/app/modules/todo_and_memo/controllers/todo_and_memo_controller.dart';
import 'package:flutter_app/models/memo.dart';
import 'package:flutter_app/models/task.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TodoAndMemoView extends GetWidget<TodoAndMemoController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.userSeq.isNum ? null :
      Obx(() =>
          FloatingActionButton.extended(
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(tooltip: '할일등록', onPressed: () {
                  controller.floatExtended.toggle();
                  displayTodoInsertWindow(Task(title: ''));
                }, icon: Icon(Icons.check_box)),
                IconButton(tooltip: '메모등록',onPressed: () {
                  controller.floatExtended.toggle();
                  displayMemoInsertWindow(Memo(contents: ''));
                }, icon: Icon(Icons.note)),

              ],
            ),
            isExtended: controller.floatExtended.value,
            icon: Icon(
              controller.floatExtended.value == true ? Icons.close : Icons.add,
              color: controller.floatExtended.value == true ? Colors.red : Colors.white,
            ),
            onPressed: () {
              controller.floatExtended.toggle();
            },
          ),
      ),
      body: Column(
        children: [
          if(Get.rootDelegate.currentConfiguration!
              .currentPage!.arguments != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${Get.rootDelegate.currentConfiguration!
                    .currentPage!.arguments}')
              ]
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {
                controller.changeDtm(controller.now.value.add(const Duration(days: -1)));
              }, icon: Icon(Icons.keyboard_arrow_left)),
              Obx(() =>
                Text(controller.todayDtm)
              ),
              TextButton(
                  child: const Text('날짜변경'),
                onPressed: () async {
                  var newDate = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    context: context,
                    initialDate: controller.now.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (newDate == null) {
                    return;
                  }
                  controller.changeDtm(newDate);
                },
              ),
              IconButton(onPressed: () {
                controller.changeDtm(controller.now.value.add(const Duration(days: 1)));
              }, icon: Icon(Icons.keyboard_arrow_right)),
            ],
          ),
          if(!controller.userSeq.isNum)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('다음날로  '),
                Obx(
                        () => DropdownButton(
                      value: controller.selectedOption.value,
                      items: controller.optionList.map(
                              (option){
                            return DropdownMenuItem(
                              value: option.code,
                              child: Text(option.label),
                            );
                          }).toList(),
                      onChanged: (value) {
                        controller.selectedOption.value = value.toString();
                      },
                    )),
                TextButton(
                  child: const Text('복사'),
                  onPressed: () async {
                    controller.todoCopy();
                  },
                ),
                Tooltip(message: '다음날로 복사하는 기능입니다. 전체복사 , 체크된것만복사 , 미체크된것만복사 총 세가지 옵션이 있습니다.',child: Icon(Icons.info_rounded))
              ],
            ),
          Expanded(
            child:
              Align(
              alignment: Alignment.topCenter,
                child:  Obx(() => controller.map.value.length == 0 ?
                Center(child:Text('등록된 할일이 없습니다.'))
                    : ListView.builder(
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: controller.map.value.length,
                  itemBuilder: (context, index) {
                    int reverseIndex = controller.map.value.length - 1 - index;
                    final key = controller.map.value.keys.elementAt(reverseIndex);
                    final todoAndMemo = controller.map.value[key].value;
                    return Column(
                      children: [
                        Divider(),
                        SizedBox(height: 10),
                        Chip(label: Text('${key.substring(0,4)}년 ${key.substring(4,6)}월 ${key.substring(6,8)}일')),
                        SizedBox(height: 10),
                        // if(controller.map.value[key].taskList != null) Text('할일목록'),
                        if(todoAndMemo.taskList != null)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: todoAndMemo.taskList.length,
                            itemBuilder: (_, index) {
                              final item = todoAndMemo.taskList[index].value;
                              return Card(
                                  child: Dismissible(
                                  // Each Dismissible must contain a Key. Keys allow Flutter to
                                  // uniquely identify widgets.
                                  key: Key(item.seq.toString()),
                                  direction: controller.userSeq.isNum ? DismissDirection.none : DismissDirection.endToStart,
                                  // Provide a function that tells the app
                                  // what to do after an item has been swiped away.
                                  onDismissed: (direction) {
                                  controller.todoRemove(key,index);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('${item.title} 삭제완료.')));
                                  },
                                  background: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: Text("삭제",style: TextStyle(fontSize:20)),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      if(!controller.userSeq.isNum) {
                                        displayTodoInsertWindow(item);
                                      }
                                    },
                                    onLongPress: (){
                                      Clipboard.setData(new ClipboardData(text:item.title));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('\'${item.title}\' 복사완료.')));
                                    },
                                    title: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: [
                                        Text(item.title,style : item.isCheck ? TextStyle(decoration: TextDecoration.lineThrough): null),
                                        if(!item.isPublic)Icon(Icons.lock),
                                      ],
                                    ),
                                    leading: Checkbox(
                                      value: item.isCheck,
                                      onChanged: (value) {
                                        if(!controller.userSeq.isNum) {
                                          controller.toggleCheckYn(key,index);
                                        }
                                      },
                                    ),
                                      )
                                  )
                              );
                            }),
                        if(todoAndMemo.taskList != null && todoAndMemo.memoList != null && todoAndMemo.taskList.isNotEmpty && todoAndMemo.memoList.isNotEmpty) SizedBox(height: 10),
                        if(todoAndMemo.taskList != null && todoAndMemo.memoList != null && todoAndMemo.taskList.isNotEmpty && todoAndMemo.memoList.isNotEmpty) Divider(),
                        if(todoAndMemo.taskList != null && todoAndMemo.memoList != null && todoAndMemo.taskList.isNotEmpty && todoAndMemo.memoList.isNotEmpty) SizedBox(height: 10),
                        // if(controller.map.value[key].memoList != null) Text('메모목록'),
                        // if(controller.map.value[key].memoList != null) SizedBox(height: 10),
                        if(todoAndMemo.memoList != null)
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: todoAndMemo.memoList.length,
                              itemBuilder: (_, index) {
                                final item = todoAndMemo.memoList[index].value;
                                return Card(
                                    child: Dismissible(
                                      // Each Dismissible must contain a Key. Keys allow Flutter to
                                      // uniquely identify widgets.
                                        key: Key(item.seq.toString()),
                                        direction: controller.userSeq.isNum ? DismissDirection.none : DismissDirection.endToStart,
                                        // Provide a function that tells the app
                                        // what to do after an item has been swiped away.
                                        onDismissed: (direction) {
                                          controller.memoRemove(key,index);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text('${item.contents} 삭제완료.')));
                                        },
                                        background: Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerRight,
                                          color: Colors.red,
                                          child: Text("삭제",style: TextStyle(fontSize:20)),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            if(!controller.userSeq.isNum) {
                                              displayMemoInsertWindow(item);
                                            }
                                          },
                                          onLongPress: (){
                                            Clipboard.setData(new ClipboardData(text:item.contents));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(content: Text('\'${item.contents}\' 복사완료.')));
                                          },
                                          title: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            children: [
                                              Text("• "+item.contents),
                                              if(!item.isPublic)Icon(Icons.lock),
                                            ],
                                          ),
                                        )
                                    )
                                );
                              }),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     itemCount: controller.map.value[key].memoList.length,
                        //     itemBuilder: (_, index) {
                        //       return Card(
                        //           child: ListTile(
                        //               title: Wrap(
                        //                 crossAxisAlignment: WrapCrossAlignment.start,
                        //                 children: [
                        //                   Text("• "+controller.map.value[key].memoList[index].contents),
                        //                   if(!controller.map.value[key].memoList[index].isPublic)Icon(Icons.lock),
                        //                 ],
                        //               )
                        //           )
                        //       );
                        //     }),
                        SizedBox(height: 10),
                      ],
                    );


                      // ListTile(
                      //     onTap: () {
                      //       if(!controller.userSeq.isNum) {
                      //         displayTodoInsertWindow(item.value);
                      //       }
                      //     },
                      //     onLongPress: (){
                      //       Clipboard.setData(new ClipboardData(text:item.value.title));
                      //       ScaffoldMessenger.of(context)
                      //           .showSnackBar(SnackBar(content: Text('\'${item.value.title}\' 복사완료.')));
                      //     },
                      //     title: Wrap(
                      //       crossAxisAlignment: WrapCrossAlignment.start,
                      //       children: [
                      //         Text(item.value.title,style : item.value.isCheck ? TextStyle(decoration: TextDecoration.lineThrough): null),
                      //         if(!item.value.isPublic)Icon(Icons.lock),
                      //       ],
                      //     ),
                      //     // subtitle: Text(item.value.date),
                      //     leading: Checkbox(
                      //       value: item.value.isCheck,
                      //       onChanged: (value) {
                      //         if(!controller.userSeq.isNum) {
                      //           controller.toggleCheckYn(index);
                      //         }
                      //       },
                      //     ),
                      //
                      // );
                  },
                ),
              ),
          ),
          ),
        ],
      ),
    );
  }
  void displayTodoInsertWindow(Task task) {
    controller.titleEditingController.text = task.title;
    controller.isSecret.value = !task.isPublic;

    Get.bottomSheet(
      Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '제목',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.titleEditingController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      Text('비공개'),
                      Obx(()=>
                          Checkbox(
                            value: controller.isSecret.value,
                            onChanged: (value) {
                              controller.isSecret.toggle();
                            },
                          ),
                      ),
                    ],),
                    SizedBox(
                      height: 8,
                    ),
                    task.seq == -1 ?
                    ElevatedButton(
                      child: Text('등록'),
                      onPressed:  () async {
                        await controller.todoRegister();
                      },
                    )
                        :
                    ElevatedButton(
                      child: Text('수정'),
                      onPressed:  () async {
                        await controller.todoModify(task);
                      },
                    ),
                  ],
                ),
              ],
            )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
      ),
    );
  }

  void displayMemoInsertWindow(Memo memo) {
    controller.titleEditingController.text = memo.contents;
    controller.isSecret.value = !memo.isPublic;
    Get.bottomSheet(
      Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '내용',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.titleEditingController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      Text('비공개'),
                      Obx(()=>
                          Checkbox(
                            value: controller.isSecret.value,
                            onChanged: (value) {
                              controller.isSecret.toggle();
                            },
                          ),
                      ),
                    ],),
                    SizedBox(
                      height: 8,
                    ),
                    memo.seq == -1 ?
                    ElevatedButton(
                      child: Text('등록'),
                      onPressed:  () async {
                        await controller.memoRegister();
                      },
                    )
                        :
                    ElevatedButton(
                      child: Text('수정'),
                      onPressed:  () async {
                        await controller.memoModify(memo);
                      },
                    ),
                  ],
                ),
              ],
            )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
      ),
    );
  }
}
