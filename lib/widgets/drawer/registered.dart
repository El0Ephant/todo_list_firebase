import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:todo_list/todo_theme.dart';

import 'package:todo_list/bloc/tasks_bloc.dart';

class Registered extends StatelessWidget {
  const Registered({super.key, required this.user, required this.resetUser});

  final void Function() resetUser;
  final User user;

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.bodyText1!.copyWith(color: TodoTheme.mainColor);
    final style = Theme.of(context).textTheme.bodyText2;
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text(user.email ?? "-", style: headerStyle),
        SizedBox(height: 3.h),
        TextButton(onPressed: (){BlocProvider.of<TasksBloc>(context).add(TasksUploadStarted(user.uid));}, child: Text("Загрузить на сервер", style: style)),
        SizedBox(height: 3.h),
        TextButton(onPressed: (){BlocProvider.of<TasksBloc>(context).add(TasksLoadStarted(user.uid));}, child: Text("Загрузить с сервера", style: style)),
        SizedBox(height: 4.h),
        ElevatedButton(onPressed: (){FirebaseAuth.instance.signOut(); resetUser(); Navigator.pop(context);}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(TodoTheme.backColor), elevation: MaterialStateProperty.all(10.0)), child: Text("Выйти", style:style),)
      ],
    );
  }

}