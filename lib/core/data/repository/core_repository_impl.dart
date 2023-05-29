import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/core/data/data_source/queries.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/dependency_injection/locator.dart';

import '../../domain/repository/core_repository.dart';

class CoreRepositoryImpl implements CoreRepository {
  var client = locator.get<ValueNotifier<GraphQLClient>>().value;

  @override
  Future<List<Todo>> getTodos(
      {bool completed = false, String search = ''}) async {
    try {
      QueryResult result = await client.query(QueryOptions(
          document: gql(Queries.getTodos),
          variables: {'completed': completed, 'search': search}));

      if (result.hasException) {
        throw Exception(result.exception);
      }

      //  get a list of the map
      List? res = result.data?['todos'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<Todo> todos =
          res.map((todo) => Todo.convertFromMap(map: todo)).toList();

      return todos;
    } catch (error) {
      throw Exception(error);
    }
  }
}
