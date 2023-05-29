import '../../../dependency_injection/locator.dart';
import '../repository/core_repository.dart';

class CreateTodoUseCase {
  CoreRepository repository = locator.get<CoreRepository>();

  Future<bool> call({required bool completed, required String title}) =>
      repository.createTodo(completed: completed, title: title);
}
