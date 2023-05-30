import '../../../dependency_injection/locator.dart';
import '../repository/core_repository.dart';

class UpdateTodoUseCase {
  CoreRepository repository = locator.get<CoreRepository>();

  Future<bool> call({required bool completed, required String id, required String title}) async {
    return await repository.updateTodo(completed: completed, id: id, title: title);
  }
}