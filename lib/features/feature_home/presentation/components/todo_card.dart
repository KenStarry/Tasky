import 'package:flutter/material.dart';

import '../../../../core/domain/model/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function(bool? isChecked) onChecked;
  final VoidCallback onTodoClicked;

  const TodoCard(
      {Key? key,
      required this.todo,
      required this.onChecked,
      required this.onTodoClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTodoClicked,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            //  checkbox
            Checkbox(value: todo.completed, onChanged: onChecked),

            const SizedBox(
              width: 8,
            ),

            //  todo_title
            Text(
              todo.title ?? "",
              style: TextStyle(
                  fontSize: 16,
                  color: todo.completed != null && todo.completed == true
                      ? Colors.black26
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                  decoration: todo.completed != null && todo.completed == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
