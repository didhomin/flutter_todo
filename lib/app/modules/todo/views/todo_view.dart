import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/memo.dart';
import 'package:flutter_app/models/task.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {

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
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  controller.todoList.clear();
                  controller.loadTodoList();
                },
                child:  controller.todoList.length == 0 ?
                Center(child:Text('등록된 할일이 없습니다.'))
                    : ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    final item = controller.todoList[index];
                    return
                      Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key(item.value.seq.toString()),
                        direction: controller.userSeq.isNum ? DismissDirection.none : DismissDirection.endToStart,
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          controller.todoRemove(index);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('${item.value.title} 삭제완료.')));
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
                              displayTodoInsertWindow(item.value);
                            }
                          },
                          onLongPress: (){
                            Clipboard.setData(new ClipboardData(text:item.value.title));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('\'${item.value.title}\' 복사완료.')));
                          },
                          title: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Text(item.value.title,style : item.value.isCheck ? TextStyle(decoration: TextDecoration.lineThrough): null),
                              if(!item.value.isPublic)Icon(Icons.lock),
                            ],
                          ),
                          // subtitle: Text(item.value.date),
                          leading: Checkbox(
                            value: item.value.isCheck,
                            onChanged: (value) {
                              if(!controller.userSeq.isNum) {
                                controller.toggleCheckYn(index);
                              }
                            },
                          ),
                        ),
                      );
                  },

                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Obx(
                  () => RefreshIndicator(
                onRefresh: () async {
                  controller.memoList.clear();
                  controller.loadMemoList();
                },
                child: controller.memoList.length == 0 ?
                Center(child:Text('등록된 메모가 없습니다.'))
                  : ListView.builder(
                  itemCount: controller.memoList.length,
                  itemBuilder: (context, index) {
                    final item = controller.memoList[index];
                    return
                      Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key(item.value.seq.toString()),
                        direction: controller.userSeq.isNum ? DismissDirection.none : DismissDirection.endToStart,
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          controller.memoRemove(index);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('${item.value.contents} 삭제완료.')));
                        },
                        background: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Text("삭제",style: TextStyle(fontSize:20)),
                        ),
                        child: ListTile(
                          // tileColor: Color.fromARGB(102, 173, 255, 150),
                          onTap: () {
                            if(!controller.userSeq.isNum) {
                              displayMemoInsertWindow(item.value);
                            }
                          },
                          onLongPress: (){
                            Clipboard.setData(new ClipboardData(text:item.value.contents));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('\'${item.value.contents}\' 복사완료.')));
                          },
                          title: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Text("• "+item.value.contents),
                              if(!item.value.isPublic)Icon(Icons.lock),
                            ],
                          ),
                        ),
                      );
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
