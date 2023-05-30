import 'package:flutter/material.dart';

import '../../../../core/domain/model/todo.dart';
import '../components/bottom_sheet_content.dart';

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