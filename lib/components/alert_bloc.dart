/// Alert BLOC
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
import 'package:twentyminute/components/alert_controller.dart';

part 'alert_bloc_event.dart';
part 'alert_bloc_state.dart';

/*
 * Initial state is
 *
 *  - AlertNone
 *
 * Events:
 *  - onAlertClear(), AlertClear
 *  - onAlertStop(),  AlertStop
 *  - onAlertPlay(), AlertPlay
 *
 * States:
 *  - AlertNone
 *  - AlertStopped
 *  - AlertPlaying
 *
 * Transition Event to State:
 *  - onAlertClear ⤑ AlertNone if not AlertNone
 *  - onAlertStop ⤑ AlertStopped if not AlertStopped
 *  - onAlertPlay ⤑ AlertPlaying if not AlertPlaying
 *
 */

class AlertBloc extends Bloc<AlertEvent, AlertState> {

  /*
   * Listen to State changes to trigger events:
   *
   * State Change          Event
   * ------------          -----
   *                       AlertClear (Initial state AlertNone)
   * TimerRunCompleted     AlertPlay
   *
   */

  final TimerBloc timerBloc;
  StreamSubscription? _timerSubscription;

  AlertBloc({required this.timerBloc}) :
        super(const AlertNone()) {
    _timerSubscription = timerBloc.stream.listen((state) {
      if (state is TimerRunCompleted) {
        add(const AlertPlay());
      }
    });

    on<AlertEvent>(_onEvent, transformer: sequential());
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  void _onEvent(AlertEvent event, Emitter<AlertState> emit) {
    if (event is AlertClear) return _onAlertClear(event, emit);
    if (event is AlertStop) return _onAlertStop(event, emit);
    if (event is AlertPlay) return _onAlertPlay(event, emit);
  }

  void _onAlertClear(
      AlertClear event,
      Emitter<AlertState> emit,
      ) async {
    if (state is! AlertNone) {
      dismissAlert();
      emit(const AlertNone());
    }
  }

  void _onAlertStop(
      AlertStop event,
      Emitter<AlertState> emit,
      ) async {
    if (state is! AlertStopped) {
      stopAlert();
      emit(const AlertStopped());
    }
  }

  void _onAlertPlay(
      AlertPlay event,
      Emitter<AlertState> emit,
      ) async {
    if (state is! AlertPlaying) {
      playAlert();
      emit(const AlertPlaying());
    }
  }
}
