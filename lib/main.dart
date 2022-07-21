import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/tasks_bloc.dart';

import 'package:todo_list/todo_theme.dart';
import 'package:todo_list/pages/home_page.dart';
import 'package:todo_list/data/task.dart';
import 'package:todo_list/data/priority.dart';

import 'package:ordered_set/ordered_set.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) =>
          TasksBloc(SplayTreeMap<DateTime, OrderedSet<Task>>.from({
        /*DateTime(2022, 2, 4): OrderedSet<Task>()/*.addAll([Task("Сделать удаление с удаляющимся удалением ", Priority.extreme), Task("Сделать добавление", Priority.high), Task("Lorem ipsum", Priority.low)])*/,
            DateTime(2022, 1, 1): OrderedSet<Task>()/*.addAll([Task("####", Priority.high),Task("%%%%", Priority.low), Task("^^^^", Priority.medium)])*/,
            DateTime(2022, 1, 3): OrderedSet<Task>()/*.addAll([Task("1111", Priority.medium), Task("2222", Priority.low), Task("3333", Priority.high)])*/,*/
      })),
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          title: 'ToDo List',
          theme: TodoTheme.theme,
          home: HomePage(),
        ),
      ),
    );
  }
}
