import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/repositorys/todo_repository.dart';
import 'package:get/get.dart';

class TodoDetailsController extends GetxController {
  final String todoSeq;

  TodoRepository todoRepository;

  TodoDetailsController(this.todoSeq,this.todoRepository);

  final todo = Task(title:'').obs;

  @override
  void onReady() {
    super.onReady();
    loadTodo();
  }
  void loadTodo() async {
    final response = await todoRepository.getDetail(this.todoSeq);

    print('responseData ${response.toString()}');
    if (response.success == 'true') {
      print('response.response ::: ${response.response}');

      todo.value = Task.fromJson(response.response);

      // todoList.value  = Task.fromJson(response.response!);

    }
  }
}
