import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/domain/model/todo.dart';
import '../../../../core/presentation/provider/core_provider.dart';

class BottomSheetUpdateTask extends StatelessWidget {
  final Todo todo;

  const BottomSheetUpdateTask({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    controller.text = todo.title ?? "update task";

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Update Task",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: controller,
                      cursorColor: Colors.lightBlueAccent,
                      decoration: InputDecoration(
                          label: Text("Update Task"),
                          labelStyle:
                              const TextStyle(color: Colors.lightBlueAccent),
                          focusColor: Colors.lightBlueAccent,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.lightBlueAccent),
                              borderRadius: BorderRadius.circular(16)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey)))),
                ),

                const SizedBox(
                  width: 16,
                ),

                //  submit button
                GestureDetector(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      //  create the todo_in graphql
                      Provider.of<CoreProvider>(context, listen: false)
                          .updateTodo(
                              completed: todo.completed!,
                              id: todo.id!,
                              title: controller.text);
                    }

                    //  clear controller
                    controller.clear();
                    //  hide bottom sheet
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.lightBlueAccent.withOpacity(0.1)),
                    child: const Icon(
                      Icons.send,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
