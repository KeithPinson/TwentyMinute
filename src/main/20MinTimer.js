/**
 * Copyright (c) Keith Pinson.
 *
 * Display the 20MinTimer which really consists of two timers;
 * the 20 Minute timer which can be paused to run the second
 * timer (which in the oringinal version of this app was called
 * the Take5 timer. We still call it that and alternatively the
 * Pause Timer in this code.)
 *
 * It should be noted that both the 20 Minute Timer and the
 * Take 5 Timer can visually be count down timers but in reality
 * are stopwatch timers and measure elapsed time until stopped.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */

import React, {Component, useEffect, useState, useRef} from 'react';
import useInterval from 'use-interval'; // Dan Abramov's fix for using intervals with hooks
import {ErrorBoundary} from 'react-error-boundary';
import {
  StyleSheet,
  View,
  Text,
  Dimensions,
  Platform,
  Pressable,
  TouchableNativeFeedback,
  TouchableOpacity,
} from 'react-native';

import Color from '../components/Color';
import TimerGraphic from '../components/TimerGraphic';
import {
  differenceInDays,
  differenceInHours,
  differenceInMinutes,
  differenceInSeconds,
  differenceInMilliseconds,
  isPast,
  subDays,
  subHours,
  subMinutes,
  formatDistance,
  lightFormat,
} from 'date-fns';
import {enUS} from 'date-fns/locale';

const data = Array.from({length: 20}).map(
  (unused, i) => i + (i + 1) * Math.random(),
);

const {width} = Dimensions.get('window');

var activeTimer = true;
var timerPaused = false;
var twentyMinuteStartTime = Date.now();
var twentyMinutePauseTime = Date.now();
const twentyMinutesFormat = 'm:ss';
//const twentyMinutes = 20 * 60 * 1000; // Twenty minutes of milliseconds
const twentyMinutes = 2 * 60 * 1000; // Twenty minutes of milliseconds

function ToggleTimers() {
  timerPaused = !timerPaused;

  const now = Date.now();

  if (timerPaused) {
    // Was running and now paused
    twentyMinutePauseTime = now;
  } else {
    // Was paused and restarting
    twentyMinuteStartTime =
      now - (twentyMinutePauseTime - twentyMinuteStartTime);
  }
}

function TimeRemaining(timeStart, timeNow, millisecondsWanted) {
  var diff = differenceInMilliseconds(timeNow, timeStart);
  var t = timeNow - timeStart;

  if (diff > twentyMinutes) {
    // Catch the first time through loop when timeNow and timeStart aren't in synch
    diff = twentyMinutes;
  }

  t = twentyMinutes - diff;

  if (diff > millisecondsWanted) {
    // Ring the alarm
    activeTimer = false;
    t = 0;
  }

  return lightFormat(t, twentyMinutesFormat);
}

function TimeUsed(timeStart, timeNow) {
  return 'B';
}

export default function TwentyMinuteTimer() {
  //  let [count, setTime] = useState(0);
  let [now, setTime] = useState(Date.now());

  useInterval(() => {
    //    if (activeTimer) {
    //      setTime(count < 60 * 60 * 12 ? count + 1 : 1);
    setTime(activeTimer && !timerPaused ? Date.now() : now);
    //    }
  }, 1000);

  return (
    <View style={[styles.twentyMinuteTime]}>
      <Pressable onPress={ToggleTimers}>
        <TimerGraphic>
          {activeTimer
            ? TimeRemaining(twentyMinuteStartTime, now, twentyMinutes)
            : TimeUsed(twentyMinuteStartTime, now)}
        </TimerGraphic>
      </Pressable>
    </View>
  );
}

/*
      <Text style={styles.twentyMinuteTime}>count: {count}</Text>
      <TimerGraphic>count: {count}</TimerGraphic>


*/

const styles = StyleSheet.create({
  twentyMinuteTime: {
    fontSize: 30,
    backgroundColor: Color.lightBackground,
    color: Color.lightBodyText,
    alignContent: 'center',
    justifyContent: 'center',
  },
});
