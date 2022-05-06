/// Task DB Model
///
/// Model of the Task data structure.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:cv/cv.dart';

const String dbName = 'task.db';
const int kVersion1 = 1;

enum taskStatus {
  backlog,
  todo,
  started,
  done
}


abstract class DbRecord extends CvModelBase {
  final id = CvField<int>('_id');
  final isDeleted = CvField<int>('isDeleted');
}


class Task extends DbRecord {
  final label = CvField<String>('label');
  final description = CvField<String>('description');
  final status = CvField<int>('status');
  final startTime = CvField<int>('startTime');
  final restartTime = CvField<int>('restartTime');
  final endTime = CvField<int>('endTime');
  final elapsedSeconds = CvField<int>('elapsedSeconds');

  @override
  List<CvField> get fields => [
    id,
    isDeleted,
    label,
    description,
    status,
    startTime,
    restartTime,
    endTime,
    elapsedSeconds,
  ];
}
