/// Bloc Observer
///
/// Watch for state changes across the whole app.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:twentyminute/components/timer_bloc.dart';
import 'package:twentyminute/components/active_task_bloc.dart';

class AppBlockObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      // print('${bloc.runtimeType} -- $change');
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    if (kDebugMode) {
      print('${bloc.runtimeType} -- Created');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      // print('${bloc.runtimeType} -- $transition');
    }

    if (bloc.runtimeType == ActiveTaskBloc && transition.nextState.runtimeType == ActiveTaskHolding) {
      if (kDebugMode) {
        // print('${bloc.runtimeType} -- $transition');
      }
    }

    if (transition.nextState == const TimerRunCompleted()) {
      if (kDebugMode) {
        print('${bloc.runtimeType} -- $transition');
      }
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('${bloc.runtimeType} -- $error');
    }

    log('onError(${bloc.runtimeType}, $error, $stackTrace)');

    super.onError(bloc, error, stackTrace);
  }
}
