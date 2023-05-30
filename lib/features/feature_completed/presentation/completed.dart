import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/feature_home/presentation/components/empty_lottie.dart';

import '../../../core/domain/model/todo.dart';
import '../../../core/presentation/provider/core_provider.dart';
import '../../feature_home/presentation/components/todo_card.dart';
import '../../feature_home/presentation/utils/show_bottom_sheet.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    List<Todo> completedTodos =
        Provider.of<CoreProvider>(context).getCompletedTodos();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
          ),
          title: const Text(
            "Completed Tasks",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          toolbarHeight: 100,
        ),
        body: completedTodos.isEmpty
            ? const EmptyLottie(
                title: "Completed Tasks will appear here",
                lottie: "assets/lottie/empty_box_shake.json",
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: completedTodos.length,
                            itemBuilder: (context, index) {
                              return TodoCard(
                                todo: completedTodos[index],
                                onChecked: (isChecked) {
                                  //  update the _todo's status
                                  Provider.of<CoreProvider>(context,
                                          listen: false)
                                      .updateTodo(
                                          completed:
                                              completedTodos[index].completed !=
                                                          null &&
                                                      completedTodos[index]
                                                              .completed ==
                                                          false
                                                  ? true
                                                  : false,
                                          id: completedTodos[index].id ?? "",
                                          title: completedTodos[index].title ??
                                              "");
                                },
                                onTodoClicked: () {
                                  //  open bottomsheet with the _todo item
                                  showMyBottomSheet(
                                      context: context,
                                      todo: completedTodos[index]);
                                },
                                onDelete: (context) {
                                  //  delete from database
                                  Provider.of<CoreProvider>(context,
                                          listen: false)
                                      .deleteTodo(todo: completedTodos[index]);
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
              ));
  }
}
