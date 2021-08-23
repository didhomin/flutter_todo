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
          Expanded(
            child:
              Align(
              alignment: Alignment.topCenter,
                child:  Obx(() => ListView.builder(
                  reverse: false,
                  shrinkWrap: true,
                  itemCount: controller.map.value.length,
                  itemBuilder: (context, index) {
                    int reverseIndex = controller.map.value.length - 1 - index;
                    final key = controller.map.value.keys.elementAt(reverseIndex);
                    return Column(
                      children: [
                        Divider(),
                        SizedBox(height: 10),
                        Chip(label: Text(key)),
                        SizedBox(height: 10),
                        if(controller.map.value[key].taskList != null) Text('할일목록'),
                        if(controller.map.value[key].taskList != null)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.map.value[key].taskList.length,
                            itemBuilder: (_, index) {
                              return Card(
                                  child: ListTile(
                                      title: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        children: [
                                          Text(controller.map.value[key].taskList[index].title,style : controller.map.value[key].taskList[index].isCheck ? TextStyle(decoration: TextDecoration.lineThrough): null),
                                          if(!controller.map.value[key].taskList[index].isPublic)Icon(Icons.lock),
                                        ],
                                      ),
                                      leading: Checkbox(
                                        value: controller.map.value[key].taskList[index].isCheck, onChanged: (bool? value) {  },
                                      ),
                                  )
                              );
                            }),
                        if(controller.map.value[key].taskList != null) Divider(),
                        if(controller.map.value[key].taskList != null) SizedBox(height: 10),
                        if(controller.map.value[key].memoList != null) Text('메모목록'),
                        if(controller.map.value[key].memoList != null) SizedBox(height: 10),
                        if(controller.map.value[key].memoList != null)
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.map.value[key].memoList.length,
                            itemBuilder: (_, index) {
                              return Card(
                                  child: ListTile(
                                      title: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        children: [
                                          Text("• "+controller.map.value[key].memoList[index].contents),
                                          if(!controller.map.value[key].memoList[index].isPublic)Icon(Icons.lock),
                                        ],
                                      )
                                  )
                              );
                            }),
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

}
