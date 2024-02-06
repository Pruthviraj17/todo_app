import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_items.dart';
import 'package:todo_app/providers/todo_item_provider.dart';

class CheckedTodoItemNotifier extends StateNotifier<List<TodoItem>> {
  CheckedTodoItemNotifier({
    required this.ref,
  }) : super([]);

  final Ref ref;

  void addCheckedItem(TodoItem item) {
    state = [...state, item];
  }

  Future<void> isChecked(TodoItem item, bool value,
      {bool onDissmised = false}) async {
    state = state.where((itm) {
      if (itm.id == item.id) {
        itm.isDone = value;
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

  void removeAllItems() {
    state = [];
  }

  void deleteItem({required String id}) {
    state = state.where((item) => item.id != id).toList();
  }

  void removeItem() {
    // now add to todos list
    state = state.where((item) {
      if (item.isDone == false) {
        ref.read(todoItemsProvider.notifier).addNewItem(item);
        return false;
      }
      return true;
    }).toList();
  }

  TodoItem getItem(int index) {
    return state[index];
  }
}

final checkedTodoItemProvider =
    StateNotifierProvider<CheckedTodoItemNotifier, List<TodoItem>>(
        (reff) => CheckedTodoItemNotifier(ref: reff));
