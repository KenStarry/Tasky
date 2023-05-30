import 'package:flutter/widgets.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/domain/use_cases/core_use_cases.dart';
import 'package:tasky/dependency_injection/locator.dart';

class CoreProvider extends ChangeNotifier {
  var useCases = locator.get<CoreUseCases>();

  List<Todo> incompleteTodos = [];
  List<Todo> allTodos = [];

  List<Todo> get getIncompleteTodos {

    incompleteTodos.sort((todo1, todo2) => todo1.title!.compareTo(todo2.title!));
    incompleteTodos.sort((todo1, todo2) =>
        todo1.completed.toString().compareTo(todo2.completed.toString()));

    return incompleteTodos;
  }

  List<Todo> get getAllTodos {

    allTodos.sort((todo1, todo2) => todo1.title!.compareTo(todo2.title!));
    allTodos.sort((todo1, todo2) =>
        todo1.completed.toString().compareTo(todo2.completed.toString()));

    return allTodos;
  }

  List<Todo> getCompletedTodos() {
    List<Todo> completed =
        allTodos.where((todo) {
          return todo.completed == true;
        }).toList();
    return completed;
  }

  Future<List<Todo>> getTodos(
      {required bool? completed, required String search}) async {
    var todos = await useCases.getTodosUseCase
        .call(completed: completed, search: search);

    todos.sort((todo1, todo2) => todo1.title!.compareTo(todo2.title!));
    todos.sort((todo1, todo2) =>
        todo1.completed.toString().compareTo(todo2.completed.toString()));

    completed == null ? allTodos = todos : incompleteTodos = todos;
    notifyListeners();
    return todos;
  }

  Future<Todo> createTodo(
          {required bool completed, required String title}) async {
    var createdTodo = await useCases.createTodoUseCase.call(completed: completed, title: title);
    incompleteTodos.add(createdTodo);
    allTodos.add(createdTodo);
    notifyListeners();
    return createdTodo;
  }

  Future<bool> updateTodo(
          {required bool completed,
          required String id,
          required String title}) async {

    incompleteTodos[incompleteTodos.indexWhere((element) => element.id == id)] = Todo(
      id: id, title: title, completed: completed
    );
    allTodos[allTodos.indexWhere((element) => element.id == id)] = Todo(
        id: id, title: title, completed: completed
    );
    notifyListeners();

    return await useCases.updateTodoUseCase
          .call(completed: completed, id: id, title: title);
  }

  Future<bool> deleteTodo({required Todo todo}) async {
    incompleteTodos.remove(todo);
    allTodos.remove(todo);
    notifyListeners();
    return await useCases.deleteTodoUseCase.call(id: todo.id!);
  }
}
