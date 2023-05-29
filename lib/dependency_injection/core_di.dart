import 'package:get_it/get_it.dart';
import 'package:tasky/core/data/repository/core_repository_impl.dart';
import 'package:tasky/core/domain/repository/core_repository.dart';
import 'package:tasky/core/domain/use_cases/core_use_cases.dart';
import 'package:tasky/core/domain/use_cases/createTodoUseCase.dart';
import 'package:tasky/core/domain/use_cases/getTodosUseCase.dart';

void coreDI({required GetIt locator}) {
  //  provide our repository implementation
  locator.registerLazySingleton<CoreRepository>(() => CoreRepositoryImpl());

  //  providing our core use cases
  locator.registerLazySingleton<CoreUseCases>(() => CoreUseCases(
      getTodosUseCase: GetTodosUseCase(),
      createTodoUseCase: CreateTodoUseCase()));
}
