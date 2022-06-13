/// Tally Marks Cubit
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:twentyminute/components/active_task_bloc.dart';

part 'tally_marks_bloc_event.dart';
part 'tally_marks_bloc_state.dart';

/*
 * Initial state is
 *
 *  - TallyMarkCountReady
 *
 * Events:
 *  - onCountTallyMarks(), TallyMarksCount
 *
 * States:
 *  - TallyMarkInit
 *  - TallyMarksCounting
 *  - TallyMarksCounted
 *  - TallyMarksCountFailed
 *
 * Transition Event to State:
 *
 *  - onCountTallyMarks ⤑ TallyMarksCounting if not TallyMarksCounting
 *                      ⤑ TallyMarksCounted if success
 *				                 or, TallyMarksCountFailed if failure
 *
 */


class TallyMarksBloc extends Bloc<TallyMarksBlocEvent, TallyMarksBlocState> {

  /*
   * Listen to State changes to trigger events:
   *
   * State                 TallyMarkEvent
   * ---------------       --------------
   * ClockTaskDayFinished  TallyMarksCount  // TODO
   * ActiveTaskNone        TallyMarksCount
   * ActiveTaskFinished    TallyMarksCount
   *
   */

  final ActiveTaskBloc activeTaskBloc;
  StreamSubscription<ActiveTaskState>? _activeTaskSubscription;

  TallyMarksBloc({required this.activeTaskBloc}) :
        super(const TallyMarksCountReady()) {
    _activeTaskSubscription = activeTaskBloc.stream.listen((state) {
      if (state is ActiveTaskNone || state is ActiveTaskFinished) {
        add(const TallyMarksCount());
      }

    });

    on<TallyMarksBlocEvent>(_onEvent, transformer: sequential() /*concurrent()*/);
  }

  @override
  Future<void> close() {
    _activeTaskSubscription?.cancel();
    return super.close();
  }

  void _onEvent(TallyMarksBlocEvent event, Emitter<TallyMarksBlocState> emit) {
    if (event is TallyMarksCount) return _onTallyMarksCount(event, emit);
  }

  void _onTallyMarksCount(
      TallyMarksCount event,
      Emitter<TallyMarksBlocState> emit,
      ) async {
    if (state is! TallyMarksCounting) {
      emit(const TallyMarksCounting());
    }
  }

}