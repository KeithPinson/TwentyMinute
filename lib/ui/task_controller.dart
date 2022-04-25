/// Task Controller
///
/// Controller for the database task list.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:twentyminute/resources/db_helper.dart';
import 'package:twentyminute/components/task_model.dart';

class TaskController extends GetxController {
  final RxList taskList = <Task>[].obs;

  Future<void> getTask()async{
   final List<Map<String, dynamic>> tasks = await DBHelper().queryAllRows();
   taskList.assignAll(tasks.map((data) => Task.fromMap(data)).toList());
  }

  addTask(Task task)async{
    await DBHelper().insertTask(task);
    taskList.add(task);
    getTask();
  }

  deleteTask(int? id)async{
    await DBHelper().delete(id!);
    getTask();
  }

  deleteAllTasks()async{
    await DBHelper().deleteAllTasks();
    getTask();
  }

  markAsCompleted(int? id)async{
    await DBHelper().update(id!);
    getTask();
  }
}
