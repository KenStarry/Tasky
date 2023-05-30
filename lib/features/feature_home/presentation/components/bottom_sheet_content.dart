import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/domain/model/todo.dart';
import 'package:tasky/features/feature_home/presentation/components/bottom_sheet_add_task.dart';
import 'package:tasky/features/feature_home/presentation/components/bottom_sheet_update_task.dart';

import '../../../../core/presentation/provider/core_provider.dart';

class BottomSheetContent extends StatelessWidget {

  final Todo? todo;
  const BottomSheetContent({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todo == null ? const BottomSheetAddTask() : BottomSheetUpdateTask(todo: todo!,);
  }
}
