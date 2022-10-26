/// The main app screen
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';

import 'package:twentyminute/components/alert_bloc.dart';
import 'package:twentyminute/resources/tally_marks_db_query.dart';
import 'package:twentyminute/components/theme_cubit.dart';
import 'package:twentyminute/components/active_task_bloc.dart';
import 'package:twentyminute/components/alert_bloc.dart';
import 'package:twentyminute/components/task_bloc.dart';
import 'package:twentyminute/components/timer_bloc.dart';
import 'package:twentyminute/components/tally_marks_bloc.dart';
import 'package:twentyminute/resources/time_ticks.dart';
import 'package:twentyminute/resources/preferences.dart';
import 'package:twentyminute/ui/tally_marks.dart';
import 'package:twentyminute/ui/task_label.dart';
import 'package:twentyminute/ui/timer.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final timerBloc = TimerBloc(
    ticks: const TimeTicks(),
    durationSeconds: Preference.duration,
  );

  late final activeTaskBloc = ActiveTaskBloc(
    timerBloc: timerBloc,
  );

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(
          create: (BuildContext context) => timerBloc,
        ),
        BlocProvider<ActiveTaskBloc>(
          create: (BuildContext context) => activeTaskBloc,
        ),
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(),
        ),
        BlocProvider<TallyMarksBloc>(
          create: (BuildContext context) => TallyMarksBloc(activeTaskBloc: activeTaskBloc),
        ),
        BlocProvider<AlertBloc>(
          create: (BuildContext context) => AlertBloc(timerBloc: timerBloc),
        ),
      ],
/*
      child: MultiRepositoryProvider(
        providers: [
          // RepositoryProvider(
          //   create: (context) => _authenticationRepository,
          // ),
          RepositoryProvider(
            create: (context) => TaskController(),
          ),
        ],
        child: const HomeScreenView(),
      ),
*/
      child: const HomeScreenView(),
    );
  }
}


/*
Screen
  ...
  Timer
    Running
      Circle countdown animation
      Time Ticking Down
      Tap event will pause timer with a "hold"

    Paused

      Circle holding throb animation
      Time frozen with hold label
      Hold elapsed time throb
      Tap event will remove hold

    Time's Elapsed

      Circle ghost
      Time replace with finish word
      Tap event will allow new task to be picked

    Long Press Menu

      Cancel button
      Mark Done button

  Tally Marks
 */

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  HomeScreenViewState createState() => HomeScreenViewState();
}

class HomeScreenViewState extends State<HomeScreenView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: const <Widget>[
            TaskLabel(),
            // const HoldTimer(),
            Timer(),
            TallyMarks(),
          ],
        ),
      ],
    );
  }
}

