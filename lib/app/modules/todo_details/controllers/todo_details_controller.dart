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

    if (response.success == 'true') {
      todo.value = Task.fromJson(response.response);
    }
  }
}
