/// Tally Marks BLOC event
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'tally_marks_bloc.dart';

abstract class TallyMarksBlocEvent extends Equatable {
  const TallyMarksBlocEvent();

  @override
  List<Object> get props => [];
}

/*
 * Events:
 *  - onCountTallyMarks(), TallyMarksCount
 */

class TallyMarksCount extends TallyMarksBlocEvent {
  const TallyMarksCount();
}
