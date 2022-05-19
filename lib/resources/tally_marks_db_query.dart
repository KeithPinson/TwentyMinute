/// The tally mark repository
///
/// This returns a count of the tally marks in a given time range.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:jiffy/jiffy.dart';

import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_db_model.dart';

Future<List<Map<String, Object?>>> getTallyMarkList(int startTime, int endTime) async {
  var list = (await taskProvider.db!.query('Tasks',
      columns: ['_id', 'isDeleted', 'label', 'description', 'status', 'endTime'],
      where: 'isDeleted = 0 AND status=${taskStatus.done.index} '
          'AND endTime >= $startTime '
          'AND endTime < $endTime'));

  return list;
}

Future<int> getTallyMarks(Jiffy startTime, Jiffy endTime) async {
  var list = await getTallyMarkList(
      startTime.dateTime.millisecondsSinceEpoch,
      endTime.dateTime.millisecondsSinceEpoch);

  return list.length;
}

Future<int> getTallyMarksToday() async {

  var midnightThisMorning = Jiffy().startOf(Units.DAY);
  var midnightTonight = Jiffy().add(days: 1).startOf(Units.DAY);

  var count = getTallyMarks(midnightThisMorning, midnightTonight);

  return count;
}

