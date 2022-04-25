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

class TaskLabel extends StatelessWidget {
  const TaskLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const label = 'Twenty Minute Task';

    return InkWell(
      onTap: () => Get.to(
            () => const PickTaskLabel(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 500)
          ),
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