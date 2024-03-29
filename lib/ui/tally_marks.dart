/// Tally marks of completed tasks
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twentyminute/components/tally_marks_bloc.dart';
import 'package:twentyminute/components/tally_marks_controller.dart';


class TallyMarks extends StatefulWidget {
  const TallyMarks({Key? key}) : super(key: key);

  @override
  TallyMarksState createState() => TallyMarksState();
}


class TallyMarksState extends State<TallyMarks> {
  late Future<String> marks;

  Future<String> getTallyMarks(count) async {
    var marks = ' ';

    if (count > 0) {
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

      // Clip the tally marks to fit on one line
      var l = marks.length;

      if (l > 9) {
        marks = marks.substring(l - 9, l);
      }
    }

    return marks;
  }

  @override
  void initState() {
    super.initState();

    var count = getTallyMarksCountToday();

    marks = getTallyMarks(count);
  }

  @override
  Widget build(BuildContext context) {

    var tallyMarks = ' ';
    // tallyMarks = 'AAAAAAAAAAAAAAAAAAAAAA';

    return BlocConsumer<TallyMarksBloc,TallyMarksBlocState> (
      listener: (context,state) async {
        if (state is TallyMarksCounted ) {
          tallyMarks = await getTallyMarks(state.tally);
        }
      },
      buildWhen: (previous, current) => previous.tally != current.tally,
      builder: (context,state) {
        if (state is TallyMarksCounted) {

          return
          InkWell(
              hoverColor: Colors.blueGrey.shade100,
              onTap: () => {
                // setState(() { hoverLeft = false; }),
              },
              onHover: (hovering) => {
                // setState(() { hoverTally = hovering; }),
              },
              child:
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child:
              Center(
                  child:
                Wrap(
                    children: [
                  Text(
                      tallyMarks,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontFamily: 'TallyMarks',
                        fontSize: 32,
                      )
                  ),
                ])
              )
            )
          );
        } else {
          return
          InkWell(
              hoverColor: Colors.blueGrey.shade100,
              onTap: () => {
                // setState(() { hoverLeft = false; }),
              },
              onHover: (hovering) => {
                // setState(() { hoverTally = hovering; }),
              },
              child:
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child:
              Center(
                  child:
                Wrap(
                    children: [
                  Text(
                      tallyMarks,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontFamily: 'TallyMarks',
                        fontSize: 32,
                      ),
                  ),
                ],)
              ),
            ),
          );
        }
      },
    );
  }
}
