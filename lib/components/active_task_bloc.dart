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

import 'package:twentyminute/components/timer_bloc.dart';
import 'package:twentyminute/components/active_task_controller.dart';

part 'active_task_bloc_event.dart';
part 'active_task_bloc_state.dart';

/*
 * Initial state is
 *
 *  - ActiveTaskHolding if active task exists and is not done
 *  - or, ActiveTaskNone if active task does not exist or active task is done
 *
 * Events:
 *  - onActiveTaskClear(), ActiveTaskClear
 *  - onActiveTaskDone(),  ActiveTaskDone
 *  - onActiveTaskHold(), ActiveTaskHold
 *  - onActiveTaskResume(), ActiveTaskResume
 *  - onActiveTaskRun(), ActiveTaskRun
 *
 * States:
 *  - ActiveTaskNone
 *  - ActiveTaskFinished
 *  - ActiveTaskHolding
 *  - ActiveTaskResume
 *  - ActiveTaskRunning
 *
 * Transition Event to State:
 *  - onActiveTaskClear ⤑ ActiveTaskNone if not ActiveTaskNone
 *  - onActiveTaskDone ⤑ ActiveTaskFinished if not ActiveTaskFinished
 *  - onActiveTaskHold ⤑ ActiveTaskHolding if not ActiveTaskHolding
 *  (Timer will emit Resume and Run one after the other)
 *  - onActiveTaskResume ⤑ ActiveTaskHolding if ActiveTaskHolding
 *  - onActiveTaskRun ⤑ ActiveTaskRunning if not ActiveTaskRunning
 *
 */


class ActiveTaskBloc extends Bloc<ActiveTaskEvent, ActiveTaskState> {

  /*
   * Listen to the Timer Bloc to trigger events:
   *
   * TimerState           ActiveTaskEvent
   * ----------           ---------------
   *                      ActiveTaskClear (Initial state ActiveTaskNone)
   * TimerRunCompleted    ActiveTaskDone
   * TimerRunReady        ActiveTaskHold
   * TimerRunInProgress   ActiveTaskRun
   * TimerResumeRun       ActiveTaskResume
   * TimerRunPaused       ActiveTaskHold
   * TimerRunCanceled     ActiveTaskHold
   *
   */

  final TimerBloc timerBloc;
  StreamSubscription? _timerSubscription;

  ActiveTaskBloc({required this.timerBloc}) :
        super(const ActiveTaskNone()) {
    _timerSubscription = timerBloc.stream.listen((state) {
      if (state is TimerRunCompleted) {
        add(const ActiveTaskDone());
      }
      else if (state is TimerResumeRun) {
        add(const ActiveTaskResume());
      }
      else if (state is TimerRunInProgress) {
        add(const ActiveTaskRun());
      }
      else {
        add(const ActiveTaskHold());
      }

    });

    on<ActiveTaskEvent>(_onEvent, transformer: sequential());
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  void _onEvent(ActiveTaskEvent event, Emitter<ActiveTaskState> emit) {
    if (event is ActiveTaskClear) return _onActiveTaskClear(event, emit);
    if (event is ActiveTaskDone) return _onActiveTaskDone(event, emit);
    if (event is ActiveTaskHold) return _onActiveTaskHold(event, emit);
    if (event is ActiveTaskResume) return _onActiveTaskResume(event, emit);
    if (event is ActiveTaskRun) return _onActiveTaskRun(event, emit);
  }

  void _onActiveTaskClear(
      ActiveTaskClear event,
      Emitter<ActiveTaskState> emit,
      ) async {
    if (state is! ActiveTaskNone) {
      dismissTask();
      emit(const ActiveTaskNone());
    }
  }

  void _onActiveTaskDone(
      ActiveTaskDone event,
      Emitter<ActiveTaskState> emit,
      ) async {
    if (state is! ActiveTaskFinished) {
      endTask();
      emit(const ActiveTaskFinished(0, " "));
    }
  }

  void _onActiveTaskHold(
      ActiveTaskHold event,
      Emitter<ActiveTaskState> emit,
      ) async {
    if (state is! ActiveTaskHolding) {
      pauseTask();
      emit(const ActiveTaskHolding(0, " "));
    }
  }

  void _onActiveTaskResume(
      ActiveTaskResume event,
      Emitter<ActiveTaskState> emit,
      ) async {
    if (state is ActiveTaskHolding) {
      restartTask();
      // We don't change the state.
      // Should be followed by timer in progress which triggers task run
    }
  }

  void _onActiveTaskRun(
      ActiveTaskRun event,
      Emitter<ActiveTaskState> emit,
      ) async {
    if (state is! ActiveTaskRunning) {
      startTask();
      emit(const ActiveTaskRunning(0, " "));
    }
  }
}

