import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';
import 'package:todo_app/providers/todo_item_provider.dart';
import 'package:todo_app/widgets/add_item.dart';
import 'package:todo_app/widgets/alert_dialog.dart';
import 'package:todo_app/widgets/show_item_details.dart';
import 'package:todo_app/widgets/show_snackbar.dart';
import 'package:todo_app/widgets/text_widget1.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void openTodoItemModal(Widget widget) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(),
      backgroundColor: Theme.of(context).colorScheme.background,
      isDismissible: true,
      context: context,
      builder: (context) => widget,
    );
  }

  void removeItems() {
    ref.read(checkedTodoItemProvider.notifier).removeAllItems();
  }

  void deleteAllCheckedList() {
    showAlertDialog(
        context: context,
        onTap: removeItems,
        titile: "REMOVE ALL",
        content: "Do you really want to delete all the checked list?");
  }

  Widget? divider({
    required int todoItemsLength,
    required int index,
  }) {
    if (todoItemsLength == index)
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.green,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => deleteAllCheckedList(),
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.1,
            ),
          ],
        ),
      );

    return null;
  }

  Widget? sorryWidget({required int todoItemsLength, required int index}) {
    if (todoItemsLength == index)
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/sorry.png'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "No items in the list",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final todoItems = ref.watch(todoItemsProvider);
    final checkedTodoItems = ref.watch(checkedTodoItemProvider);
    final todoItemsLength = todoItems.length;
    final checkedTodoItemsLength = checkedTodoItems.length;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "My Todo",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          if (todoItems.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/nice.png'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Add some todos!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: todoItemsLength +
                    (checkedTodoItems.isNotEmpty
                        ? (checkedTodoItemsLength + 1)
                        : checkedTodoItemsLength),
                itemBuilder: (context, index) {
                  final todoItem = index < todoItemsLength
                      ? todoItems[todoItemsLength - index - 1]
                      : checkedTodoItems[index -
                          todoItemsLength -
                          (index > todoItemsLength ? 1 : 0)];

                  int indx = todoItemsLength > index
                      ? (index + 1).toInt()
                      : (index - todoItemsLength).toInt();

                  return divider(
                          todoItemsLength: todoItemsLength, index: index) ??
                      GestureDetector(
                        onTap: () => openTodoItemModal(
                          ShowItemDetails(
                              itemIndex: todoItemsLength > index
                                  ? todoItemsLength - index - 1
                                  : index - todoItemsLength - 1,
                              todoScreen: todoItemsLength > index
                                  ? "UncheckedList"
                                  : "CheckedList"),
                        ),
                        child: Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              if (index < todoItemsLength) {
                                ref
                                    .read(todoItemsProvider.notifier)
                                    .deleteItem(id: todoItem.id);
                              } else {
                                ref
                                    .read(checkedTodoItemProvider.notifier)
                                    .deleteItem(id: todoItem.id);
                              }
                              showSnackBar(
                                cnt: "${todoItem.title} Deleted from todo.",
                                context: context,
                                isDeleted: true,
                                ref: ref,
                                index: index,
                                todoItemsLength: todoItemsLength,
                                item: todoItem,
                              );
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              if (index < todoItemsLength) {
                                todoItem.isDone = true;
                                ref.read(todoItemsProvider.notifier).isChecked(
                                    todoItem, true,
                                    onDissmised: true);
                              } else {
                                todoItem.isDone = false;
                                ref
                                    .read(checkedTodoItemProvider.notifier)
                                    .isChecked(todoItem, false,
                                        onDissmised: true);
                              }
                              showSnackBar(
                                  cnt:
                                      "${todoItem.title} added to checked list.",
                                  context: context);
                            }
                          },
                          secondaryBackground: Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(255, 0, 90, 3),
                                  Color.fromARGB(255, 3, 162, 8),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                index > todoItemsLength
                                    ? "Restore to todo"
                                    : "Done",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          background: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 196, 13, 3),
                                  Color.fromARGB(255, 129, 10, 2)
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          key: ValueKey<String>(todoItem.title),
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            child: ListTile(
                              leading: TextWidget(
                                title: (indx.toString()),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              title: TextWidget(
                                title: todoItem.title,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                lineThrough:
                                    todoItemsLength > index ? false : true,
                              ),
                              trailing: Checkbox(
                                checkColor: Colors.white,
                                // fillColor: MaterialStatePropertyAll(Colors.green),
                                activeColor: Colors.green,
                                value: todoItem.isDone,
                                onChanged: (value) {
                                  // todoItem.isDone = value!;
                                  if (index < todoItemsLength) {
                                    ref
                                        .read(todoItemsProvider.notifier)
                                        .isChecked(todoItem, value!);
                                  } else {
                                    ref
                                        .read(checkedTodoItemProvider.notifier)
                                        .isChecked(todoItem, value!);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 5),
            child: GestureDetector(
              onTap: () {
                openTodoItemModal(AddTodoItem(ref: ref));
              },
              child: CircleAvatar(
                minRadius: 25,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
