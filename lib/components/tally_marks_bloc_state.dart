/// Tally Marks BLOC State
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'tally_marks_bloc.dart';

abstract class TallyMarksBlocState extends Equatable {
  final int tally;

  const TallyMarksBlocState(this.tally);

  @override
  List<Object> get props => [tally];
}

class TallyMarksCountReady extends TallyMarksBlocState {
  const TallyMarksCountReady() : super(0);

  @override
  String toString() => 'TallyMarksCountReady {}';
}


class TallyMarksCounting extends TallyMarksBlocState {
  const TallyMarksCounting() : super(0);

  @override
  String toString() => 'TallyMarksCounting {}';
}


class TallyMarksCounted extends TallyMarksBlocState {
  const TallyMarksCounted(count) : super(count);

  @override
  String toString() => 'TallyMarksCounted {}';
}


class TallyMarksCountFailed extends TallyMarksBlocState {
  const TallyMarksCountFailed() : super(0);

  @override
  String toString() => 'TallyMarksCountFailed {}';
}
