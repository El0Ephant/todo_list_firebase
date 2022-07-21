import 'package:todo_list/data/priority.dart';

class Task implements Comparable<Task> {
  String description;
  Priority priority;

  Task(this.description, this.priority);

  @override
  int compareTo(Task other) {
    return priority.index.compareTo(other.priority.index);
  }
}
