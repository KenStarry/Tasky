import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/domain/repository/core_repository.dart';
import 'package:tasky/dependency_injection/locator.dart';

class GetTodosUseCase {
  CoreRepository repository = locator.get<CoreRepository>();

  Future<List<Todo>> call(
          {required bool completed, required String search}) async =>
      await repository.getTodos(completed: completed, search: search);
}
