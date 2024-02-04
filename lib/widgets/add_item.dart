import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_items.dart';
import 'package:todo_app/providers/todo_item_provider.dart';

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({
    super.key,
    required this.ref,
  });
  final WidgetRef ref;

  @override
  State<AddTodoItem> createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  void addItemToList() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      final newTodoItem = TodoItem(
        title: _titleController.text,
        description: _descController.text,
      );
      // ref is taken from previous class
      widget.ref.read(todoItemsProvider.notifier).addNewItem(newTodoItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          const SizedBox(
            height: 21,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  validator: (title) {
                    if (title!.isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Title",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.tertiary,
                  controller: _descController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (desc) {
                    if (desc!.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Description",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 40,
            child: ElevatedButton(
              onPressed: () => addItemToList(),
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shadowColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.tertiary),
              child: Text(
                "ADD",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
