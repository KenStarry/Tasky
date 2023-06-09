import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tasky/core/data/data_source/mutations.dart';
import 'package:tasky/core/data/data_source/queries.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/dependency_injection/locator.dart';

import '../../domain/repository/core_repository.dart';

class CoreRepositoryImpl implements CoreRepository {
  var client = locator.get<ValueNotifier<GraphQLClient>>().value;

  @override
  Future<List<Todo>> getTodos(
      {required bool? completed, required String search}) async {
    try {
      QueryResult result = await client.query(QueryOptions(
          document: gql(Queries.getTodos),
          variables: {'completed': completed, 'search': search}));

      if (result.hasException) {
        print("Result -> ${result.data}");
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

  @override
  Future<Todo> createTodo(
      {required bool completed, required String title}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
          document: gql(Mutations.createTodo),
          variables: {'completed': completed, 'title': title}));

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        var res = result.data?['createTodo']['todo'];
        return Todo.convertFromMap(map: res);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<bool> deleteTodo({required String id}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
          document: gql(Mutations.deleteTodo), variables: {'id': id}));

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<bool> updateTodo(
      {required bool completed,
      required String id,
      required String title}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
          document: gql(Mutations.updateTodo),
          variables: {'completed': completed, 'id': id, 'title': title}));

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        return true;
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
