/// Tally Marks Repository
///
/// The source from which the Tally Marks Bloc listens
/// for changes in the Tally Marks ultimately to be displayed.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:twentyminute/resources/tally_marks_db_query.dart';


enum TallyMarksStatus { precount, counting, counted, countFailed }

class TallyMarksRepository {
  final _controller = StreamController<TallyMarksStatus>();

  Stream<TallyMarksStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    yield TallyMarksStatus.precount;
    yield* _controller.stream;
  }

  Future<int> count() async {
    var tallyMarks = await getTallyMarksThisDay();

    return tallyMarks;
  }

  void clearCount() {
    _controller.add(TallyMarksStatus.precount);
  }
}