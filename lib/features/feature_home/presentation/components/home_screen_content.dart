import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';
import 'package:tasky/features/feature_home/presentation/components/bottom_sheet_content.dart';
import 'package:tasky/features/feature_home/presentation/components/empty_lottie.dart';
import 'package:tasky/features/feature_home/presentation/components/todo_card.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  void showMyBottomSheet({required BuildContext context, Todo? todo}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheetContent(
          todo: todo,
        );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  all todos
    List<Todo> todos = Provider.of<CoreProvider>(context).getAllTodos;

    //  completed todos
    List<Todo> completedTodos =
        Provider.of<CoreProvider>(context).getCompletedTodos();

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.7)),
                ),

                //  completed button
                GestureDetector(
                  onTap: () {
                    //  open completed screen
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.lightBlueAccent.withOpacity(0.1),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.open_in_new,
                          color: Colors.black87,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.white,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //  show bottom sheet for creating a task
              showMyBottomSheet(context: context, todo: null);
            },
            backgroundColor: Colors.lightBlueAccent,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: todos.length - completedTodos.length == 0
              ? const EmptyLottie()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      //  tasks count
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${todos.length - completedTodos.length} ",
                                        style: const TextStyle(
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(
                                        text: "tasks remaining.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700)),
                                  ])),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8,),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: "${completedTodos.length}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: " / ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: "${todos.length}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w700)),
                                      ])),
                                      LinearPercentIndicator(
                                        animation: true,
                                        animateFromLastPercent: true,
                                        percent: (completedTodos.length /
                                            todos.length),
                                        lineHeight: 16,
                                        barRadius: const Radius.circular(32),
                                        backgroundColor: Colors.grey.shade300,
                                        progressColor: Colors.lightBlueAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 10,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                return TodoCard(
                                  todo: todos[index],
                                  onChecked: (isChecked) async {
                                    //  update the _todo's status
                                    await Provider.of<CoreProvider>(context,
                                            listen: false)
                                        .updateTodo(
                                            completed: todos[index].completed !=
                                                        null &&
                                                    todos[index].completed ==
                                                        false
                                                ? true
                                                : false,
                                            id: todos[index].id ?? "",
                                            title: todos[index].title ?? "");

                                    if (mounted) {
                                      Provider.of<CoreProvider>(context,
                                              listen: false)
                                          .getTodos(
                                              completed: null, search: '');
                                    }
                                  },
                                  onTodoClicked: () {
                                    //  open bottomsheet with the _todo item
                                    showMyBottomSheet(
                                        context: context, todo: todos[index]);
                                  },
                                  onDelete: (context) async {
                                    //  delete from database
                                    await Provider.of<CoreProvider>(context,
                                            listen: false)
                                        .deleteTodo(id: todos[index].id!);

                                    //  refresh data
                                    if (mounted) {
                                      Provider.of<CoreProvider>(context,
                                              listen: false)
                                          .getTodos(
                                              completed: null, search: '');

                                      setState(() {});
                                    }
                                  },
                                  onArchive: (context) {},
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 24,
                                  )),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
