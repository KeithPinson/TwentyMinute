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

import 'package:intl/intl.dart';

import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_db_model.dart';
import 'package:twentyminute/resources/task_db_query.dart';
import 'package:twentyminute/resources/task_db_provider.dart';
import 'package:twentyminute/resources/task_status.dart';


Future<int> getActiveTaskId() async {
  var activeTaskList = await getActiveTasks();

  var taskId = 0;

  if (activeTaskList.isNotEmpty) {
    taskId = (Task()..fromMap(activeTaskList.first)).id.v ?? 0;
  }

  return taskId;
}

Future<String> getActiveTaskLabel() async {
  var activeTaskList = await getActiveTasks();

  var taskLabel = 'Twenty Minute Task';

  if (activeTaskList.isNotEmpty) {
    taskLabel = (Task()..fromMap(activeTaskList.first)).label.v ?? 'Twenty Minute Task';
  }

  return taskLabel;
}

/*
label
description
status
  backlog
  to do
  started
  done
startTime
restartTime
endTime
elapsedSeconds
*/


Future addTask(
    String label,
    {String description = '',
     bool isBacklog = true} ) async {

  // Tasks can be added in advance of starting and
  // would at least have a label. These tasks are
  // not active, see startTask().

  // Add a blank new task
  await taskProvider.addTask(Task()
    ..isDeleted.v = 0
    ..label.v = label
    ..description.v = description
    ..status.v = isBacklog ? TaskStatus.backlog.index : TaskStatus.todo.index
    ..startTime.v = 0
    ..restartTime.v = 0
    ..endTime.v = 0
    ..elapsedSeconds.v = 0);
}


Future startTask() async {
  var taskId = await getActiveTaskId();

  if (taskId > 0) {
    await taskProvider.updateTask(taskId, Task()
      ..status.v = TaskStatus.started.index
      ..startTime.v = DateTime.now().millisecondsSinceEpoch
      ..restartTime.v = 0
      ..endTime.v = 0
      ..elapsedSeconds.v = 0);
  }
  else {
    // UpdateTask will add and update if taskId is zero
    await taskProvider.updateTask(0, Task()
      ..isDeleted.v = 0
      ..label.v = ''
      ..description.v = ''
      ..status.v = TaskStatus.started.index
      ..startTime.v = DateTime.now().millisecondsSinceEpoch
      ..restartTime.v = 0
      ..endTime.v = 0
      ..elapsedSeconds.v = 0);
  }

  taskId = await getActiveTaskId();
  print( "  startTask() $taskId" );
}


Future endTask() async {
  var taskId = await getActiveTaskId();

  print( "  endTask() $taskId" );

  if (taskId > 0) {
    // Calculate the elapsed seconds
    var elapsedSeconds = 0; // TODO

    await taskProvider.updateTask(taskId, Task()
      ..status.v = TaskStatus.done.index
      ..endTime.v = DateTime.now().millisecondsSinceEpoch
      ..elapsedSeconds.v = elapsedSeconds);
  }
}


Future pauseTask() async {
  var taskId = await getActiveTaskId();

  if (taskId > 0) {
    // Update the elapsed seconds
    var elapsedSeconds = 0; // TODO

    await taskProvider.updateTask(taskId, Task()
      ..elapsedSeconds.v = elapsedSeconds);
  }
}


Future restartTask() async {
  var taskId = await getActiveTaskId();

  if (taskId > 0) {
    await taskProvider.updateTask(taskId, Task()
      ..restartTime.v = DateTime.now().millisecondsSinceEpoch);
  }
}


Future dismissTask() async {
  var taskId = await getActiveTaskId();

  if (taskId > 0) {
    await taskProvider.updateTask(taskId, Task()
      ..isDeleted.v = 1);
  }
}
