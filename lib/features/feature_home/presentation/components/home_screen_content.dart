import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/core/presentation/provider/core_provider.dart';
import 'package:tasky/features/feature_home/presentation/components/todo_card.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  all todos
    List<Todo> todos = Provider.of<CoreProvider>(context).getAllTodos;

    //  completed todos
    List<Todo> completedTodos = Provider.of<CoreProvider>(context).getCompletedTodos();

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
          title: Text(
            "Tasks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black.withOpacity(0.7)),
          ),
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //  tasks count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "${todos.length} ",
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

                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Column(
                          children: [

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
                                      fontWeight: FontWeight.w700)
                              ),
                              TextSpan(
                                  text: "${todos.length}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700)
                              ),
                            ])),

                            LinearPercentIndicator(
                              animation: true,
                              animateFromLastPercent: false,
                              percent: (completedTodos.length / todos.length),
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

              const SizedBox(height: 24,),

              Container(
                width: double.infinity,
                height: 800,
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return TodoCard(todo: todos[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 24,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
