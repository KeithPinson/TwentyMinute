/// Task label
///
/// Show the Task Label and allow it to be picked
/// if not set.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyminute/ui/pick_task_label.dart';
import 'package:twentyminute/ui/task_controller.dart';

class TaskLabel extends StatelessWidget {
  TaskLabel({Key? key}) : super(key: key);
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    const label = 'Twenty Minute Task';

    return InkWell(
      onTap: () {
        Get.to(
            () => const PickTaskLabel(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500)
        );
        const snackBar = SnackBar(content: Text('on tap'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 11.0),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      )
    );
  }
}