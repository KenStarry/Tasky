import 'package:flutter/material.dart';

import '../../../../core/domain/model/todo.dart';

class TodoCard extends StatelessWidget {

  final Todo todo;

  const TodoCard({Key? key,required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          //  checkbox
          Checkbox(value: todo.completed, onChanged: (val) {}),

          const SizedBox(width: 8,),

          //  todo_title
          Text(todo.title ?? "", style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
