import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/functions/ding_notification.dart';
import 'package:todo_app/models/todo_items.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';

class TodoItemsNotifier extends StateNotifier<List<TodoItem>> {
  TodoItemsNotifier({
    required this.ref,
  }) : super([
          TodoItem(title: "Gym", description: "Go to gym at 5 pm"),
          TodoItem(title: "Code", description: "Code at least 3 hours today"),
          TodoItem(
              title: "Shopping",
              description:
                  "Bring grocery today 1) vegetables 2) Fruits 3) Milk"),
          TodoItem(
              title: "Learn Flutter",
              description:
                  "Learn flutter riverpod concept and make awesome projects with it, build todo app with full functionality such as local database, state management"),
        ]);

  final Ref ref;

  void addNewItem(TodoItem item) {
    state = [...state, item];
  }

  Future<void> isChecked(TodoItem item, bool value,
      {bool onDissmised = false}) async {
    state = state.where((itm) {
      if (itm.id == item.id) {
        itm.isDone = value;
        // if (value == true) {
        //   toRemoveItem = itm;
        // }
      }
      return true;
    }).toList();

    if (onDissmised) {
      removeItem();
    }

    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        return removeItem();
      },
    );
  }

  void removeItem() {
    // now add to completed list
    state = state.where((item) {
      if (item.isDone == true) {
        playDingNotificationSound();
        ref.read(checkedTodoItemProvider.notifier).addCheckedItem(item);
        return false;
      }
      return true;
    }).toList();
  }

  void deleteItem({required String id}) {
    state = state.where((item) => item.id != id).toList();
  }

  TodoItem getItem(int index) {
    return state[index];
  }
}

final todoItemsProvider =
    StateNotifierProvider<TodoItemsNotifier, List<TodoItem>>((reff) {
  return TodoItemsNotifier(ref: reff);
});
