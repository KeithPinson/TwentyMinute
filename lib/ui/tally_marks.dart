/// Tally marks of completed tasks
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:twentyminute/components/timer_bloc.dart';

import '../components/tally_marks_controller.dart';

class TallyMarks extends StatelessWidget {
  const TallyMarks({Key? key}) : super(key: key);

  String  getTallyMarks(int? count) {
    var marks = ' ';

    if (count != null && count > 0) {
      var rem20 = count % 20;
      var div20 = count ~/ 20;

      var rem5 = rem20 % 5;
      var div5 = rem20 ~/ 5;

      // 5AFK
      var chars =
        ['1','2','3','4','5', '6','7','8','9','A',
         'B','C','D','E','F', 'G','H','I','J','K'];

      // Groups of 4 by 5
      for (var t = div20; t > 0; t--) {
        marks = marks + chars[5-1] + chars[10-1] + chars[15-1] + chars[20-1];
      }

      // The last 5s
      for (var f = 1; f <= div5; f++) {
        marks = marks + chars[(5*f)-1];
      }

      if (rem5 > 0) {
        marks = marks + chars[(div5 * 5) + rem5 - 1];
      }
    }

    return marks;
  }

  @override
  Widget build(BuildContext context) {

    int marks = 0;

    return BlocConsumer<TimerBloc,TimerState> (
      listener: (context,state) async {
        if (state == const TimerRunComplete()) {
          marks = await getTallyMarkCountToday();
          // marks = 0;
        }
      },
      builder: (context,state) {
        if (state == const TimerRunComplete() ) {

          var tallyMarks = getTallyMarks(marks);
          var l = tallyMarks.length;

          // Clip the tallymarks to fit on one line
          if (l > 9) {
            tallyMarks = tallyMarks.substring(l - 9, l);
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Center(
              child: Text(
                tallyMarks,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'TallyMarks',
                  fontSize: 32,
                ),
                // style: Theme.of(context).primaryTextTheme.bodyText1,
              )
            )
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Center(
              child: Text(
                ' ',
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
      },
    );
  }
}
