import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ordered_set/ordered_set.dart';
import 'package:todo_list/data/priority.dart';
import 'package:todo_list/data/task.dart';

class Database {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> uploadData(
      String id, SplayTreeMap<DateTime, OrderedSet<Task>> data) async {
    List<DateTime> uniqueDates = List.from(data.keys);
    List<DateTime> dates = [];
    List<String> descriptions = [];
    List<int> priorities = [];

    for (int i = 0; i < uniqueDates.length; i++) {
      for (Task t in data[uniqueDates[i]]!) {
        dates.add(uniqueDates[i]);
        descriptions.add(t.description);
        priorities.add(t.priority.index);
      }
    }

    final json = {
      'uniqueDates': uniqueDates,
      'dates': dates,
      'descriptions': descriptions,
      'priorities': priorities,
    };

    try {
      await tasksCollection.doc(id).set(json);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<SplayTreeMap<DateTime, OrderedSet<Task>>> loadData(String id) async {
    var res = SplayTreeMap<DateTime, OrderedSet<Task>>();
    try {
      final data = await tasksCollection.doc(id).get();

      for (dynamic date in data.get('uniqueDates')) {
        res[date.toDate()] = OrderedSet<Task>();
      }

      List<DateTime> dates = [];
      for (dynamic date in data.get('dates')) {
        dates.add(date.toDate());
      }
      var descriptions = List<String>.from(data.get('descriptions'));
      var priorities = List<int>.from(data.get('priorities'));

      for (int i = 0; i < descriptions.length; i++) {
        res[dates[i]]!
            .add(Task(descriptions[i], Priority.values[priorities[i]]));
      }

      return res;
    } on FirebaseException catch (e) {
      print("Error message: ${e.message}");
    } finally {
      return res;
    }
  }
}
