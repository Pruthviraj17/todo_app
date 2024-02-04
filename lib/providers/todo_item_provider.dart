import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_items.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';

class TodoItemsNotifier extends StateNotifier<List<TodoItem>> {
  TodoItemsNotifier({
    required this.ref,
  }) : super([
          TodoItem(title: "Gym", description: "Go to gym at 5 pm"),
          TodoItem(title: "Code", description: "Code at least 6 hours today"),
          TodoItem(
              title: "Learn Flutter",
              description:
                  "Learn flutter riverpod concept and make a awesome project with it"),
        ]);

  final Ref ref;

  void addNewItem(TodoItem item) {
    state = [...state, item];
  }

  Future<void> isChecked(TodoItem item, bool value) async {
    state = state.where((itm) {
      if (itm.id == item.id) {
        itm.isDone = value;
        // if (value == true) {
        //   toRemoveItem = itm;
        // }
      }
      return true;
    }).toList();

    await Future.delayed(
      const Duration(seconds: 1),
      () {
        return removeItem();
      },
    );
  }

  void removeItem() {
    // now add to completed list
    state = state.where((item) {
      if (item.isDone == true) {
        ref.read(checkedTodoItemProvider.notifier).addCheckedItem(item);
        return false;
      }
      return true;
    }).toList();
  }

  TodoItem getItem(int index) {
    return state[index];
  }
}

final todoItemsProvider =
    StateNotifierProvider<TodoItemsNotifier, List<TodoItem>>((reff) {
  return TodoItemsNotifier(ref: reff);
});
