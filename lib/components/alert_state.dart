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

class AlertInitial extends AlertState {
  @override
  List<Object> get props => [];
}
