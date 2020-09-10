/**
 * Copyright (c) Keith Pinson.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 *
 */

import React, {Component, useEffect, useRef, useState} from 'react';

import {
  useDimensions,
  useDeviceOrientation,
} from '@react-native-community/hooks';

import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Platform,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import Color from '../components/Color';
import TwentyMinTimer from './20MinTimer';
import PlatformTheme from '../components/Theme';

/*
<KeyboardAvoidingView
  behavior='position'
  keyboardVerticalOffset={Platform.OS === 'ios' ? 0 : 100}>
  <TouchableWithoutFeedback onPress={() => Keyboard.dismiss()}>
  </TouchableWithoutFeedback>
</KeyboardAvoidingView>
*/

//<TitleBar style={styles.titleBar} />

const App = () => {
  return (
    <>
      {PlatformTheme.hasCustomTitlebar && (
        <View style={styles.titleBar}>
          <Text> </Text>
        </View>
      )}
      <SafeAreaView style={[styles.container]}>
        <View style={styles.header}>
          <Text>Task</Text>
        </View>
        <View style={[styles.body]}>
          <TwentyMinTimer />
        </View>
        <View style={[styles.footer]}>
          <Text>Tick Marks</Text>
        </View>
      </SafeAreaView>
    </>
  );
};

/*
  container: {
    backgroundColor: Color.lighter,
    alignContent: 'center',
    justifyContent: 'center',
  },
*/

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'space-between',
    marginTop: Platform.OS === 'android' ? StatusBar.currentHeight : 0,
    padding: 10,
    backgroundColor: Color.lightBackground,
    alignContent: 'center',
    justifyContent: 'center',
  },
  titleBar: {marginTop: 0, backgroundColor: Color.lightBackground},
  header: {
    flex: 0.15,
    margin: 6,
    fontSize: 24,
    fontWeight: '600',
    color: Color.dark,
    alignItems: 'center',
    justifyContent: 'center',
  },
  body: {
    flex: 0.7,
    color: Color.dark,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: Color.primary,
  },
  footer: {
    flex: 0.15,
    margin: 6,
    color: Color.dark,
    fontSize: 12,
    fontWeight: '600',
    alignItems: 'center',
    justifyContent: 'center',
  },
  h1: {
    fontSize: 32,
    color: Color.dark,
  },
});

export default App;
