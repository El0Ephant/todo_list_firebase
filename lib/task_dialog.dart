import 'package:flutter/material.dart';

import 'package:todo_list/data/task.dart';
import 'package:todo_list/data/priority.dart';
import 'package:todo_list/data/task_with_date.dart';

import 'package:todo_list/todo_theme.dart';
import 'package:todo_list/widgets/priority_pick.dart';
import 'package:todo_list/widgets/description_input.dart';



abstract class TaskDialog {

  static Future<TaskWithDate?> show(context, {DateTime? curDate, Task? curTask}) async {
    final now =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    var date = curDate != null ? DateTime(curDate.year, curDate.month, curDate.day) : now;
    var task = curTask != null ? Task(curTask.description, curTask.priority) : Task("-", Priority.medium);

    late final String title;
    if (curDate != null) {
      title = "Редактирование задачи";
    } else {
      title = "Добавление задачи";
    }

    bool accept = false;
    final style = Theme.of(context).textTheme.headline1;
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                color: TodoTheme.backColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title,
                        style: style),
                  ),
                  PriorityPick(update: (Priority p){ task.priority = p;}, initial: curTask?.priority ?? Priority.medium,),

                  DescriptionInput(update: (String d){ task.description = d;}, initial: curTask?.description ?? "",),

                  TextButton(
                    onPressed: () async{
                      date = await showDatePicker(context: context, initialDate: now, firstDate:  now, lastDate:  DateTime(now.year+1, now.month, now.day)) ?? date;
                    },
                    child: Text("Выбрать дату",
                        style: style),
                  ),
                  TextButton(
                    onPressed: () {
                      accept = true;
                      Navigator.of(context).pop();
                    },
                    child: Text("Применить",
                        style: style),
                  )
                ],
              ));
        });

    return accept ? TaskWithDate(task: task, date: date):  null;
  }


}