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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:twentyminute/components/active_task_bloc.dart';
import 'package:twentyminute/ui/pick_task_label.dart';
import 'package:twentyminute/components/task_controller.dart';

import '../resources/task_db_model.dart';

class TaskLabel extends StatefulWidget {
  const TaskLabel({Key? key}) : super(key: key);

  @override
  TaskLabelState createState() => TaskLabelState();
}

class TaskLabelState extends State<TaskLabel> {
  late Future<String?> taskActiveLabel;

  @override
  void initState() {
    super.initState();

    taskActiveLabel = getActiveTaskLabel();
  }

  @override
  Widget build(BuildContext context) {

    var activeTaskLabel = ' ';

    return BlocConsumer<ActiveTaskBloc,ActiveTaskState> (
      listener: (context,state) async {
        activeTaskLabel =  state.activeTaskLabel;
      },
      builder: (context,state) {
        if (state.activeTaskId > 0) {
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
                  activeTaskLabel,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          );
        }
        else {
          return InkWell(
            onTap: () {
              // Get.to(
              //     () => const PickTaskLabel(),
              //     transition: Transition.downToUp,
              //     duration: const Duration(milliseconds: 500)
              // );
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
            )
          );
        }
      }
    );
  }
}