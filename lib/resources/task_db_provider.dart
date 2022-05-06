/// Task DB Provider
///
/// The database provider gives access to the Task portion of
/// the database..
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/foundation.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:twentyminute/main.dart';
import 'package:twentyminute/resources/task_db_model.dart';

Task snapshotToTask(Map<String, Object?> snapshot) {
  return Task()..fromMap(snapshot);
}

class Tasks extends ListBase<Task> {
  final List<Map<String, Object?>> list;
  late List<Task?> _cacheTasks;

  Tasks(this.list) {
    _cacheTasks = List.generate(list.length, (index) => null);
  }

  @override
  Task operator [](int index) {
    return _cacheTasks[index] ??= snapshotToTask(list[index]);
  }

  @override
  int get length => list.length;

  @override
  void operator []=(int index, Task? value) => throw 'read-only';

  @override
  set length(int newLength) => throw 'read-only';
}

class DbTaskProvider {
  final lock = Lock(reentrant: true);
  final DatabaseFactory dbFactory;
  final _updateTriggerController = StreamController<bool>.broadcast();
  Database? db;

  DbTaskProvider(this.dbFactory);

  Future openPath(String path) async {
    db = await dbFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: kVersion1,
            onCreate: (db, version) async {
              await _createDb(db);
            },
            onUpgrade: (db, oldVersion, newVersion) async {
              if (oldVersion < kVersion1) {
                await _createDb(db);
              }
            }));
  }

  void _triggerUpdate() {
    _updateTriggerController.sink.add(true);
  }

  Future<Database?> get ready async => db ??= await lock.synchronized(() async {
        if (db == null) {
          await open();
        }
        return db;
      });

  Future<Task?> getTask(int? id) async {
    var list = (await db!.query('Tasks',
        columns: [
          'id',
          'isDeleted',
          'label',
          'description',
          'status',
          'startTime',
          'restartTime',
          'endTime',
          'elapsedSeconds'
        ],
        where: 'id = ?',
        whereArgs: <Object?>[id]));
    if (list.isNotEmpty) {
      return Task()..fromMap(list.first);
    }
    return null;
  }

  Future _createDb(Database db) async {
    await db.execute('DROP TABLE If EXISTS Tasks');
    await db.execute(
        'CREATE TABLE Tasks('
            'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
            'isDeleted INTEGER DEFAULT (0), '
            'label TEXT DEFAULT (''), '
            'description TEXT DEFAULT (''), '
            'status INTEGER DEFAULT (${taskStatus.backlog}), '
            'startTime INTEGER, '
            'restartTime INTEGER, '
            'endTime INTEGER, '
            'elapsedSeconds INTEGER DEFAULT (0)');
    await db
        .execute('CREATE INDEX TaskStatus ON Tasks (status)');
    await db
        .execute('CREATE INDEX TaskStart ON Tasks (startTime)');
    await db
        .execute('CREATE INDEX TaskEnd ON Tasks (startEnd)');
    await _saveTask(
        db,
        Task()
          ..startTime.v = null
          ..restartTime.v = null
          ..endTime.v = null
    );
    _triggerUpdate();
  }

  Future open() async {
    await openPath(await fixPath(dbName));
  }

  Future<String> fixPath(String path) async => path;

  /// Add or update a Task
  Future _saveTask(DatabaseExecutor? db, Task updatedTask) async {
    if (updatedTask.id.v != null) {
      await db!.update('Tasks', updatedTask.toMap(),
          where: 'id = ?', whereArgs: <Object?>[updatedTask.id.v]);
    } else {
      updatedTask.id.v = await db!.insert('Tasks', updatedTask.toMap());
    }
  }

  Future saveTask(Task updatedTask) async {
    await _saveTask(db, updatedTask);
    _triggerUpdate();
  }

  Future<void> deleteTask(int? id) async {
    await db!
        .delete('Tasks', where: 'id = ?', whereArgs: <Object?>[id]);
    _triggerUpdate();
  }

  var TasksTransformer =
      StreamTransformer<List<Map<String, Object?>>, List<Task>>.fromHandlers(
          handleData: (snapshotList, sink) {
    sink.add(Tasks(snapshotList));
  });

  var TaskTransformer =
      StreamTransformer<Map<String, Object?>, Task?>.fromHandlers(
          handleData: (snapshot, sink) {
    sink.add(snapshotToTask(snapshot));
  });

  /// Listen for changes on any Task
  Stream<List<Task?>> onTasks() {
    late StreamController<Tasks> ctlr;
    StreamSubscription? triggerSubscription;

    Future<void> sendUpdate() async {
      var tasks = await getListTasks();
      if (!ctlr.isClosed) {
        ctlr.add(tasks);
      }
    }

    ctlr = StreamController<Tasks>(onListen: () {
      sendUpdate();

      /// Listen for trigger
      triggerSubscription = _updateTriggerController.stream.listen((_) {
        sendUpdate();
      });
    }, onCancel: () {
      triggerSubscription?.cancel();
    });
    return ctlr.stream;
  }

  /// Listed for changes on a given Task
  Stream<Task?> onTask(int? id) {
    late StreamController<Task?> ctlr;
    StreamSubscription? triggerSubscription;

    Future<void> sendUpdate() async {
      var Task = await getTask(id);
      if (!ctlr.isClosed) {
        ctlr.add(Task);
      }
    }

    ctlr = StreamController<Task?>(onListen: () {
      sendUpdate();

      /// Listen for trigger
      triggerSubscription = _updateTriggerController.stream.listen((_) {
        sendUpdate();
      });
    }, onCancel: () {
      triggerSubscription?.cancel();
    });
    return ctlr.stream;
  }

  /// Don't read all fields
  Future<Tasks> getListTasks(
      {int? offset, int? limit, bool? descending}) async {
    // devPrint('fetching $offset $limit');
    var list = (await db!.query('Tasks',
        columns: [
          'id',
          'isDeleted',
          'label',
          'description',
          'status',
          'startTime',
          'restartTime',
          'endTime',
          'elapsedSeconds'
        ],
        where: 'isDeleted = 0',
        orderBy: 'startTime ${(descending ?? false) ? 'ASC' : 'DESC'}',
        limit: limit,
        offset: offset));
    return Tasks(list);
  }

  Future clearAllTasks() async {
    await db!.delete('Tasks');
    _triggerUpdate();
  }

  Future close() async {
    await db!.close();
  }

  Future deleteDb() async {
    await dbFactory.deleteDatabase(await fixPath(dbName));
  }
}

