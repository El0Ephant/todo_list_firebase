import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:todo_list/data/task.dart';
import 'package:todo_list/data/priority.dart';

import 'package:todo_list/widgets/task_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/tasks_bloc.dart';

import '../data/task_with_date.dart';
import '../task_dialog.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({super.key, required this.date, /*required this.tasks*/});

  final DateTime date;
  //final SplayTreeSet<Task> tasks;

  static String month(int n) {
    switch(n) {
      case 1:
        return "Января";
      case 2:
        return "Февраля";
      case 3:
        return "Марта";
      case 4:
        return "Апреля";
      case 5:
        return "Мая";
      case 6:
        return "Июня";
      case 7:
        return "Июля";
      case 8:
        return "Августа";
      case 9:
        return "Сентября";
      case 10:
        return "Октября";
      case 11:
        return "Ноября";
      case 12:
        return "Декабря";
      default:
        return "-";
    }
  }

  static String weekday(int n) {
    switch(n) {
      case 1:
        return "Понедельник";
      case 2:
        return "Вторник";
      case 3:
        return "Среда";
      case 4:
        return "Четверг";
      case 5:
        return "Пятница";
      case 6:
        return "Суббота";
      case 7:
        return "Воскресенье";
      default:
        return "-";
    }
  }


  @override
  Widget build(BuildContext context) {
    var tasks = BlocProvider.of<TasksBloc>(context).data[date];
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${weekday(date.weekday)}, ${date.day}-е ${month(date.month)}",
              style: Theme.of(context).textTheme.headline1,
            )),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            var elem = tasks!.elementAt(i);
            return Dismissible(
              onDismissed: (_) {
                BlocProvider.of<TasksBloc>(context).add(TasksRemoved(elem, date));
                },
              key: UniqueKey(),
              child: InkWell(
                onTap: () async {

                  TaskWithDate? td = await TaskDialog.show(context, curTask: elem, curDate: date);

                  if (td != null) {
                    BlocProvider.of<TasksBloc>(context).add(TasksRemoved(elem, date));
                    BlocProvider.of<TasksBloc>(context).add(TasksAdded(td.task, td.date));
                  }

                },
                child: TaskCard(
                  description: elem.description,
                  priority: elem.priority,
                ),
              ),
            );
          },
          itemCount: tasks?.length ?? 0,
        ),
      ],
    );
  }
}
