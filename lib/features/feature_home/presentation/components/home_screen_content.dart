import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //  all todos
    List<Todo> todos = Provider.of<CoreProvider>(context).getAllTodos;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black.withOpacity(0.7)),
        ),
        elevation: 0,
        toolbarHeight: 100,
      ),
    );
  }
}
