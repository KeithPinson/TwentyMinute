/// Countdown Timer
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:twentyminute/components/timer_bloc.dart';
import 'package:twentyminute/resources/preferences.dart';


class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
    ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0),
        child: Center(
            child: Text(
              '$minutesStr:$secondsStr',
              style: Theme.of(context).textTheme.headline1,
            )
        )
    );
  }
}


class Timer extends StatelessWidget {
  const Timer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            // Transition from state to event
            if (state is TimerRunReady) {
              context.read<TimerBloc>().add(const TimerStart(duration: Preference.duration));
            }
            if (state is TimerRunInProgress) {
              context.read<TimerBloc>().add(const TimerPause());
            }
            if (state is TimerRunPaused) {
              context.read<TimerBloc>().add(const TimerResume());
            }
            if (state is TimerRunCompleted || state is TimerRunCanceled) {
              context.read<TimerBloc>().add(const TimerSet());
            }
          },
          onLongPress: () {
            const snackBar = SnackBar(content: Text('Long Press'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // context.read<TimerBloc>().add(TimerReset())
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Center(child: TimerText()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


