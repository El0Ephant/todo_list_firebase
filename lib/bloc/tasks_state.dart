part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}
class TasksUpdate extends TasksState {}
class TasksWait extends TasksState {}