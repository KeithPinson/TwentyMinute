/// Alert BLOC state
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'alert_bloc.dart';

abstract class AlertState extends Equatable {
  const AlertState();
}

class AlertNone extends AlertState {
  const AlertNone() : super();

  @override
  List<Object> get props => [];

  // @override
  // String toString() => 'AlertNone {}';
}


class AlertStopped extends AlertState {
  const AlertStopped() : super();

  @override
  List<Object> get props => [];

  // @override
  // String toString() => 'AlertStopped {}';
}


class AlertPlaying extends AlertState {
  const AlertPlaying() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AlertPlaying {}';
}
