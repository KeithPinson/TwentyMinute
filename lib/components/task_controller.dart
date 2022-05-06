/// Task Controller
///
/// Controller for the task list.
///
/// Tasks are not a comprehensive list of all work done or all work
/// to be done. They should be thought of as snapshot of recently
/// looked-up work to do and recent work completed.
///
/// Another data provider should be used for comprehensive reports
/// regarding work done and another set of providers for work planned.
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

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:twentyminute/resources/task_db_model.dart';
import 'package:twentyminute/resources/task_db_update_and_query.dart';

Future<int?> getActiveTaskId() async {
  var activeTaskList = await getActiveTasks();

  if (activeTaskList.isNotEmpty) {
    var activeTask = Task()..fromMap(activeTaskList.first);

    return activeTask.id.v;
  }
  else {
    return 0;
  }
}

Future<String?> getActiveTaskLabel() async {
  var activeTaskList = await getActiveTasks();

  if (activeTaskList.isNotEmpty) {
    var activeTask = Task()..fromMap(activeTaskList.first);

    return activeTask.label.v;
  }
  else {
    return 'Twenty Minute Task3';
  }
}

