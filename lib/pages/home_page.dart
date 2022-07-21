import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo_list/data/task_with_date.dart';

import 'package:todo_list/todo_theme.dart';
import 'package:todo_list/widgets/day_widget.dart';
import 'package:todo_list/task_dialog.dart';
import 'package:todo_list/widgets/drawer/registered.dart';
import 'package:todo_list/widgets/drawer/no_user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/tasks_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  User? user;

  void _resetUser() {
    user = null;
  }
  void _addTask(context) async {
    TaskWithDate? td = await TaskDialog.show(context);
    if (td != null) {
      BlocProvider.of<TasksBloc>(context).add(TasksAdded(td.task, td.date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: TodoTheme.backColor,
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Что-то пошло не так"),);
            }
            if (snapshot.hasData) {
              user = FirebaseAuth.instance.currentUser;
            }
            if (user != null) {
              return Registered(user: user!, resetUser: _resetUser,);
            }
            return NoUser();

          },
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TasksInitial || state is TasksUpdate) {
              return ListView.builder(
                itemBuilder: (context, i) {
                  DateTime key = BlocProvider.of<TasksBloc>(context).data.keys.elementAt(i);
                  return DayWidget(
                    date: key,
                  );
                },
                itemCount: BlocProvider.of<TasksBloc>(context).data.length,
              );
            }

            if (state is TasksWait) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Text("а где");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add task',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
