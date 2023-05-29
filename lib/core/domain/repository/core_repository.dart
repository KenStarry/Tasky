import 'package:tasky/core/domain/model/todo.dart';

abstract class CoreRepository {
  //  get our todos
  Future<List<Todo>> getTodos({bool completed = false, String search = ''});
}
