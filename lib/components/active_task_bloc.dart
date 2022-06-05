/// Active Task BLOC
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'active_task_bloc_event.dart';
part 'active_task_bloc_state.dart';

/*
 * Initial state is
 *
 *  - ActiveTaskPaused if active task exists and is not done
 *  - or, ActiveTaskNone if active task does not exist or active task is done
 *
 * Events:
 *  - onActiveTaskClear(), ActiveTaskClear
 *  - onActiveTaskDone(), ActiveTaskDone
 *  - onActiveTaskPause(), ActiveTaskPause
 *  - onActiveTaskRun(), ActiveTaskRun
 *
 * States:
 *  - ActiveTaskNone
 *  - ActiveTaskFinished
 *  - ActiveTaskPaused
 *  - ActiveTaskRunning
 *
 * Transition Event to State:
 *  - onActiveTaskClear ⤑ ActiveTaskNone
 *  - onActiveTaskDone ⤑ ActiveTaskFinished
 *  - onActiveTaskPause ⤑ ActiveTaskPaused
 *  - onActiveTaskRun ⤑ ActiveTaskRunning
 *
 */


class ActiveTaskBloc extends Bloc<ActiveTaskEvent, ActiveTaskState> {
  ActiveTaskBloc() : super(const ActiveTaskInitial(0, " ")) {
    on<ActiveTaskEvent>(_onEvent, transformer: sequential());
  }

  void _onEvent(ActiveTaskEvent event, Emitter<ActiveTaskState> emit) {
    if (event is ActiveTaskClear) return _onActiveTaskClear(event, emit);
    if (event is ActiveTaskDone) return _onActiveTaskDone(event, emit);
    if (event is ActiveTaskPause) return _onActiveTaskPause(event, emit);
    if (event is ActiveTaskRun) return _onActiveTaskRun(event, emit);
  }

  void _onActiveTaskClear(
      ActiveTaskClear event,
      Emitter<ActiveTaskState> emit,
      ) async {
    // emit(const ActiveTaskState.waiting());
    // var taskId = await getActiveTaskId();
    // emit(const ActiveTaskState.success());
  }

  void _onActiveTaskDone(
      ActiveTaskDone event,
      Emitter<ActiveTaskState> emit,
      ) async {
  }

  void _onActiveTaskPause(
      ActiveTaskPause event,
      Emitter<ActiveTaskState> emit,
      ) async {
  }

  void _onActiveTaskRun(
      ActiveTaskRun event,
      Emitter<ActiveTaskState> emit,
      ) async {
  }
}

