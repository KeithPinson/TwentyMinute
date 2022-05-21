/// Tally Marks Controller
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///


import 'package:twentyminute/resources/tally_marks_db_query.dart';

Future<int> getTallyMarkCountToday() async {
  var tallyMarks = await getTallyMarksToday();

  tallyMarks++;

  return tallyMarks;
}

