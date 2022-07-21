import 'package:flutter/material.dart';

import 'package:todo_list/data/priority.dart';




class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.description, required this.priority});

  final String description;
  final Priority priority;

  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(description, style: Theme.of(context).textTheme.bodyText1!.copyWith(color: priority.color),),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(priority.text, style: Theme.of(context).textTheme.bodyText2!.copyWith(color: priority.color),),
        ),

        //enableFeedback: true,
      ),
    );
  }
}