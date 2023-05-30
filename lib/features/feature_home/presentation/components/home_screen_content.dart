import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';
import 'package:tasky/features/feature_completed/presentation/completed.dart';
import 'package:tasky/features/feature_home/presentation/components/bottom_sheet_content.dart';
import 'package:tasky/features/feature_home/presentation/components/empty_lottie.dart';
import 'package:tasky/features/feature_home/presentation/components/todo_card.dart';

import '../utils/show_bottom_sheet.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    //  all todos
    List<Todo> todos = Provider.of<CoreProvider>(context).getIncompleteTodos;
    List<Todo> allTodos = Provider.of<CoreProvider>(context).getAllTodos;

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
                  "Tasky",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.7)),
                ),

                //  completed button
                GestureDetector(
                  onTap: () {
                    //  open completed screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Completed()));
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
          body: allTodos.length - completedTodos.length == 0
              ? const EmptyLottie(
                  title: "No Tasks, You are clear for the day...",
                  lottie: "assets/lottie/empty_box_shake.json")
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      //  tasks count
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${allTodos.length - completedTodos.length} ",
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
                                      const SizedBox(
                                        height: 8,
                                      ),
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
                                            text: "${allTodos.length}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w700)),
                                      ])),
                                      LinearPercentIndicator(
                                        animation: true,
                                        animateFromLastPercent: true,
                                        percent: (completedTodos.length /
                                            allTodos.length),
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
                          )),

                      const SizedBox(
                        height: 24,
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
                                  onChecked: (isChecked) {
                                    //  update the _todo's status
                                    Provider.of<CoreProvider>(context,
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
                                  },
                                  onTodoClicked: () {
                                    //  open bottomsheet with the _todo item
                                    showMyBottomSheet(
                                        context: context, todo: todos[index]);
                                  },
                                  onDelete: (context) {
                                    //  delete from database
                                    Provider.of<CoreProvider>(context,
                                            listen: false)
                                        .deleteTodo(todo: todos[index]);
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
