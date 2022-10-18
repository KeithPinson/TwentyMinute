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
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
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

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const Background(),
          Column(
            children: <Widget>[
              const TaskLabel(),
              // const HoldTimer(),
              const Timer(),
              Row(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TallyMarks(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
  hexColor = 'FF' + hexColor;
  }
  return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


final customWidth01 =
  CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors01 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: HexColor('#FFD4BE').withOpacity(0.4),
      progressBarColor: HexColor('#F6A881'),
      shadowColor: HexColor('#FFD4BE'),
      shadowStep: 10.0,
      shadowMaxOpacity: 0.6);

final CircularSliderAppearance appearance01 = CircularSliderAppearance(
      customWidths: customWidth01,
      customColors: customColors01,
      startAngle: 270,
      angleRange: 360,
      size: 350.0,
      animationEnabled: false);

final customWidth02 =
  CustomSliderWidths(trackWidth: 5, progressBarWidth: 15, shadowWidth: 30);
final customColors02 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: HexColor('#98DBFC').withOpacity(0.3),
      progressBarColor: HexColor('#6DCFFF'),
      shadowColor: HexColor('#98DBFC'),
      shadowStep: 15.0,
      shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance02 = CircularSliderAppearance(
      customWidths: customWidth02,
      customColors: customColors02,
      startAngle: 270,
      angleRange: 360,
      size: 290.0,
      animationEnabled: false);

final customWidth03 =
  CustomSliderWidths(trackWidth: 8, progressBarWidth: 20, shadowWidth: 40);
final customColors03 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.8),
      trackColor: HexColor('#EFC8FC').withOpacity(0.3),
      progressBarColor: HexColor('#A177B0'),
      shadowColor: HexColor('#EFC8FC'),
      shadowStep: 20.0,
      shadowMaxOpacity: 0.3);

final CircularSliderAppearance appearance03 = CircularSliderAppearance(
      customWidths: customWidth03,
      customColors: customColors03,
      startAngle: 270,
      angleRange: 360,
      size: 210.0,
      animationEnabled: false);


class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white70,
            Colors.blueGrey.shade100,
          ],
        ),
      ),
    );
  }
}

