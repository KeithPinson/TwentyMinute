/// Task BLOC state
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'task_bloc.dart';

enum QueryStatus { waiting, success, failure }

/*abstract*/ class TaskState extends Equatable {
  const TaskState._({
  this.status = QueryStatus.waiting,
  });

  const TaskState.initial() : this._();

  const TaskState.waiting() : this._();

  const TaskState.success()
  : this._(status: QueryStatus.success);

  const TaskState.failure() : this._(status: QueryStatus.failure);

  final QueryStatus status;

  @override
  List<Object> get props => [status];
}


// class TaskInitial extends TaskState {
//   @override
//   List<Object> get props => [];
// }


class TaskDbReady extends TaskState {
  const TaskDbReady.waiting() : super.waiting();

  @override
  List<Object> get props => [];
}
