import 'package:flutter/material.dart';
import 'package:todo_list/data/priority.dart';
import 'package:todo_list/todo_theme.dart';

class PriorityPick extends StatefulWidget {
  const PriorityPick({super.key, required this.update, required this.initial});
  
  final Function update;
  final Priority initial;
  
  @override
  State<PriorityPick> createState() => _PriorityPickState();
}

class _PriorityPickState extends State<PriorityPick> {
  late bool extreme;
  late bool high;
  late bool medium;
  late bool low;
  
  @override
  void initState() {
    switch (widget.initial) {
      case Priority.extreme:
        extreme = true;
        high = medium = low = false;
        break;
      case Priority.high:
        high = true;
        extreme = medium = low = false;
        break;
      case Priority.medium:
        medium = true;
        extreme = high = low = false;
        break;
      case Priority.low:
        low = true;
        extreme = high = medium = false;
        break;
    }
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Приоритет:"),
          Checkbox(
            value: extreme,
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  extreme = value;
                  high = medium = low = false;
                  widget.update(Priority.extreme);
                }
              });
            },

            activeColor: TodoTheme.extremeColor,
            checkColor: TodoTheme.extremeColor,
          ),

          Checkbox(
            value: high,
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  high = value;
                  extreme = medium = low = false;
                  widget.update(Priority.high);
                }
              });
            },

            activeColor: TodoTheme.lightColor,
            checkColor: TodoTheme.lightColor,
          ),

          Checkbox(
            value: medium,
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  medium = value;
                  extreme = high = low = false;
                  widget.update(Priority.medium);
                }
              });
            },

            activeColor: TodoTheme.subColor,
            checkColor: TodoTheme.subColor,
          ),

          Checkbox(
            value: low,
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  low = value;
                  extreme = high = medium = false;
                  widget.update(Priority.low);
                }
              });
            },

            activeColor: TodoTheme.mainColor,
            checkColor: TodoTheme.mainColor,
          ),


        ],
      ),
    );
  }
}
