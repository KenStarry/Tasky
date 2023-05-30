import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/domain/model/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function(bool? isChecked) onChecked;
  final VoidCallback onTodoClicked;
  final Function(BuildContext)? onDelete;
  final Function(BuildContext)? onArchive;

  const TodoCard(
      {Key? key,
      required this.todo,
      required this.onChecked,
      required this.onTodoClicked,
      required this.onDelete,
      required this.onArchive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.circular(16),
          ),
          SlidableAction(
            onPressed: onArchive,
            backgroundColor: Colors.greenAccent,
            icon: Icons.archive,
            label: "Archive",
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: GestureDetector(
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
      ),
    );
  }
}
