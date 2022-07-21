import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'dart:collection';
import 'package:ordered_set/ordered_set.dart';

import 'package:todo_list/data/database.dart';
import 'package:todo_list/data/task.dart';


part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  SplayTreeMap<DateTime, OrderedSet<Task>> data;
  final database = Database();

  TasksBloc(this.data) : super(TasksInitial()) {
    on<TasksEvent>((event, emit) async {
      if (event is TasksAdded) {
        if (!data.containsKey(event.date)) {
          data[event.date] = OrderedSet<Task>();
        }
        data[event.date]!.add(event.task);

        emit(TasksUpdate());
      }

      else if (event is TasksRemoved) {
        data[event.date]!.remove(event.task);
        if (data[event.date]!.isEmpty) {
          data.remove(event.date);
          emit(TasksUpdate());
        }
      }

      else if (event is TasksUploadStarted) {
        emit(TasksWait());
        await database.uploadData(event.id, data);
        emit(TasksUpdate());
      }

      else if (event is TasksLoadStarted) {
        emit(TasksWait());
        data = await database.loadData(event.id);
        emit(TasksUpdate());
      }

    });
  }
}
