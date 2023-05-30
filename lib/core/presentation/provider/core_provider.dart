import 'package:flutter/widgets.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/domain/use_cases/core_use_cases.dart';
import 'package:tasky/dependency_injection/locator.dart';

class CoreProvider extends ChangeNotifier {
  var useCases = locator.get<CoreUseCases>();

  List<Todo> todos = [];

  List<Todo> get getAllTodos => todos;

  List<Todo> getCompletedTodos() {
    List<Todo> completed = todos.where((todo) => todo.completed == true).toList();
    return completed;
  }

  Future<List<Todo>> getTodos(
      {required bool completed, required String search}) async {
    var todos = await useCases.getTodosUseCase
        .call(completed: completed, search: search);

    this.todos = todos;
    notifyListeners();
    return todos;
  }

  Future<bool> createTodo(
      {required bool completed, required String title}) async {
    var res = await useCases.createTodoUseCase
        .call(completed: completed, title: title);
    return res;
  }

  Future<bool> updateTodo({required bool completed, required String id, required String title}) async {
    return await useCases.updateTodoUseCase.call(completed: completed, id: id, title: title);
  }

  Future<bool> deleteTodo({required String id}) async {
    return await useCases.deleteTodoUseCase.call(id: id);
  }
}






















