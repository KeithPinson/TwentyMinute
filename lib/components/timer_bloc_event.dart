/// Timer BLOC event
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStart extends TimerEvent {
  const TimerStart({required this.duration});
  final int duration;
}

class TimerPause extends TimerEvent {
  const TimerPause();
}

class TimerResume extends TimerEvent {
  const TimerResume();
}

class TimerCancel extends TimerEvent {
  const TimerCancel();
}

class TimerFinishEarly extends TimerEvent {
  const TimerFinishEarly();
}

class TimerTick extends TimerEvent {
  const TimerTick({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerSet extends TimerEvent {
  const TimerSet();
}
