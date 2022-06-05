/// Task BLOC event
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

/*
 *  - onCreateTaskDb(),  TaskDbCreate
 *  - onOpenTaskDb(),    TaskDbOpen
 *  - onDeleteTaskDb(),  TaskDbDelete
 *  - onClearAllTasks(), TaskDbClearAll
 *  - onAddTask(),       TaskDbAddTask
 *  - onUpdateTask(),    TaskDbUpdateTask
 *  - onDeleteTask(),    TaskDbRemoveTask
 */

class TaskDbCreate extends TaskEvent {
  const TaskDbCreate();
}

class TaskDbOpen extends TaskEvent {
  const TaskDbOpen();
}

class TaskDbDelete extends TaskEvent {
  const TaskDbDelete();
}

class TaskDbClearAll extends TaskEvent {
  const TaskDbClearAll();
}

class TaskDbAddTask extends TaskEvent {
  const TaskDbAddTask();
}

class TaskDbUpdateTask extends TaskEvent {
  const TaskDbUpdateTask();
}

class TaskDbRemoveTask extends TaskEvent {
  const TaskDbRemoveTask();
}
