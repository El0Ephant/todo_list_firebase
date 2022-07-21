import 'package:flutter/material.dart';

import 'package:todo_list/todo_theme.dart';

enum Priority {
  extreme,
  high,
  medium,
  low,
}


extension InfoExtension on Priority {

  Color get color {
    switch (this) {
      case Priority.extreme:
        return TodoTheme.extremeColor;
      case Priority.high:
        return TodoTheme.lightColor;
      case Priority.medium:
        return TodoTheme.subColor;
      case Priority.low:
        return TodoTheme.mainColor;
      default:
        return Colors.black;
    }
  }

  String get text {
    switch (this) {
      case Priority.extreme:
        return "Экстремальный приоритет";
      case Priority.high:
        return "Высокий приоритет";
      case Priority.medium:
        return "Средний приоритет";
      case Priority.low:
        return "Низкий приоритет";
      default:
        return "-";
    }
  }
}