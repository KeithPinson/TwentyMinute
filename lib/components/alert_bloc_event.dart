/// Alert BLOC event
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}

/*
 * Events:
 *  - onAlertClear(), AlertClear
 *  - onAlertStop(),  AlertStop
 *  - onAlertPlay(), AlertPlay
 */

class AlertClear extends AlertEvent {
  const AlertClear();
}


class AlertStop extends AlertEvent {
  const AlertStop();
}


class AlertPlay extends AlertEvent {
  const AlertPlay();
}
