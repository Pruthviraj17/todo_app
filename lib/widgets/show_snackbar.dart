import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_items.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';
import 'package:todo_app/providers/todo_item_provider.dart';

void showSnackBar({
  required String cnt,
  required BuildContext context,
  bool isDeleted = false,
  WidgetRef? ref = null,
  int? index = null,
  int? todoItemsLength = null,
  TodoItem? item = null,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(cnt),
      action: !isDeleted
          ? null
          : SnackBarAction(
              label: "Undo",
              onPressed: () {
                // restore again
                if (index! < todoItemsLength!) {
                  ref!.read(todoItemsProvider.notifier).addNewItem(item!);
                  showSnackBar(
                      cnt: "Todo restored successfully", context: context);
                } else {
                  ref!
                      .read(checkedTodoItemProvider.notifier)
                      .addCheckedItem(item!);
                  showSnackBar(
                      cnt: "Todo restored successfully", context: context);
                }
              },
            ),
    ),
  );
}
