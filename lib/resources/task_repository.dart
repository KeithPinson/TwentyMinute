/// Task Repository
///
/// The source from which the Task Bloc listens for
/// changes in the Task status.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:equatable/equatable.dart';

/*
enum taskStatus {
  backlog,
  to//do,
  started,
  done
}
*/

class TaskRepository extends Equatable {
  const TaskRepository(
      this.id,
      this.label,
      this.description,
      this.status,
      this.startTime,
      this.restartTime,
      this.endTime,
      this.elapsedSeconds,
      );

  final int id;
  final String label;
  final String description;
  final int status;
  final int startTime;
  final int restartTime;
  final int endTime;
  final int elapsedSeconds;


  @override
  List<Object> get props => [
    id,
    label,
    description,
    status,
    startTime,
    restartTime,
    endTime,
    elapsedSeconds
  ];

  static const empty = TaskRepository(
    0,
    ' ',
    '',
    0, // status: backlog
    0,
    0,
    0,
    0
  );
}
