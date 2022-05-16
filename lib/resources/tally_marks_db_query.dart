/// The tally mark repository
///
/// This returns a count of the tally marks in a given time range.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_db_model.dart';

Future<int> getTallyMarks(int startTime, int endTime) async {
  var list = (await taskProvider.db!.query('Tasks',
      columns: ['_id', 'isDeleted', 'label', 'description', 'status', 'endTime'],
      where: 'isDeleted = 0 AND status=${taskStatus.done.index} '
          'AND endTime >= $startTime AND endTime < $endTime'));

  return list.length;
}
