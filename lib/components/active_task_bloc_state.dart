/// Active Task BLOC state
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'active_task_bloc.dart';

abstract class ActiveTaskState extends Equatable {
  final int activeTaskId;
  final String activeTaskLabel;

  const ActiveTaskState(this.activeTaskId, this.activeTaskLabel);

  @override
  List<Object> get props => [activeTaskId, activeTaskLabel];
}

class ActiveTaskNone extends ActiveTaskState {
  const ActiveTaskNone() : super(0, "");

  @override
  String toString() => 'ActiveTaskNone {}';
}


class ActiveTaskFinished extends ActiveTaskState {
  const ActiveTaskFinished(int id, String label) : super(id, label);

  @override
  String toString() => 'ActiveTaskFinished { id: $activeTaskId, label: $activeTaskLabel }';
}


class ActiveTaskHolding extends ActiveTaskState {
  const ActiveTaskHolding(int id, String label) : super(id, label);

  @override
  String toString() => 'ActiveTaskHolding { id: $activeTaskId, label: $activeTaskLabel }';
}


class ActiveTaskRunning extends ActiveTaskState {
  const ActiveTaskRunning(int id, String label) : super(id, label);

  @override
  String toString() => 'ActiveTaskRunning { id: $activeTaskId, label: $activeTaskLabel }';
}
