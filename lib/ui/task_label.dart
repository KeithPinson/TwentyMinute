/// Task label
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

class TaskLabel extends StatelessWidget {
  const TaskLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const label = 'Twenty Minute Task';

    return InkWell(
      onTap: () {
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