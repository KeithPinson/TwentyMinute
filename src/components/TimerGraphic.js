/**
 * Copyright (c) Keith Pinson.
 *
 * A graphic to go along with the count down
 * numbers.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */
import React from 'react';
import PropTypes from 'prop-types';

import {ErrorBoundary} from 'react-error-boundary';

import {
  StyleSheet,
  View,
  Text,
  Dimensions,
  Platform,
  TouchableNativeFeedback,
  TouchableOpacity,
} from 'react-native';

import Color from '../components/Color';
import AppTheme from '../components/Theme';

const TimerGraphic = (props) => {
  const {
    versionNumber,
    children,
    onLayout,
    style,
    textStyle,
    timerTheme,
    testOnly_timerGraphic,
  } = props;

  return (
    <ErrorBoundary fallback={<Text>Oh no</Text>}>
      <View style={[styles.timerBorder]}>
        <View style={[styles.timerGraphic]}>
          <Text style={[styles.timerText]}>{children}</Text>
        </View>
      </View>
    </ErrorBoundary>
  );
};

TimerGraphic.propTypes = {
  children: PropTypes.node.isRequired,
};

TimerGraphic.defaultProps = {
  versionNumber: 1,
};

/*
          <Text style={[theme.text, textStyle]}>{children}</Text>

TimerGraphic.themeConfig = {
  props: {},
  style: {
    base: {
      position: 'relative',
      backgroundColor: Color.primary,
      minHeight: 50,
      borderRadius: 10,
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      paddingVertical: 15,
      paddingHorizontal: 25,
    },
    text: {
      color: Color.dark,
      fontSize: 14,
    },
  },
};
*/

const styles = StyleSheet.create({
  timerBorder: {
    flexGrow: 0,
    backgroundColor: Color.lightBackground,
    alignContent: 'center',
    justifyContent: 'center',
    margin: 6,
    padding: 2,
  },
  timerGraphic: {
    minHeight: 120,
    minWidth: 120,
    flexGrow: 0,
    backgroundColor: Color.lightBackground,
    color: Color.lightHeaderText,
    alignContent: 'center',
    justifyContent: 'center',
    borderColor: Color.lightAccentMedium,
    borderWidth: 3,
    borderRadius: 60,
  },
  timerText: {
    flexGrow: 0,
    color: Color.lightHeaderText,
    fontSize: 30,
    padding: 6,
    textAlign: 'center',
    textAlignVertical: 'center',
  },
});

export default TimerGraphic;
