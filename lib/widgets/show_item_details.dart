import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';
import 'package:todo_app/providers/todo_item_provider.dart';

class ShowItemDetails extends ConsumerWidget {
  const ShowItemDetails({
    super.key,
    required this.itemIndex,
    required this.todoScreen,
  });
  final int itemIndex;
  final String todoScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoItem = todoScreen == 'UncheckedList'
        ? ref.watch(todoItemsProvider.notifier).getItem(itemIndex)
        : ref.watch(checkedTodoItemProvider.notifier).getItem(itemIndex);

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.drag_handle_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          Text(
            "Title".toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            todoItem.title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 21,
          ),
          Text(
            "Descrpiton".toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            todoItem.description,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
