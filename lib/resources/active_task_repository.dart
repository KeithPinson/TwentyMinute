/// Active Task Repository
///
/// The source from which the Active Task Bloc listens
/// for changes in the Active Task status.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:equatable/equatable.dart';

class ActiveTaskRepository extends Equatable {
  const ActiveTaskRepository(this.id, this.label);

  final int id;
  final String label;

  @override
  List<Object> get props => [id, label];

  static const empty = ActiveTaskRepository(0, ' ');
}
