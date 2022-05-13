/// Tally Marks State
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

part of 'tally_marks_cubit.dart';

enum TallyMarksStatus { loading, success, failure }

class TallyMarksState extends Equatable {
  const TallyMarksState._({
    this.status = TallyMarksStatus.loading,
    this.tally,
  });

  const TallyMarksState.loading() : this._();

  const TallyMarksState.success({
    required int tally,
  }) : this._(tally: tally, status: TallyMarksStatus.success);

  const TallyMarksState.failure() : this._(status: TallyMarksStatus.failure);

  final TallyMarksStatus status;
  final int? tally;

  @override
  List<Object?> get props => [status, tally];
}