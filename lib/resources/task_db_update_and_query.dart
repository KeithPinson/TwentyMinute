/// Task DB Update and Query
///
/// Database update or query of a task.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

/*
__ GetActiveTask
__ PickTask
__ StartTask
__ EndTask
__ PauseTask
__ DismissTask
__ AddTask
__ UpdateTask
__ DeleteTask
__ GetTaskCompleted
 */


import 'package:intl/intl.dart';
import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_db_provider.dart';
import 'package:twentyminute/resources/task_db_model.dart';

Future<List<Map<String, Object?>>> getActiveTasks() async {
  var list = (await taskProvider.db!.query('Tasks',
      columns: ['_id', 'isDeleted', 'label', 'description', 'status', 'startTime'],
      where: 'isDeleted = 0 AND status=${taskStatus.started}',
      orderBy: 'startTime DESC'));

  return list;
}

