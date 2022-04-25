/// Tally marks of completed tasks
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

class TallyMarks extends StatelessWidget {
  const TallyMarks({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const marks = ' ';
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60.0),
      child: Center(
        child: Text(
          marks,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'TallyMarks',
            fontSize: 32,
          ),
          // style: Theme.of(context).primaryTextTheme.bodyText1,
        )
      )
    );
  }
}

