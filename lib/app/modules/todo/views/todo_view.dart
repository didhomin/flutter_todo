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
          Text(controller.todayDtm),
          // Hero(
          //   tag: 'heroLogo',
          //   child: const FlutterLogo(),
          // ),
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
                    return ListTile(
                      // onTap: () {
                      //   Get.rootDelegate
                      //       .toNamed(Routes.TODO_DETAILS(item.seq.toString()));
                      // },
                      title: Text(item.title),
                      subtitle: Text(item.date),
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
