/// The tally mark repository
///
/// This returns a count of the tally marks in a given time range.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/foundation.dart';
import 'package:jiffy/jiffy.dart';

import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_status.dart';

Future<List<Map<String, Object?>>> getTallyMarkList(
    int startTimeRange, int endTimeRange) async {
  var list = (await taskProvider.db!.query('Tasks'));

  list = (await taskProvider.db!.query('Tasks',
      columns: ['_id', 'isDeleted', 'label', 'description', 'status', 'endTime'],
      where: 'isDeleted = 0 AND status=${TaskStatus.done.index} '
          'AND endTime >= $startTimeRange '
          'AND endTime < $endTimeRange'));

  return list;
}

Future<int> getTallyMarks(Jiffy startTime, Jiffy endTime) async {
  var list = await getTallyMarkList(
      startTime.dateTime.millisecondsSinceEpoch,
      endTime.dateTime.millisecondsSinceEpoch);

  if( list.isNotEmpty ) {
    if (kDebugMode) {
      print("getTallyMarks() ${list.last} of ${list.length}");
    }
  }

  return list.length;
}

Future<int> getTallyMarksThisDay() async {

  var midnightThisMorning = Jiffy().startOf(Units.DAY);
  var midnightTonight = Jiffy().add(days: 1).startOf(Units.DAY);

  var count = getTallyMarks(midnightThisMorning, midnightTonight);

  return count;
}

