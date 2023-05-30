import 'package:tasky/core/domain/model/todo.dart';

import '../../../dependency_injection/locator.dart';
import '../repository/core_repository.dart';

class CreateTodoUseCase {
  CoreRepository repository = locator.get<CoreRepository>();

  Future<Todo> call({required bool completed, required String title}) =>
      repository.createTodo(completed: completed, title: title);
}
