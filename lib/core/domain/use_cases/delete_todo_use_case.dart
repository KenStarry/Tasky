import '../../../dependency_injection/locator.dart';
import '../repository/core_repository.dart';

class DeleteTodoUseCase {

  CoreRepository repository = locator.get<CoreRepository>();

  Future<bool> call({required String id}) async {
    return await repository.deleteTodo(id: id);
  }
}