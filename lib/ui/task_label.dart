/// Task label
///
/// Show the Task Label and allow it to be picked
/// if not set.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyminute/ui/pick_task_label.dart';
import 'package:twentyminute/components/task_controller.dart';

import '../resources/task_db_model.dart';

class TaskLabel extends StatefulWidget {
  const TaskLabel({Key? key}) : super(key: key);

  @override
  _TaskLabelState createState() => _TaskLabelState();
}

class _TaskLabelState extends State<TaskLabel> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<String?>(
        future: getActiveTaskLabel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var label = (snapshot.data == null) ?
            "Twenty Minute Task" : snapshot.data;

          print( "*** Task Label: ${snapshot.data} ***" );

          return InkWell(
            onTap: () {
              Get.to(
                () => const PickTaskLabel(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 500)
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 11.0),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}