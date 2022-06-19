/// Timer BLOC
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:twentyminute/resources/time_ticks.dart';
import 'package:twentyminute/resources/preferences.dart';

part 'timer_bloc_event.dart';
part 'timer_bloc_state.dart';

/*
 * Initial state is TimerRunReady.
 *
 * Events:
 *  - onStart(),       TimerStart
 *  - onPause(),       TimerPause
 *  - onResume(),      TimerResume
 *  - onCancel(),      TimerCancel
 *  - onFinishEarly(), TimerFinishEarly
 *  - onTick(),        TimerTick
 *  - onSet(),         TimerSet
 *
 * States:
 *  - TimerRunReady
 *  - TimerRunInProgress
 *  - TimerRunPaused
 *  - TimerRunCanceled
 *  - TimerRunCompleted
 *
 * Transition Event to State:
 *  - onStart ⤑ TimerRunInProgress if TimerRunReady
 *  - onPause ⤑ TimerRunPaused if TimerRunInProgress
 *  - onResume ⤑ TimerRunInProgress if TimerRunPaused
 *  - onCancel ⤑ TimerCanceled if TimerRunInProgress or TimerRunPaused
 *  - onFinishEarly ⤑ TimerRunCompleted
 *  - onTick
 *    ⤑ TimerRunInProgress if time left > 0
 *    ⤑ TimerRunCompleted if time left <= 0
 * - onSet ⤑ TimerRunReady if TimerRunCompleted or TimerRunCanceled
 *
 */

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final TimeTicks _ticks;
  final int _durationSeconds;

  StreamSubscription<int>? _tickerSubscription;

  static const int _defaultDuration = 60 * 20;

  TimerBloc({required TimeTicks ticks, int durationSeconds = _defaultDuration})
      : _ticks = ticks,
        _durationSeconds = durationSeconds,
        super(TimerRunReady(durationSeconds)) {
    on<TimerStart>(_onStart);
    on<TimerPause>(_onPause);
    on<TimerResume>(_onResume);
    on<TimerCancel>(_onCancel);
    on<TimerFinishEarly>(_onFinishEarly);
    on<TimerTick>(_onTick);
    on<TimerSet>(_onSet);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStart(TimerStart event, Emitter<TimerState> emit) {
    if (state is TimerRunReady) {
      emit(TimerRunInProgress(state.duration));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticks
          .tick(ticks: event.duration)
          .listen((duration) => add(TimerTick(duration: duration)));
    }
  }

  void _onPause(TimerPause event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPaused(state.duration));
    }
  }

  void _onResume(TimerResume resume, Emitter<TimerState> emit) async {
    if (state is TimerRunPaused) {
      _tickerSubscription?.resume();
      emit(TimerResumeRun(state.duration));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onCancel(TimerCancel event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress || state is TimerRunPaused) {
      _tickerSubscription?.cancel();
      emit(TimerRunCanceled(state.duration));
    }
  }

  void _onFinishEarly(TimerFinishEarly event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.cancel();
      emit(const TimerRunCompleted());
    }
  }

  void _onTick(TimerTick event, Emitter<TimerState> emit) {

    if (event.duration > 0) {
      // Use this event duration to update the state duration
      emit(TimerRunInProgress(event.duration));
    } else {
      emit(const TimerRunCompleted());
    }
  }

  void _onSet(TimerSet event, Emitter<TimerState> emit) {
    if (state is TimerRunCanceled || state is TimerRunCompleted) {
      emit(TimerRunReady(_durationSeconds));
    }
  }
}
