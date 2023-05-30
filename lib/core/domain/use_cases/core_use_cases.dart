import 'package:tasky/core/domain/use_cases/createTodoUseCase.dart';
import 'package:tasky/core/domain/use_cases/getTodosUseCase.dart';
import 'package:tasky/core/domain/use_cases/update_todo_use_case.dart';

import 'delete_todo_use_case.dart';

/// Holds all our use cases in one class
class CoreUseCases {
  GetTodosUseCase getTodosUseCase;
  CreateTodoUseCase createTodoUseCase;
  UpdateTodoUseCase updateTodoUseCase;
  DeleteTodoUseCase deleteTodoUseCase;

  CoreUseCases(
      {required this.getTodosUseCase,
      required this.createTodoUseCase,
      required this.updateTodoUseCase,
      required this.deleteTodoUseCase});
}
