/// Timer BLOC state
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///
part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerRunReady extends TimerState {
  const TimerRunReady(int duration) : super(duration);

  @override
  String toString() => 'TimerRunReady { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);

  // @override
  // String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunPaused extends TimerState {
  const TimerRunPaused(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPaused { duration: $duration }';
}

class TimerRunCanceled extends TimerState {
  const TimerRunCanceled(int duration) : super(duration);

  @override
  String toString() => 'TimerRunCanceled { duration: $duration }';
}

class TimerRunCompleted extends TimerState {
  const TimerRunCompleted() : super(0);

  @override
  String toString() => 'TimerRunCompleted';
}
