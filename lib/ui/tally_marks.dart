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
    var marks = ' ';  // */ '5a12';

    return marks;
  }

  //     context.read<TallyMarksCubit>().change();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => TallyMarksCubit(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Center(
          child: BlocBuilder<TallyMarksCubit, TallyMarksState>(
            buildWhen: (previous, current) => previous.tally != current.tally,
            builder: (context, state) {
              return Text(
                getTallyMarks(state.tally),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'TallyMarks',
                  fontSize: 32,
                ),
                // style: Theme.of(context).primaryTextTheme.bodyText1,
              );
            }
          )
        )
      )
    );
  }
}
