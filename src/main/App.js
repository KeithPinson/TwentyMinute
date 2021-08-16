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
  useColorScheme,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import AppColor from '../components/AppColor';
import TwentyMinTimer from './20MinTimer';
import Environment from '../components/Environment';

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
  AppColor.scheme(useColorScheme());

  return (
    <>
      {Environment.hasCustomTitlebar && (
        <View style={styles.titleBar}>
          <Text> </Text>
        </View>
      )}
      <SafeAreaView style={[styles.container]}>
        <View style={styles.header}>
          <Text style={styles.text}>Task</Text>
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
    backgroundColor: AppColor.background(),
    alignContent: 'center',
    justifyContent: 'center',
  },
  titleBar: {marginTop: 0, backgroundColor: AppColor.background()},
  text: {
    color: AppColor.bodyText(),
  },
  header: {
    flex: 0.15,
    margin: 6,
    fontSize: 24,
    fontWeight: '600',
    color: AppColor.bodyText(),
    alignItems: 'center',
    justifyContent: 'center',
  },
  body: {
    flex: 0.7,
    color: AppColor.bodyText(),
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: AppColor.background(),
  },
  footer: {
    flex: 0.15,
    margin: 6,
    color: AppColor.bodyText(),
    fontSize: 12,
    fontWeight: '600',
    alignItems: 'center',
    justifyContent: 'center',
  },
  h1: {
    fontSize: 32,
    color: AppColor.bodyText(),
  },
});

export default App;
