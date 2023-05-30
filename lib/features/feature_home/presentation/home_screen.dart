import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';
import 'package:tasky/features/feature_home/presentation/components/home_screen_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future getTodosFuture;
  // late Future createTodoFuture;

  @override
  void initState() {
    super.initState();

    getTodosFuture = Provider.of<CoreProvider>(context, listen: false)
        .getTodos(completed: false, search: '');

    // createTodoFuture = Provider.of<CoreProvider>(context, listen: false)
    //     .createTodo(completed: false, title: 'I\'m stuck so bad');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getTodosFuture]),
        initialData: null,
        builder: (context, asyncSnapshot) {
          //
          if (asyncSnapshot.connectionState == ConnectionState.done &&
              asyncSnapshot.hasError) {
            throw Exception(asyncSnapshot.error);
          } else if (asyncSnapshot.connectionState == ConnectionState.done &&
              !asyncSnapshot.hasError) {
            //  display the todos
            return const HomeScreenContent();
          } else {
            return Container(width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator(),),);
          }
        });
  }
}
















