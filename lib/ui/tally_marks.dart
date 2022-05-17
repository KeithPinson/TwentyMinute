/// Tally marks of completed tasks
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twentyminute/components/tally_marks_cubit.dart';

import 'package:twentyminute/components/timer_bloc.dart';

import '../components/task_controller.dart';

class TallyMarks extends StatelessWidget {
  const TallyMarks({Key? key}) : super(key: key);

  String  getTallyMarks(int? count) {
    var marks = ' '; // '$count';

    return marks;
  }

  //     context.read<TallyMarksCubit>().change();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TimerBloc,TimerState>(
      listener: (context,state) {
        if (state == const TimerRunComplete()) {
          // print( "BlocConsumer: TimerRunComplete" );
        }
      },
      builder: (context,state) {
        // return const Text( "13" );
        if (state == const TimerRunComplete() ) {
          // create: (_) => TallyMarksCubit(0);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Center(
              child: Text(
                getTallyMarks(1),
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
