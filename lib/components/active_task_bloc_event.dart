/// Active Task BLOC event
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'active_task_bloc.dart';

abstract class ActiveTaskEvent extends Equatable {
  const ActiveTaskEvent();

  @override
  List<Object> get props => [];
}

/*
 *  - onActiveTaskNone(), ActiveTaskNone
 *  - onActiveTaskDone(),  ActiveTaskDone
 *  - onActiveTaskPause(), ActiveTaskPause
 *  - onActiveTaskRun(), ActiveTaskRun
 */

class ActiveTaskClear extends ActiveTaskEvent {
  const ActiveTaskClear();
}


class ActiveTaskDone extends ActiveTaskEvent {
  const ActiveTaskDone();
}


class ActiveTaskPause extends ActiveTaskEvent {
  const ActiveTaskPause();
}


class ActiveTaskRun extends ActiveTaskEvent {
  const ActiveTaskRun();
}
