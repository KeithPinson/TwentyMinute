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

import 'package:flutter/foundation.dart';
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
  late Future<String?> taskInstance;

  @override
  void initState() {
    super.initState();

    taskInstance = getActiveTaskLabel();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<String?>(
        future: taskInstance,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            // Waiting
            return Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0),
                child: Center(
                  child: Text(
                    "",  // This should be very fast so show nothing
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );

          } else if (snapshot.hasData) {

            // Show the label
            return InkWell(
              onTap: () {
                // Get.to(
                //     () => const PickTaskLabel(),
                //     transition: Transition.downToUp,
                //     duration: const Duration(milliseconds: 500)
                // );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0),
                child: Center(
                  child: Text(
                    snapshot.data,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );

          } else if (snapshot.hasError) {

            // Show the error when not in release mode
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
                    kReleaseMode ? "" : "@@@ ${snapshot.error}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          } else {

            // Show the default label
            return InkWell(
              onTap: () {
                Get.to(
                    () => const PickTaskLabel(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 500)
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0),
                child: Center(
                  child: Text(
                    "Twenty Minute Task",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          }
        }
      )
    );
  }
}