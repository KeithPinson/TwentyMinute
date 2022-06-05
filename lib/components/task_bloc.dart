/// Task BLOC
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:twentyminute/components/task_controller.dart';


part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

/*
 * Initial state is
 *
 *  - TaskDbExists if Db exists
 *  - or, NoTaskDb if Db does not exist
 *
 * Events:
 *  - onCreateTaskDb(),  TaskDbCreate
 *  - onOpenTaskDb(),    TaskDbOpen
 *  - onDeleteTaskDb(),  TaskDbDelete
 *  - onClearAllTasks(), TaskDbClearAll
 *  - onAddTask(),       TaskDbAddTask
 *  - onUpdateTask(),    TaskDbUpdateTask
 *  - onDeleteTask(),    TaskDbRemoveTask
 *
 * States:
 *  - NoTaskDb
 *  - TaskDbExists
 *  - TaskDbReady
 *
 * Transition Event to State:
 *
 *  - onCreateTaskDb ⤑ TaskDbExists if NoTaskDb
 *  - onOpenTaskDb ⤑ TaskDbReady if TaskDbExists
 *  - onDeleteTaskDb ⤑ TaskDbReady if TaskDbExists or TaskDbReady
 *  - onClearAllTasks ⤑ TaskDbReady if TaskDbReady
 *  - onAddTask ⤑ TaskDbReady if TaskDbReady
 *  - onUpdateTask ⤑ TaskDbReady if TaskDbReady
 *  - onDeleteTask ⤑ TaskDbReady if TaskDbReady
 *
 */

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  // final ValueNotifier<int> activeTaskId = ValueNotifier<int>("0");
  // final ValueNotifier<String> activeTaskLabel = ValueNotifier<String>("Twenty Minute Task");

  TaskBloc() : super(const TaskState.initial()) {
    on<TaskEvent>(_onEvent, transformer: sequential());
  }

  void _onEvent(TaskEvent event, Emitter<TaskState> emit) {
    if (event is TaskDbCreate) return _onCreateTaskDb(event, emit);
    if (event is TaskDbOpen) return _onOpenTaskDb(event, emit);
    if (event is TaskDbDelete) return _onDeleteTaskDb(event, emit);
    if (event is TaskDbClearAll) return _onClearAllTasks(event, emit);
    if (event is TaskDbAddTask) return _onAddTask(event, emit);
    if (event is TaskDbUpdateTask) return _onUpdateTask(event, emit);
    if (event is TaskDbRemoveTask) return _onDeleteTask(event, emit);
  }

  void _onCreateTaskDb(
      TaskDbCreate event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onOpenTaskDb(
      TaskDbOpen event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onDeleteTaskDb(
      TaskDbDelete event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onClearAllTasks(
      TaskDbClearAll event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onAddTask(
      TaskDbAddTask event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onUpdateTask(
      TaskDbUpdateTask event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }

  void _onDeleteTask(
      TaskDbRemoveTask event,
      Emitter<TaskState> emit,
      ) async {
    emit(const TaskState.waiting());
    var taskId = await getActiveTaskId();
    emit(const TaskState.success());
  }
}
