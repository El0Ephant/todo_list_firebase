part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {
  const TasksEvent();
}


class TasksAdded extends TasksEvent {
  const TasksAdded(this.task, this.date);
  final Task task;
  final DateTime date;
}

class TasksRemoved extends TasksEvent {
  const TasksRemoved(this.task, this.date);
  final Task task;
  final DateTime date;
}

class TasksLoadStarted extends TasksEvent {
  const TasksLoadStarted(this.id);
  final String id;
}

class TasksUploadStarted extends TasksEvent {
  const TasksUploadStarted(this.id);
  final String id;
}