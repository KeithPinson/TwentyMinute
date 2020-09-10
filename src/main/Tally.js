/**
 * Copyright (c) Keith Pinson.
 *
 * Display and record completed tasks. The timer will tell us
 * when a twenty minute task is completed.
 *
 * @see [[LICENSE]] file in the root directory of this source.
 */

import AsyncStorage from '@react-native-community/async-storage';

const storeData = async (value) => {
  try {
    const jsonValue = JSON.stringify(value);
    await AsyncStorage.setItem('@storage_Key', jsonValue);
  } catch (e) {
    // saving error
  }
};

const getData = async () => {
  try {
    const jsonValue = await AsyncStorage.getItem('@storage_Key');
    return jsonValue != null ? JSON.parse(jsonValue) : null;
  } catch (e) {
    // error reading value
  }
};
