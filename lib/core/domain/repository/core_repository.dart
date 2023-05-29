import 'package:tasky/core/domain/model/todo.dart';

abstract class CoreRepository {
  //  get our todos
  Future<List<Todo>> getTodos({required bool completed, required String search});

  //  create a todo
  Future<bool> createTodo({required bool completed, required String title});
}
