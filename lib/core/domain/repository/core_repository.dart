import 'package:tasky/core/domain/model/todo.dart';

abstract class CoreRepository {
  //  get our todos
  Future<List<Todo>> getTodos({required bool? completed, required String search});

  //  create a _todo
  Future<bool> createTodo({required bool completed, required String title});

  //  update a _todo
  Future<bool> updateTodo({required bool completed, required String id, required String title});

  //  delete a _todo
  Future<bool> deleteTodo({required String id});
}
