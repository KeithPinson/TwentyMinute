/// Tallymarks Cubit
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:bloc/bloc.dart';

class TallyMarksCubit extends Cubit<int> {
  TallyMarksCubit() : super(0);

  void init(/*range*/) => emit(0);
  void change() => emit(state + 1);
}
