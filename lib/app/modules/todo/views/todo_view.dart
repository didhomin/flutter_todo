import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {displayInsertWindow()},
        tooltip: 'Insert',
        child: Icon(Icons.add),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: controller.loadDemoProductsFromSomeWhere,
      //   label: Text('Add'),
      // ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() =>
                Text(controller.todayDtm)
              ),
              TextButton(
                child: const Text('수정'),
                onPressed: () async {
                  var newDate = await showDatePicker(
                    context: context,
                    initialDate: controller.now.value,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  // Don't change the date if the date picker returns null.
                  if (newDate == null) {
                    return;
                  }
                  print('newDate : $newDate');
                  controller.changeDtm(newDate);
                },
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                child: const Text('복사'),
                onPressed: () async {
                  controller.copy();
                },
              ),
            ],
          ),

          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  controller.todoList.clear();
                  controller.loadTodoList();
                },
                child: ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    final item = controller.todoList[index];
                    return
                      Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key(item.seq.toString()),
                        direction:DismissDirection.endToStart,
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('$item dismissed  $direction')));
                          controller.todoList.removeAt(index);
                        },
                        background: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          color: Colors.green,
                          child: Text("수정",style: TextStyle(fontSize:20)),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Text("삭제",style: TextStyle(fontSize:20)),
                        ),
                        child: ListTile(
                          onTap: () {
                            print(item.seq);
                            Get.rootDelegate
                                .toNamed(Routes.TODO_DETAILS(item.seq.toString()));

                          },
                          title: Text(item.title),
                          subtitle: Text(item.date),
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

  void displayInsertWindow() {
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
                    // TextField(
                    //   decoration: InputDecoration(
                    //     labelText: '닉네임',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   controller: controller.joinNicknameEditingController,
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // TextField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     labelText: '비밀번호',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   controller: controller.joinPasswordEditingController,
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    ElevatedButton(
                      child: Text('등록'),
                      onPressed:  () async {
                        await controller.register();
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
