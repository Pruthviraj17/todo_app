import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/isdone_todo_items_provider.dart';
import 'package:todo_app/providers/todo_item_provider.dart';
import 'package:todo_app/widgets/add_item.dart';
import 'package:todo_app/widgets/show_item_details.dart';

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

  @override
  Widget build(BuildContext context) {
    final todoItems = ref.watch(todoItemsProvider);
    final checkedTodoItems = ref.watch(checkedTodoItemProvider);

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
            ),
          if (todoItems.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) {
                    final todoItem = todoItems[index];
                    return GestureDetector(
                      onTap: () => openTodoItemModal(
                        ShowItemDetails(
                            itemIndex: index, todoScreen: "UncheckedList"),
                      ),
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        // elevation: 0,
                        child: ListTile(
                          leading: Text(
                            "${index + 1}",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          title: Text(
                            todoItem.title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            // fillColor: MaterialStatePropertyAll(Colors.green),
                            activeColor: Colors.green,
                            value: todoItem.isDone,
                            onChanged: (value) {
                              // todoItem.isDone = value!;
                              ref
                                  .read(todoItemsProvider.notifier)
                                  .isChecked(todoItem, value!);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (checkedTodoItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.green,
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 0.1,
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: checkedTodoItems.length,
              itemBuilder: (context, index) {
                final todoItem = checkedTodoItems[index];
                return GestureDetector(
                  onTap: () => openTodoItemModal(
                    ShowItemDetails(
                        itemIndex: index, todoScreen: "CheckedList"),
                  ),
                  child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    // elevation: 0,
                    child: ListTile(
                      leading: Text(
                        "${index + 1}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      title: Text(
                        todoItem.title,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      trailing: Checkbox(
                        checkColor: Colors.white,
                        // fillColor: MaterialStatePropertyAll(Colors.green),
                        activeColor: Colors.green,
                        value: todoItem.isDone,
                        onChanged: (value) {
                          // todoItem.isDone = value!;
                          ref
                              .read(checkedTodoItemProvider.notifier)
                              .isChecked(todoItem, value!);
                        },
                      ),
                    ),
                  ),
                );
              },
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
