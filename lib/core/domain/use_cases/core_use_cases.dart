import 'package:tasky/core/domain/use_cases/createTodoUseCase.dart';
import 'package:tasky/core/domain/use_cases/getTodosUseCase.dart';

/// Holds all our use cases in one class
class CoreUseCases {
  GetTodosUseCase getTodosUseCase;
  CreateTodoUseCase createTodoUseCase;

  CoreUseCases(
      {required this.getTodosUseCase, required this.createTodoUseCase});
}
