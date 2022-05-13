/// Tally Marks Cubit
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';

part 'tally_marks_state.dart';

class TallyMarksCubit extends Cubit<TallyMarksState> {
  TallyMarksCubit(int initialTally)
    : super(const TallyMarksState.loading());

  Future<void> getTally({required int tally}) async {
    emit(const TallyMarksState.loading());
    try {
      emit(TallyMarksState.success(tally: tally));
    } on Exception {
      emit(const TallyMarksState.failure());
    }
  }}
