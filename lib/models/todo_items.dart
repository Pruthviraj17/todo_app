import 'package:uuid/uuid.dart';

class TodoItem {
  final String id;
  final String title;
  final String description;
  bool isDone;

  TodoItem({
    required this.title,
    required this.description,
  })  : isDone = false,
        id = const Uuid().v4();
}
